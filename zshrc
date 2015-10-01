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
BULLETTRAIN_VIRTUALENV_BG=green
if [[ -n "$SSH_CLIENT" ]]; then
    BULLETTRAIN_CONTEXT_BG=yellow
    BULLETTRAIN_CONTEXT_FG=blue
else
    BULLETTRAIN_CONTEXT_SHOW=false
fi

#------------------------------------------------------------------------------
# MY TWEAKS
#------------------------------------------------------------------------------
unset SSH_AUTH_SOCK
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
if [ -d "$HOME/mystuff/dev/android/sdk" ]; then
    export PATH=$PATH:$HOME/mystuff/dev/android/sdk
    export PATH=$PATH:$HOME/mystuff/dev/android/sdk/tools
    export PATH=$PATH:$HOME/mystuff/dev/android/sdk/platform-tools
fi

#-- Go
if [ -d "/usr/local/go/bin" ]; then
    export PATH=$PATH:/usr/local/go/bin
fi

#-- VirtualEnv
if [ -e "$HOME/.local/bin/virtualenvwrapper.sh" ]; then
    export WORKON_HOME=$HOME/mystuff/dev/virtualenvs/environments
    export PROJECT_HOME=$HOME/mystuff/dev/virtualenvs/projects
    export VIRTUALENVWRAPPER_SCRIPT=$HOME/.local/bin/virtualenvwrapper.sh
    export PATH=$PATH:$HOME/.local/bin
    . $HOME/.local/bin/virtualenvwrapper_lazy.sh
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

#-- Ruby
if [ -d "$HOME/.rbenv/bin" ]; then
    export PATH=$PATH:$HOME/.rbenv/bin
    eval "$(rbenv init -)"
fi
if [ -d "$HOME/.rbenv/plugins/ruby-build/bin" ]; then
    export PATH=$PATH:$HOME/.rbenv/plugins/ruby-build/bin
fi

#-- Sencha
if [ -d "$HOME/mystuff/dev/Sencha/Cmd/5.0.3.324" ]; then
    export PATH=$PATH:$HOME/mystuff/dev/Sencha/Cmd/5.0.3.324
fi

#-- AWS
if [ -f "/usr/local/bin/aws_zsh_completer.sh" ]; then
    . /usr/local/bin/aws_zsh_completer.sh
fi

#-- Aliases
alias df=dfc
alias dget='dget --insecure'
alias diff=colordiff
alias dmesg='dmesg -T'
alias grep='/bin/grep --color=auto'
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
