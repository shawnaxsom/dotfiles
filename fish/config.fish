# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
#set fish_theme robbyrussell
set fish_theme Informative

# All built-in plugins can be found at ~/.oh-my-fish/plugins/
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Enable plugins by adding their name separated by a space to the line below.
set fish_plugins theme z tmux tab vi-mode

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish
 
if which xset
  xset r rate 225 28
end

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
alias .......='../../../../../..'
alias ........='../../../../../../..'
alias -='cd -'

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
