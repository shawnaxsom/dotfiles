// Resources:
// * JavaScript Config: https://github.com/jigish/slate/wiki/JavaScript-Configs
// * Layouts: https://github.com/jigish/slate/wiki/Layouts
// * Operations: https://github.com/jigish/slate/wiki/Operations

// Create the various operations used in the layout
const hide = app => slate.operation("hide", {app});
const focus = app => slate.operation("focus", {app});

const maximize = slate.operation("push", {
  screen: "0",
  direction: "left",
  style: "bar-resize:screenSizeX",
});

const push = (direction, divisor = "2") => {
  if (direction.indexOf("-") >= 0) {
    return slate.operation("corner", {
      direction,
      width: `screenSizeX/${divisor}`,
      height: `screenSizeY/${divisor}`,
      screen: 0,
    });
  }

  return slate.operation("push", {
    screen: "0",
    direction,
    style: `bar-resize:screenSizeX/${divisor}`,
  });
};

const basicLayout = (name, apps, before = {}) => {
  let layoutLocationOrder = ["left", "top-right", "bottom-right", "bottom-left"];
  if (apps.length >= 4) {
    layoutLocationOrder = [
      "top-left",
      "bottom-left",
      "top-right",
      "bottom-right",
    ];
  }

  const layout = {
    _before_: before,
    _after_: {
      operations: apps.filter(app => app).map(app => focus(app)).reverse(),
    },
  };

  for (let i = 0; i < apps.length; i++) {
    let app = apps[i];

    if (app) {
      if (apps.length == 1) {
        slate.log("FOOO1", name, app, "maximize");
        layout[app] = {
          operations: [maximize],
          "ignore-fail" : true, // Chrome has issues sometimes so I add ignore-fail so that Slate doesn't stop the
          // layout if Chrome is being stupid.
          "repeat" : true // Keep repeating the function above for all windows in Chrome.
        };
      } else if (apps.length === 2 && i + 1 === 2) {
        slate.log("FOOO2", name, app, "right");
        layout[app] = {
          operations: [push("right")],
          "ignore-fail" : true, // Chrome has issues sometimes so I add ignore-fail so that Slate doesn't stop the
          // layout if Chrome is being stupid.
          "repeat" : true // Keep repeating the function above for all windows in Chrome.
        };
      } else {
        layout[app] = {
          operations: [push(layoutLocationOrder[i])],
          "ignore-fail" : true, // Chrome has issues sometimes so I add ignore-fail so that Slate doesn't stop the
          // layout if Chrome is being stupid.
          "sort-title" : true,
          "repeat" : true // Keep repeating the function above for all windows in Chrome.
        };
      }
    }
  }

  return slate.layout(name, layout);
};

const bindLayout = (key, windows, before) =>
  slate.bind(
    key,
    slate.operation("layout", {name: basicLayout(key, windows, before)}),
  );

bindLayout("`:alt", ["iTerm2"]);
bindLayout("1:alt", ["iTerm2", "Google Chrome"]);
bindLayout("2:alt", ["iTerm2", "Google Chrome", null], {
  operations: () => slate.window().app().name() !== "iTerm2" && slate.window().app().name() !== "iTerm2" && slate.window().doOperation(push("bottom-right"))
});
bindLayout("3:alt", ["iTerm2", "Google Chrome", "Slack", "Robo 3T"]);
bindLayout("q:alt", ["iTerm2"]);
bindLayout("w:alt", ["Google Chrome"]);
bindLayout("e:alt", ["Slack"]);
bindLayout("r:alt", ["Robo 3T"]);
bindLayout("t:alt", ["Trello"]);
bindLayout("s:alt", ["Spotify", "Google Chrome"]);

// slate.bind("q:alt", push("top-left"));
// slate.bind("w:alt", push("top", "3"));
// slate.bind("e:alt", push("top-right"));
// slate.bind("a:alt", push("left"));
// slate.bind("s:alt", maximize);
// slate.bind("d:alt", push("right"));
// slate.bind("z:alt", push("bottom-left"));
// slate.bind("x:alt", push("bottom", "3"));
slate.bind("c:alt", push("bottom-right"));
