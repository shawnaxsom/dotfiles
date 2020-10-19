if which xset
  xset r rate 225 28
end

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
alias .......='../../../../../..'
alias ........='../../../../../../..'

set -x TERM xterm-256color
# set -x EDITOR /usr/bin/vim
set -x EDITOR "/usr/local/bin/nvim -u ~/.config/nvim/init.vim"


alias mux='tmuxinator'
alias surf='surf google.com'
alias ack='ack-grep'
alias forecast='grc -es --colour=auto weather ind -f'

export TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_FINAL_FILTER='~/Dropbox/todo/futureTasks'
# alias todo='todo.sh'
# alias t='todo.sh'
# alias tls='todo.sh ls'
alias next='tls -F "     %z %p |%i| %s %k (due:%D)" -n 3'
# alias today='t ls -F "     %z %p |%i| %s %k (due:%D)" "due:<=0d"'
# alias today='tls -g desc:due --'
alias today='tls "due:<=0d"'
alias tomorrow='tls "due:<=1d"'
alias due='today'
alias day='today'
alias tomorrow='t ls "due:<=1d"'
# alias td='today'
alias work='t ls -n 10 -F "     %z %p |%i| %s %k (due:%D)" @work'
# alias work='tls -n 15 -- -@reading -@learning -@syrus -@home -@productivity -@thedaily -@recruiting -@improvement -@focus -@inputs -@wth -@books -@family -@groceries -@shopping -@outing -@restaurants -@restaurant -@list -@habits -@background -+background'
alias important='tls -g importance'
alias a='tls "(A)"'
alias b='tls "(B)"'
alias c='tls "(C)"'
alias d='tls "(D)"'
alias e='tls "(E)"'
alias quick='work @quick'
alias now='t ls -F "     %z %p |%i| %s %k (due:%D)" @now'
alias must='t ls -F "     %z %p |%i| %s %k (due:%D)" @must'
alias should='t ls -F "     %z %p |%i| %s %k (due:%D)" @should'
alias could='t ls -F "     %z %p |%i| %s %k (due:%D)" @could'
alias notnow='t ls -g importance -n 15 -- @work -@now'
alias long='work @long'
alias recruiting='tls -n 10 @recruiting'
alias home='tls -n 10 @home'
alias reading='t ls -n 10 -g priority @reading'
alias learning='tls -n 10 @learning'
alias improvement='tls -n 10 @improvement'
alias productivity='tls -n 10 @productivity'
alias leslie='tls -n 10 @leslie'
alias focus='tls -F "      |%i| %s" -n 5 @focus'
alias inputs='tls -F "      |%i| %s" -n 5 @inputs'
alias tm='tomorrow'
alias todo='clear && topydo -t ~/todo.txt -d ~/done.txt'
alias t='clear && topydo -t ~/todo.txt -d ~/done.txt'
# alias tdo='t do'
alias td='tdo'
# alias tls='clear && topydo -t ~/todo.txt -d ~/done.txt ls -n 15 -F "     %z %p |%i| %s %k (due:%D)" --'
alias tpr='t lsproj'
# alias ta='t add'
alias te='t edit -e'
alias tet='t edit -e "due:<=0d"'
alias tew='t edit -e "due:<=0d" @work'
alias tp='topydo -t ~/todo.txt -d ~/done.txt prompt'
alias tc='topydo -t ~/todo.txt -d ~/done.txt columns'

function ta
  t add $argv $LAST_TLS_ARGS
  eval $LAST_TLS_COMMAND
  # topydo -t ~/todo.txt -d ~/done.txt ls -n 15 -F "     %z %p |%i| %s %k (due:%D)" -- $argv
end
function tdo
  t do $argv
  eval $LAST_TLS_COMMAND
end
function tls
  set command (string join " " (status current-command) $argv)

  clear
  # echo $command
  topydo -t ~/todo.txt -d ~/done.txt ls -n 15 -F "     %z %p |%i| %s %k (due:%D)" -- $argv

  if string match -q '*tls*' $command
    set -gx LAST_TLS_COMMAND (string join " " (status current-command) $argv)
    set -gx LAST_TLS_ARGS $argv
  end
end
alias tl=tls
function tmux
  if test (count $argv) = 0
    tmux new-session -s (bash -c 'echo ${PWD##*/}')
  else
    /usr/local/bin/tmux $argv
  end
end

function google
  elinks "https://www.google.com/search?q=$argv"
end

function replace
  find . -type f -print0 | xargs -0 /bin/sed -i '$argv'
end

function search
  ag $argv | /usr/local/share/pathpicker/fpp
end

function agfzf
  vim (ag $argv | awk -F: '{ print $1 }' | fzf --preview "ag -B 5 -A 5 $argv {}")
end

function fzfp
  awk -F: '{ print $1 }' | fzf --preview "cat {}"
end



[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

if test -d ~/Library/Android/sdk/platform-tools
  set -gx PATH ~/Library/Android/sdk/platform-tools $PATH
end

if test -d ~/Library/Python/2.7/bin/
  # Needed for Elastic Beanstalk CLI
  set -gx PATH ~/Library/Python/2.7/bin/ $PATH
end

if test -d ~/Library/Python/3.4/bin/
  # Needed for Elastic Beanstalk CLI
  set -gx PATH ~/Library/Python/3.4/bin/ $PATH
end

if test -d ~/.cargo/bin
  set -gx PATH ~/.cargo/bin $PATH
end

if test -d /usr/local/Cellar/ruby/2.6.3/bin/
  set -gx PATH /usr/local/Cellar/ruby/2.6.3/bin/ $PATH
end

if test -d /usr/local/opt/qt/bin/
  set -gx PATH /usr/local/opt/qt/bin/ $PATH
end

if test -d /Users/shawnaxsom/.gem/ruby/2.3.0/bin/
  set -gx PATH /Users/shawnaxsom/.gem/ruby/2.3.0/bin/ $PATH
  set -gx PATH /Library/Ruby/Gems/2.3.0/gems/ $PATH
end

if test -d /Users/shawnaxsom/.rvm/bin/
  set -gx PATH /Users/shawnaxsom/.rvm/bin/ $PATH
end

# https://hub.github.com/
alias git='hub'


function dps
  docker ps $argv | awk -F '[ ][ ]+' '{ print $1 "%" $2 "%" $3 }' | column -s "%" -t
end
function dpsi
  # Docker PS interactive - return ID to be used in other commands
  dps $argv | fzf | awk '{ print $1 }'
end

function dlog
  # docker ps | awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs 2>&1 | vim -
  docker ps | awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs 2>&1
end
function dloga
  # docker ps -a | awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs 2>&1 | vim -R -
  docker ps -a | awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs 2>&1
end
alias dl='dloga'
function dlogatail
  docker ps -a | awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs 2>&1  --tail 10
end
function dlogwatch
  docker ps -a | awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs 2>&1  --follow
end
function dstop
  set id (dpsi)
  docker stop $id
end

function psf
  # ps FZF, returning the ID to feed into other commands
  ps -o pid,command | fzf --preview="ps {1}" --preview-window=down:8:wrap --header-lines=1 | awk '{ print $1 }'
end

alias cleanup='gd | grep "console.log\|print(\|debugger\|TODO"'
alias gP='git push'
alias ga='git add .'
alias gb='git branch'
alias gc-='git checkout -'
alias gc='git commit'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gd='git diff'
alias gdm='git diff master..'
alias gdq='git diff quality..'
alias gf='git fetch'
alias gh='git browse'
alias pulls='git browse -- pulls/shawnaxsom'
alias p=pulls
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit '
alias glp='git log -p'
alias gmm='git fetch; git merge origin/master'
alias grm='git fetch; git rebase origin/master'
# alias gp='git pull; and echo; and git push; and echo; and git status; and echo'
alias gp='git pull; and echo; and git status; and echo'
# alias gpr='hub pull-request --edit -F ~/.PULL_REQUEST_TEMPLATE.md'
alias pr='hub pull-request --edit'
alias gpr=pr
alias gs='git status'
alias gyesterday='git log --since="yesterday"'

function prforcommit
  # https://hub.github.com/
  open (hub api graphql --flat -f q="repo:docker/saas-mega type:pr $argv" -f query='
    query($q: String!) {
      search(query: $q, type: ISSUE, first: 3) {
        nodes {
          ... on PullRequest {
            url
          }
        }
      }
    }
  ' | awk '/\.url/ { print $2 }')
end

# Shows changes I made from all branches, helpful to document what I worked on
alias gweek='git log --pretty=format:"%ad:%an:%d:%B" --date=relative --all --since=1.week.ago --author=".*hawn.*"'

function gcount
  # Count number of lines changed in branch
  git log --numstat --pretty="%H" origin/master.. | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}'
end

alias gwc='git whatchanged --author=".*hawn.*" --no-commit-id --name-only --since="5 days ago"'
# Files I have added in the last 5 days
alias gwca='git whatchanged --author=".*hawn.*" --diff-filter=A --no-commit-id --name-only --since="5 days ago"'

# All files created/added in feature branch
alias gcreated='git log origin/master...  --pretty=oneline --name-status . | g "^A" | sort | uniq'
alias gadded=gcreated
# All files modified in feature branch
alias gmodified='git log origin/master...  --pretty=oneline --name-status . | g "^M" | sort | uniq'
# All files created/added or modified in feature branch
alias gchanged='git log origin/master...  --pretty=oneline --name-status . | g "^[AM]" | sort | uniq'

# Revert to a certain date
# Can use relative time, like 6 months ago
function gcheckoutdate
  git checkout (git rev-list -n 1 --before="*$argv*" master)
end

alias vs='vim -S'

function deletevimsession
  if test -e $PWD/Session.vim
    rm $PWD/Session.vim
  end
end

# Open vim with buffers for files edited in most recent commits
function recent
  deletevimsession

  set commitsToInclude 4

  if test (count $argv) = 1
    set commitsToInclude "$argv"
  end

  # git diff --name-only --author=shawnaxsom --line-prefix=(git rev-parse --show-toplevel)/ HEAD~$commitsToInclude .
  set result (git log --pretty="format:%n" --author=axs --name-only --line-prefix=(git rev-parse --show-toplevel)/ HEAD~ --since=@{$commitsToInclude} | sort | uniq | grep "\S" | grep -v (string join "" (git rev-parse --show-toplevel) "/\$"))

  if test -z (echo $result)
    git log --pretty="format:%n" --name-only --line-prefix=(git rev-parse --show-toplevel)/ --since=@{$commitsToInclude} | sort | uniq | grep "\S" | grep -v (string join "" (git rev-parse --show-toplevel) "/\$")
  else
    git log --pretty="format:%n" --author=axs --name-only --line-prefix=(git rev-parse --show-toplevel)/ --since=@{$commitsToInclude} | sort | uniq | grep "\S" | grep -v (string join "" (git rev-parse --show-toplevel) "/\$")
  end
end
alias r='recent'
alias vimrecent='vim (recent)'
alias vr='vimrecent'

function changed
  deletevimsession
  # git ls-files -m --full-name --line-prefix=(git rev-parse --show-toplevel)/
  git ls-files -mo --exclude-standard --full-name . | awk -F / (string join "" '{print "' (git rev-parse --show-toplevel) '/"$0}') | uniq
end
alias vimchanged='vim (changed)'
alias c='changed'
alias vc='vimchanged'

# Load Vim buffers with both most recently changed and currently modified
function cr
  string join \n (recent $argv) (changed)
end
alias vcr='vim (cr)'
alias vrc='vcr'

alias g='grep'
alias gv='grep -v -e '
# alias c='cd'
alias l='ls'
alias lt='ls -lat'
alias h='head'
# alias t='tail'
# alias r='ranger'
# alias p='pwd'
alias x='exit'
alias vp='/usr/local/bin/nvim -c "set ft=man modifiable"  -'
alias page='/usr/local/bin/nvim -c "set ft=man modifiable"  -'

# Show ports used by node processes
alias ports='sudo lsof -iTCP -sTCP:LISTEN -P | grep node'

# alias f='find . -name'

# Git Prune Merged
function gprune
  git branch --merged master | grep -v 'master' | xargs git branch -d
  git branch
end

function f
  find . -name "*$argv*" | grep $argv
end

function gR
  git reset --hard;
  git clean -df;
end

function gac
  git add .;
  git commit -m $argv;
end

function gacp
  git add .;
  git commit -m $argv;
  git push;
end

# if test -e /usr/local/Cellar/vim/8.0.0130/bin/vim
#   set vim '/usr/local/Cellar/vim/8.0.0130/bin/vim'
# else
#   set vim '/usr/local/bin/vim'
# end
# function vim_session
#   # Vim Abolish uses vim -S / mksession. Use :Abolish to start tracking a project. This will load the last session / open files.
#   if test -e $PWD/Session.vim
#     env NODE_PATH="src" $vim $PWD/Session.vim $argv -S
#   else
#     env NODE_PATH="src" $vim $argv
#   end
# end
# alias v='vim_session'
# alias vim='vim_session'

set nvim '/usr/local/bin/nvim'
function nvim_session
  # Vim Abolish uses vim -S / mksession. Use :Abolish to start tracking a project. This will load the last session / open files.
  if test (count $argv) = 1
      /usr/local/bin/nvim $argv
  else
    if test -e $PWD/Session.vim
      # env NODE_PATH="src" $nvim $argv -S
      /usr/local/bin/nvim $argv -S
    else
      /usr/local/bin/nvim $argv
    end
  end
end
alias nv='nvim_session'
alias nvim='nvim_session'
alias v='nvim_session'
alias vim='nvim_session'


alias do-horizonal='ssh -i ~/.ssh/id_rsa root@67.205.177.3'
alias aws-horizonal='ssh -i ~/.ssh/ShawnEC2.pem ubuntu@52.206.194.188'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

# VirtualFish - Python virtualenv wrapper
set -x VIRTUALFISH_HOME ~/.virtualenvs
# set -x VIRTUALFISH_DEFAULT_PYTHON python3.6
# alias python='python3.6'
# alias python3='python3.6'
# eval (python3.6 -m virtualfish)
# alias pip='pip3.6'
# eval (python -m virtualfish)

function clear_screen
  # https://stackoverflow.com/questions/2198377/how-to-clear-previous-output-in-terminal-in-mac-os-x
  # Don't just move screen down on Mac, actually clear the screen as well
  clear; and printf '\e[3J'
end

function test_on_change
  echo "$argv"
  chokidar '**/*.js' --ignore "*.tmp*" --debounce 1500 --initial --throttle 0 --ignore "node_modules" -c "clear_screen; and npm run unit -- --tests $argv"
end

function run_on_change
  echo "$argv"
  chokidar '**/*.{js,jsx,ts,tsx}' --ignore "*.tmp*" --debounce 1500 --initial --throttle 0 --ignore "node_modules" -c "clear_screen; and $argv"
end

function rebuild
  cd ~/dev/ambyint/packages; and npm start /Users/shawn.axsom/dev/ambyint/packages; and cd -;
end

# React Native
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $PATH $ANDROID_HOME/emulator
set -gx PATH $PATH $ANDROID_HOME/tools
set -gx PATH $PATH $ANDROID_HOME/tools/bin
set -gx PATH $PATH $ANDROID_HOME/platform-tools

# Golang
set -gx GOPATH $HOME/go

# This takes a second to run, so using hard-coded path instead
# set -gx GOROOT (brew --prefix golang)/libexec
# set -gx PATH /usr/local/go/bin $PATH
set -gx GOROOT /usr/local/opt/go/libexec
set -gx PATH $PATH $GOPATH/bin
set -gx PATH $PATH $GOROOT/bin
set -gx GOPRIVATE github.com/docker

# Fastlane for React Native development
set -x PATH $HOME/.fastlane/bin $PATH



# FZF
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --no-sort --exact --no-preview'


# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/shawnaxsom/dev/fsri-lms/lambda/node_modules/tabtab/.completions/slss.fish ]; and . /Users/shawnaxsom/dev/fsri-lms/lambda/node_modules/tabtab/.completions/slss.fish

alias emacs="/usr/local/bin/emacs"

# Created by `userpath` on 2020-10-01 00:06:52
set PATH $PATH /Users/shawnaxsom/.local/bin

# Joplin CLI
if test -d ~/.joplin-bin/bin/
  set -gx PATH ~/.joplin-bin/bin/ $PATH
end
alias joplin="joplin --profile ~/.config/joplin-desktop/"
alias jo=joplin
alias jop=joplin

# GPG agent
set GPG_AGENT_FILE "$HOME/.gpg-agent-info"
function start_gpg_agent
  gpg-agent --daemon --write-env-file $GPG_AGENT_FILE
end
if which gpg-agent > /dev/null
  # start agent if there's no agent file
  if [ ! -f $GPG_AGENT_FILE ]
    eval ( start_gpg_agent )
  else
    # check agent works
    source $GPG_AGENT_FILE
    set SOCKET (echo "$GPG_AGENT_INFO"  | cut -d : -f 1)
    # check agent connection
    set AGENTCONNECTION ( ! nc -U $SOCKET < /dev/null | grep -q "OK Pleased to meet you" )
    if "$AGENTCONNECTION"
      eval ( start_gpg_agent )
    end
  end
  set -gx GPG_TTY (tty)
end
