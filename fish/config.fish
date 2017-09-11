if which xset
  xset r rate 225 28
end

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
alias .......='../../../../../..'
alias ........='../../../../../../..'

if test -e /usr/local/Cellar/vim/8.0.0130/bin/vim
  alias vim='/usr/local/Cellar/vim/8.0.0130/bin/vim'
end

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


[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

if test -d ~/Library/Android/sdk/platform-tools
  set -gx PATH ~/Library/Android/sdk/platform-tools $PATH
end

# https://hub.github.com/
alias git='hub'


alias gP='git push'
alias ga='git add .'
alias gb='git browse'
alias gc-='git checkout -'
alias gc='git commit'
alias gcm='git checkout master'
alias gd='git diff'
alias gf='git fetch'
alias gh='git browse'
alias gl='git log -p'
alias gmm='git fetch; git merge origin/master'
alias gp='git pull'
alias gpr='git pull-request'
alias gs='git status'
alias vs='vim -S'
alias g='grep'
alias c='cd'
alias l='ls'
alias lt='ls -lat'
alias h='head'
alias t='tail'
alias r='ranger'
alias p='pwd'

# alias f='find . -name'

function f
  find . -name "*$argv*"
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

function v
  # Vim Abolish uses vim -S / mksession. Use :Abolish to start tracking a project. This will load the last session / open files.
  if test -e $PWD/Session.vim
    env NODE_PATH="src" vim -S $argv
  else
    env NODE_PATH="src" vim $argv
  end
end
