// Resources:
// * JavaScript Config: https://github.com/jigish/slate/wiki/JavaScript-Configs
// * Layouts: https://github.com/jigish/slate/wiki/Layouts
// * Operations: https://github.com/jigish/slate/wiki/Operations

// Create the various operations used in the layout
const hide = app => slate.operation("hide", { app });
const focus = app => slate.operation("focus", { app });

const maximize = slate.operation("push", {
  screen: "0",
  direction: "left",
  style: "bar-resize:screenSizeX"
});

const push = direction => {
  if (direction.indexOf("-") >= 0) {
    return slate.operation("corner", {
      direction,
      width: "screenSizeX/2",
      height: "screenSizeY/2",
      screen: 0
    });
  }

  return slate.operation("push", {
    screen: "0",
    direction,
    style: "bar-resize:screenSizeX/2"
  });
};


const basicLayout = (name, apps) => {
  let layoutLocationOrder = ["left", "top-right", "bottom-right"];
  if (apps.length >= 4) {
    layoutLocationOrder = ["top-left", "bottom-left", "top-right", "bottom-right"];
  }

  const layout = {
    // _before_: {operations: push("bottom-right")},
    _after_: {operations: apps.filter(app => app).map(app => focus(app)).reverse()},
  };

  for (var i = 0; i < apps.length; i++) {
    const app = apps[i];

    if (app) {
      if (apps.length == 1) {
        layout[app] = {
          operations: [maximize]
        }
      } else if (apps.length === 2 && i + 1 === 2) {
        layout[app] = {
          operations: [push("right")]
        }
      } else {
        layout[app] = {
          operations: [push(layoutLocationOrder[i])]
        }
      }
    }

  }

  return slate.layout(name, layout);
};

const bindLayout = (key, windows) => slate.bind(key, slate.operation("layout", { name: basicLayout(key, windows) }));
bindLayout("`:alt", ["iTerm2"]);
bindLayout("1:alt", ["iTerm2", "Google Chrome"]);
bindLayout("2:alt", ["iTerm2", "Google Chrome", null]);
bindLayout("3:alt", ["iTerm2", "Google Chrome", "Slack"]);
bindLayout("4:alt", ["iTerm2", "Google Chrome", "Slack", "Trello"]);

slate.bind("q:alt", push("top-left"));
slate.bind("w:alt", push("top"));
slate.bind("e:alt", push("top-right"));
slate.bind("a:alt", push("left"));
slate.bind("s:alt", maximize);
slate.bind("d:alt", push("right"));
slate.bind("z:alt", push("bottom-left"));
slate.bind("x:alt", push("bottom"));
slate.bind("c:alt", push("bottom-right"));

// var switcher = slate.operation("switch");
// slate.bind("f:alt", switcher);
var switcher = slate.operation("switch");
slate.bind("tab:cmd", switcher);
