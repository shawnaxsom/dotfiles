# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# FZF options
# https://github.com/jethrokuan/fzf
set -U FZF_DEFAULT_OPTS "--no-sort --exact"
