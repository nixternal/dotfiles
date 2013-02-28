# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# ------------------------------------------------------------------------------
# MY CUSTOMIZATIONS
# ------------------------------------------------------------------------------
# --Source Powerline ZSH theme
. /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh
# --GPG Exports
unset GPG_AGENT_INFO
export GPG_TTY=`tty`
export GPGKEY=D8C44738                  # my key
export BCKEY=FB0385C2                   # Bluecherry key
export DEBEMAIL=nixternal@ubuntu.com
# --General Exports
export ACK_COLOR_FILENAME="bold white"
export ACK_COLOR_MATH="bold red"
export COLORFGBG="default;default"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
export GREP_OPTIONS='--color=auto'
# --Debian/Ubuntu Packaging Exports
export QUILT_PATCHES=debian/patches
export PBUILDFOLDER=$HOME/mystuff/dev/pbuilder
# --Export ~/bin
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi
# --Android Development
if [ -d "$HOME/mystuff/dev/android/android-sdk-linux" ]; then
    export PATH=$PATH:$HOME/mystuff/dev/android/android-sdk-linux
    export PATH=$PATH:$HOME/mystuff/dev/android/android-sdk-linux/tools
    export PATH=$PATH:$HOME/mystuff/dev/android/android-sdk-linux/platform-tools
fi
# --VirtualEnv
if [ -e "/usr/local/bin/virtualenvwrapper.sh" ]; then
    export WORKON_HOME=$HOME/mystuff/dev/virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true
fi
# --Node.js
if [ -d "/usr/local/lib/jsctags" ]; then
    export NODE_PATH=/usr/local/lib/jsctags:$NODE_PATH
fi
# ------------------------------------------------------------------------------
# MY FUNCTIONS
# ------------------------------------------------------------------------------
svndiff() { svn diff "$*" | colordiff; }
bzrdiff() { bzr diff "$*" | colordiff; }
gitdiff() { git diff "$*" | colordiff; }
h() { if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi; }
# ------------------------------------------------------------------------------
# MY ALIASES
# ------------------------------------------------------------------------------
alias df=dfc
alias diff=colordiff
alias ll='ls -al'
alias ls='ls --color=auto '
alias man='LC_ALL=C LANG=C man'
alias smupdate='git submodule foreach git pull'
alias top=htop
if [ -d "$HOME/mystuff/dev/github/dotfiles" ]; then
    alias dotfiles='cd $HOME/mystuff/dev/github/dotfiles'
fi
if [ -x "/usr/bin/task" ] || [ -x "/usr/local/bin/task" ]; then
    alias t=`which task`
fi
