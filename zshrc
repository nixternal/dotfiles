# ------------------------------------------------------------------------------
# DOTFILES
# ------------------------------------------------------------------------------
export dotfiles=~/mystuff/dev/github/dotfiles
export PATH=$PATH:$dotfiles/bin
fpath=($dotfiles/completion_zsh $fpath)

#------------------------------------------------------------------------------
# ANTIGEN
#------------------------------------------------------------------------------
source $dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen theme romkatv/powerlevel10k
antigen apply

#-- Disable auto updates of oh-my-zsh
DISABLE_AUTO_UPDATE="true"
#-- Disable Completion of Dot Directories
zstyle ':completion:*' special-dirs false
#-- Theme Customization
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='249'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='027'
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND='001'
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND='015'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='220'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='033'
POWERLEVEL9K_RAM_BACKGROUND='240'
POWERLEVEL9K_RAM_FOREGROUND='250'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir_writable dir vcs command_execution_time)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs ram history)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2

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

eval "`pip completion --zsh`"
compctl -K _pip_completion pip3

#-- General Exports
export TERM=xterm-256color
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
export PATH=$PATH:/snap/bin
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
export GOPATH=$HOME/mystuff/dev/go-lang
export GOROOT=$GOPATH/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#-- Debian/Ubuntu Packaging Exports
export DEBEMAIL=nixternal@ubuntu.com
export QUILT_PATCHES=debian/patches
export PBUILDFOLDER=~/mystuff/dev/pbuilder
export MIRRORSITE="http://us-east-1.ec2.archive.ubuntu.com/ubuntu/"
export COMPONENTS="main restricted universe multiverse"

if [[ -z "$SSH_CLIENT" ]]; then
    #-- AWS
    . $HOME/.local/bin/aws_zsh_completer.sh
    
    #-- VirtuaEnv (& wrapper)
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
    export WORKON_HOME=$HOME/mystuff/dev/virtualenvs
    export PROJECT_HOME=$HOME/mystuff/dev/virtualenv-dev
    if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
        . /usr/local/bin/virtualenvwrapper.sh
    elif [ -e $HOME/.local/bin/virtualenvwrapper.sh ]; then
        . $HOME/.local/bin/virtualenvwrapper.sh
    fi
fi

#-- Aliases
alias bp='$HOME/mystuff/dev/bp/BloodPressure.py'
alias clear=' /usr/bin/clear'
alias df=dfc
alias dget='dget --insecure'
alias diff=colordiff
alias dmesg='dmesg -T'
alias dynamicrange='/home/rich/mystuff/dev/SRC/dr14_t.meter/dr14_tmeter'
alias grep='/bin/grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ip='ip -c'
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

#-- ZSH Tweaks
autoload -U compinit
compinit
