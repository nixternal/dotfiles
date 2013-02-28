# ------------------------------------------------------------------------------
# OH-MY-ZSH CUSTOMIZATION
# ------------------------------------------------------------------------------
ZSH=$HOME/mystuff/dev/github/dotfiles/oh-my-zsh
COMPLETION_WAITING_DOTS="true"
plugins=(git django encode64 git-extras github history npm pip python taskwarrior)
source $ZSH/oh-my-zsh.sh
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
# ------------------------------------------------------------------------------
# COMPLETION
# ------------------------------------------------------------------------------
zstyle ':completion:*' rehash true
