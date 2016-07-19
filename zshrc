# ------------------------------------------------------------------------------
# DOTFILES
# ------------------------------------------------------------------------------
export dotfiles=~/mystuff/dev/github/dotfiles
export PATH=$PATH:$dotfiles/bin

#------------------------------------------------------------------------------
# ANTIGEN
#------------------------------------------------------------------------------
source $dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train
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
    #BULLETTRAIN_CONTEXT_SHOW=false
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
export TERM=screen
export ACK_COLOR_FILENAME="bold white"
export ACK_COLOR_MATH="bold red"
export COLORFGBG="default;default"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

#-- Paths
export NODE_PATH=/usr/lib/node_modules/jsctags:$NODE_PATH
export PATH=$PATH:~/bin
export PATH=$PATH:~/Android/Sdk/platform-tools

#-- Go Language
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#-- Debian/Ubuntu Packaging Exports
export DEBEMAIL=nixternal@ubuntu.com
export QUILT_PATCHES=debian/patches
export PBUILDFOLDER=~/mystuff/dev/pbuilder
export MIRRORSITE="http://us-east-1.ec2.archive.ubuntu.com/ubuntu/"
export COMPONENTS="main restricted universe multiverse"

#-- AWS
. /usr/local/bin/aws_zsh_completer.sh

#-- VirtuaEnv (& wrapper)
export WORKON_HOME=~/mystuff/dev/virtualenvs
. /usr/local/bin/virtualenvwrapper.sh

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
