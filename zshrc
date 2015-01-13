# ------------------------------------------------------------------------------
# DOTFILES
# ------------------------------------------------------------------------------
export dotfiles=$HOME/mystuff/dev/github/dotfiles
export PATH=$PATH:$dotfiles/bin

#------------------------------------------------------------------------------
# ANTIGEN
#------------------------------------------------------------------------------
source $dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme nixternal/bullet-train-oh-my-zsh-theme bullet-train
antigen apply

#-- Disable auto updates of oh-my-zsh
DISABLE_AUTO_UPDATE="true"
#-- Theme Customization
ZSH_THEME_GIT_PROMPT_PREFIX="  "
BULLETTRAIN_EXIT_SHOW=true
if [[ -n "$SSH_CLIENT" ]]; then
    BULLETTRAIN_CONTEXT_BG=yellow
    BULLETTRAIN_CONTEXT_FG=blue
else
    BULLETTRAIN_CONTEXT_SHOW=false
fi

#------------------------------------------------------------------------------
# MY TWEAKS
#------------------------------------------------------------------------------
unset GPG_AGENT_INFO
export GPG_TTY=`tty`
export GPGKEY=D8C44738
TZ="America/Chicago"
HOSTNAME="`hostname`"
EDITOR="vim"

#-- General Exports
export TERM=xterm-256color
export ACK_COLOR_FILENAME="bold white"
export ACK_COLOR_MATH="bold red"
export COLORFGBG="default;default"
export GREP_OPTIONS='--color=auto'
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

#-- Debian/Ubuntu Packaging Exports
export DEBEMAIL=nixternal@ubuntu.com
export QUILT_PATCHES=debian/patches
export PBUILDFOLDER=$HOME/mystuff/dev/pbuilder

#-- ~/bin
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi

#-- Laziness
if [ -d "$HOME/mystuff/business" ]; then
    export biz=$HOME/mystuff/business
fi

#-- Android Development
if [ -d "$HOME/mystuff/dev/android/android-sdk-linux" ]; then
    export PATH=$PATH:$HOME/mystuff/dev/android/android-sdk-linux
    export PATH=$PATH:$HOME/mystuff/dev/android/android-sdk-linux/tools
    export PATH=$PATH:$HOME/mystuff/dev/android/android-sdk-linux/platform-tools
fi

#-- VirtualEnv
if [ -e "/usr/local/bin/virtualenvwrapper.sh" ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/mystuff/dev/virtenv-projects
    export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
    . /usr/local/bin/virtualenvwrapper_lazy.sh
fi

#-- Node.js
if [ -d "/usr/lib/node_modules/jsctags" ]; then
    export NODE_PATH=/usr/lib/node_modules/jsctags:$NODE_PATH
fi

#-- Adobe Flex
if [ -d "$HOME/mystuff/dev/adobe-flex/flex36" ]; then
    export PATH=$PATH:$HOME/mystuff/dev/adobe-flex/flex36/bin
    export flexlib=$HOME/mystuff/dev/adobe-flex/flex36/frameworks
fi

#-- Sencha
if [ -d "$HOME/mystuff/dev/Sencha/Cmd/5.0.3.324" ]; then
    export PATH=$PATH:$HOME/mystuff/dev/Sencha/Cmd/5.0.3.324
fi

#-- Aliases
alias df=dfc
alias dget='dget --insecure'
alias diff=colordiff
alias jserve='bundle exec jekyll serve'
alias ll='ls -al'
alias ls='ls --color=auto '
alias man='LC_ALL=C LANG=C man'
alias top=htop
alias ta='tmux attach'

#-- ZSH ZStyle Configs
zstyle ':completion:*:commands' rehash true
unsetopt hist_verify
setopt globdots
