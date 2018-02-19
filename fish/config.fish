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
set -x EDITOR /usr/local/bin/vim

alias mux='tmuxinator'
alias calw='gcalcli --calendar="Shawn Axsom" --calendar="shawn.axsom@rooksecurity.com" calw 2'
alias calm='gcalcli --calendar="Shawn Axsom" --calendar="shawn.axsom@rooksecurity.com" calm'
alias cal='gcalcli --calendar="shawn.axsom@rooksecurity.com"'
alias calhome='gcalcli --calendar="Shawn Axsom"'
alias calwork='gcalcli --calendar="shawn.axsom@rooksecurity.com"'
alias todo='todotxt-machine'
alias surf='surf google.com'
alias ack='ack-grep'
alias forecast='grc -es --colour=auto weather ind -f'

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
  vim (ag $argv | awk -F: '{ print $1 }' | fzf --preview "ag -B 15 -A 15 $argv {}")
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
  docker ps | awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs
end
function dloga
  docker ps -a | awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs
end
function dlogatail
  docker ps -a | awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs --tail 20
end
function dlogwatch
  watch "fish -c 'dlogatail $argv'"
end
function dstop
  set id (dpsi)
  docker stop $id
end
# function dlog
#   awk "/$argv/ { print \$1 }" | head -1 | xargs docker logs
# end

function psf
  # ps FZF, returning the ID to feed into other commands
  ps -o pid,command | fzf --preview="ps {1}" --preview-window=down:8:wrap --header-lines=1 | awk '{ print $1 }'
end

alias gP='git push'
alias ga='git add .'
alias gb='git branch'
alias gc-='git checkout -'
alias gc='git commit'
alias gcm='git checkout master'
alias gd='git diff'
alias gdm='git diff master..'
alias gdq='git diff quality..'
alias gf='git fetch'
alias gh='git browse'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit '
alias glp='git log -p'
alias gmm='git fetch; git merge origin/master'
alias grm='git fetch; git rebase origin/master'
alias gp='git pull; and echo; and git push; and echo; and git status; and echo'
alias gpr='hub pull-request --edit -F ~/.PULL_REQUEST_TEMPLATE.md'
alias gs='git status'
alias gyesterday='git log --since="yesterday"'

function gcount
  # Count number of lines changed in branch
  git log --numstat --pretty="%H" origin/master.. | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}'
end

alias gwc='git whatchanged --author=".*hawn.*" --no-commit-id --name-only --since="5 days ago"'
# Files I have added in the last 5 days
alias gwca='git whatchanged --author=".*hawn.*" --diff-filter=A --no-commit-id --name-only --since="5 days ago"'

# All files created/added in feature branch
alias gcreated='git log origin/master...  --pretty=oneline --name-status . | gv test | g "^A" | sort | uniq'
# All files modified in feature branch
alias gmodified='git log origin/master...  --pretty=oneline --name-status . | gv test | g "^M" | sort | uniq'
# All files created/added or modified in feature branch
alias gchanged='git log origin/master...  --pretty=oneline --name-status . | gv test | g "^[AM]" | sort | uniq'

alias vs='vim -S'
alias g='grep'
alias gv='grep -v -e '
alias c='cd'
alias l='ls'
alias lt='ls -lat'
alias h='head'
alias t='tail'
alias r='ranger'
alias p='pwd'
alias x='exit'
alias vp='/usr/local/bin/nvim -c "set ft=man modifiable"  -'
alias page='/usr/local/bin/nvim -c "set ft=man modifiable"  -'

# Show ports used by node processes
alias ports='sudo lsof -iTCP -sTCP:LISTEN -P | grep node'

# alias f='find . -name'

# Git Prune Merged
function gprune
  git branch --merged master | grep -v 'master' | xargs git branch -d
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
