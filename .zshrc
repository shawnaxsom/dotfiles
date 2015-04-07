# # Path to your oh-my-zsh installation.
export ZSH=/home/shawn/.oh-my-zsh
# 
# # Set name of the theme to load.
# # Look in ~/.oh-my-zsh/themes/
# # Optionally, if you set this to "random", it'll load a random theme each
# # time that oh-my-zsh is loaded.
# #ZSH_THEME="robbyrussell"
# #ZSH_THEME="sunrise"
# #ZSH_THEME="wuffers"
# #ZSH_THEME="bira"
# #ZSH_THEME="amuse"
# ZSH_THEME="nicoulaj"
# #ZSH_THEME="random"
# 
# # Uncomment the following line to use case-sensitive completion.
# # CASE_SENSITIVE="true"
# 
# # Uncomment the following line to disable bi-weekly auto-update checks.
# # DISABLE_AUTO_UPDATE="true"
# 
# # Uncomment the following line to change how often to auto-update (in days).
# # export UPDATE_ZSH_DAYS=13
# 
# # Uncomment the following line to disable colors in ls.
# # DISABLE_LS_COLORS="true"
# 
# # Uncomment the following line to disable auto-setting terminal title.
# # DISABLE_AUTO_TITLE="true"
# 
# # Uncomment the following line to enable command auto-correction.
# # ENABLE_CORRECTION="true"
# 
# # Uncomment the following line to display red dots whilst waiting for completion.
# # COMPLETION_WAITING_DOTS="true"
# 
# # Uncomment the following line if you want to disable marking untracked files
# # under VCS as dirty. This makes repository status check for large repositories
# # much, much faster.
# # DISABLE_UNTRACKED_FILES_DIRTY="true"
# 
# # Uncomment the following line if you want to change the command execution time
# # stamp shown in the history command output.
# # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# # HIST_STAMPS="mm/dd/yyyy"
# 
# # Would you like to use another custom folder than $ZSH/custom?
# # ZSH_CUSTOM=/path/to/new-custom-folder
# 
# # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(git docker python bower npm vim-interaction vi-mode tmux atom colorize web-search jump autojump zsh-history-substring-search zsh-syntax-highlighting)
# 
# # User configuration
# 
# export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# # export MANPATH="/usr/local/man:$MANPATH"
# 
# source $ZSH/oh-my-zsh.sh
# 
# # You may need to manually set your language environment
# # export LANG=en_US.UTF-8
# 
# # Preferred editor for local and remote sessions
# # if [[ -n $SSH_CONNECTION ]]; then
# #   export EDITOR='vim'
# # else
# #   export EDITOR='mvim'
# # fi
# 
# # Compilation flags
# # export ARCHFLAGS="-arch x86_64"
# 
# # ssh
# # export SSH_KEY_PATH="~/.ssh/dsa_id"
# 
# # Set personal aliases, overriding those provided by oh-my-zsh libs,
# # plugins, and themes. Aliases can be placed here, though oh-my-zsh
# # users are encouraged to define aliases within the ZSH_CUSTOM folder.
# # For a full list of active aliases, run `alias`.
# #
# # Example aliases
# # alias zshconfig="mate ~/.zshrc"
# # alias ohmyzsh="mate ~/.oh-my-zsh"
# 
# alias p="pushd"
# alias o="popd"
# alias d="dirs -l"
# 
# bindkey -v # Vim-Mode if you press escape
# bindkey '^R' history-incremental-pattern-search-backward
# 
# #source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting.zsh
# source ~/.oh-my-zsh/plugins/history-substring-search/history-substring-search.zsh
# 
# # bind UP and DOWN arrow keys
# zmodload zsh/terminfo
# bindkey "^[[A" history-substring-search-up
# bindkey "^[[B" history-substring-search-down
# 
# # bind P and N for EMACS mode
# bindkey -M emacs '^P' history-substring-search-up
# bindkey -M emacs '^N' history-substring-search-down
# 
# # bind k and j for VI mode
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
# 
# #alias ack='ack-grep --js --html --py -i --max-count=4 --pager="less -R -S"' 
# alias ack='ack-grep --js --html --py -i -s --pager="less -R -S"' 
# 
# # Path to your oh-my-zsh installation.
# # export ZSH=$HOME/.oh-my-zsh
# 
# 
# 
# ###################
# ###################
# ###################
# ###################
# ###################
 
 
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker python bower npm vim-interaction vi-mode tmux atom colorize web-search jump autojump zsh-history-substring-search zsh-syntax-highlighting)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

eval "$(fasd --init auto)"

TERM=xterm-256color
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
