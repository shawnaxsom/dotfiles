if which xset
  xset r rate 225 28
end

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
alias .......='../../../../../..'
alias ........='../../../../../../..'

set -x TERM screen-256color
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
alias gpr='hub pull-request --edit -F ./.github/PULL_REQUEST_TEMPLATE.md'
alias gs='git status'
alias vs='vim -S'
alias g='grep'
alias gv='grep -v'
alias c='cd'
alias l='ls'
alias lt='ls -lat'
alias h='head'
alias t='tail'
alias r='ranger'
alias p='pwd'
alias x='exit'

# alias f='find . -name'

function gpm
  git branch --merged master | grep -v '^ *master$' | xargs git branch -d
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
