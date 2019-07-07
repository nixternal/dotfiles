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
#-- Disable Completion of Dot Directories
zstyle ':completion:*' special-dirs false
#-- Theme Customization
ZSH_THEME_GIT_PROMPT_PREFIX="  "
BULLETTRAIN_EXIT_SHOW=true
BULLETTRAIN_VIRTUALENV_BG=green
if [[ -n "$SSH_CLIENT" ]]; then
    BULLETTRAIN_CONTEXT_BG=yellow
    BULLETTRAIN_CONTEXT_FG=white
    BULLETTRAIN_CONTEXT_SHOW=true
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
export LESS=' -RN '
export VDPAU_DRIVER=va_gl

#-- Paths
export NODE_PATH=/usr/lib/node_modules/jsctags:$NODE_PATH
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
#export PATH=$PATH:~/Android/Sdk/platform-tools

#-- Source Highlight manpages
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;38;5;74m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\E[37;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[04;38;5;146m'

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
. $HOME/.local/bin/aws_zsh_completer.sh

#-- VirtuaEnv (& wrapper)
export WORKON_HOME=$HOME/mystuff/dev/virtualenvs
export PROJECT_HOME=$HOME/mystuff/dev/virtualenv-dev
. /usr/local/bin/virtualenvwrapper.sh

#-- Aliases
alias df=dfc
alias dget='dget --insecure'
alias diff=colordiff
alias dmesg='dmesg -T'
alias dynamicrange='/home/rich/mystuff/dev/SRC/dr14_t.meter/dr14_tmeter'
alias grep='/bin/grep --color=auto'
alias jserve='bundle exec jekyll serve'
alias ll='ls -al'
alias ls='ls --color=auto '
alias man='LC_ALL=C LANG=C man'
alias ta='tmux attach'
alias top=htop

#-- ZSH ZStyle Configs
zstyle ':completion:*:commands' rehash true
unsetopt hist_verify
setopt globdots
