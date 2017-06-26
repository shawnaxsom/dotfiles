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

set -gx PATH /Users/shawnaxsom/Library/Android/sdk/platform-tools $PATH

alias ga='git add .'
alias gc='git commit'
alias gp='git pull'
alias gP='git push'
alias gl='git log -p'
alias gs='git status'
alias gd='git diff'
alias vs='vim -S'
alias f='find . -name'

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
    vim -S $argv
  else
    vim $argv
  end
end
