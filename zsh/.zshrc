# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#-- Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

#-- Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

#-- PLUGINS
#   -- Fish shell like syntax highlighting for Zsh
zinit light zsh-users/zsh-syntax-highlighting
#   -- Additional completion definitions for Zsh
zinit light zsh-users/zsh-completions
#   -- Fish-like autosuggestions for Zsh
zinit light zsh-users/zsh-autosuggestions
#   -- ZSH port of Fish history search (up arrow)
zinit light zsh-users/zsh-history-substring-search
#   -- Lazy load commands and speed up start time of zsh
zinit light qoomon/zsh-lazyload

#-- OH MY ZSH: Zinit snippets
#   -- set HIST_STAMPS before loading history.zsh
HIST_STAMPS="%m/%d/%y %T"
zinit snippet OMZL::history.zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::ubuntu
zinit snippet OMZP::colorize
zinit snippet OMZP::command-not-found

#-- Set completions directory fpath
fpath=($ZDOTDIR/completions $fpath)

autoload -Uz compinit && compinit

zinit cdreplay -q

#-- To customize prompt, run 'p10k configure' or edit '.p10k.zsh'
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

#-- Fix Right Prompt Indent so it sticks all the way to the right
ZLE_RPROMPT_INDENT=0

#-- ZSH History
HISTDUP=erase
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

#-- Completion Styling
zstyle ':completion:*' special-dirs false
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
setopt globdots
setopt autocd

#-- ZSH History Substring Search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

#-----------------------------------------------------------------------------
# MY TWEAKS
#-----------------------------------------------------------------------------
export dotfiles=~/mystuff/dev/github/dotfiles

unset SSH_AUTH_SOCK
unset GPG_AGENT_INFO
export GPG_TTY=$TTY
export GPGKEY=35780981A21DD6622A967623F4C1838CD8C44738
TZ="America/Chicago"
HOSTNAME="$(hostname)"

#-- General Exports
export ACK_COLOR_FILENAME="bold white"
export ACK_COLOR_MATH="bold red"
export COLORFGBG="default;default"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -RN '

#-- Paths
export PATH=$PATH:$dotfiles/bin
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/opt/nvim/bin

#-- Source Highlight Messages
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;38;5;74m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\E[37;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[04;38;5;146m'

#-- Debian/Ubuntu Packaging Exports
export DEBEMAIL=nixternal@ubuntu.com
export QUILT_PATCHES=debian/patches
export PBUILDFOLDER=~/mystuff/dev/pbuilder
export MIRRORSITE="http://us-east-1.ec2.archive.ubuntu.com/ubuntu/"
export COMPONENTS="main restricted universe multiverse"

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
alias jserve="bundle exec jekyll build && bash -c 'cd _site && python -m http.server 3000'" # Ruby 3.0 work around
alias ll='ls -al'
alias ls='ls --color=auto '
alias man='LC_ALL=C LANG=C man'
alias ta='tmux attach'
alias top=btop
alias gg=geniusctl

#-- NVM
lazyload nvm npm node vi nvim vim editor -- 'source ~/.nvm/nvm.sh'
[ -s ~/.nvm/bash_completion ] && . ~/.nvm/bash_completion

#-- Go
[ -d /usr/local/go/bin ] && export PATH=$PATH:/usr/local/go/bin:~/go/bin

#-- Rust/Cargo
lazyload cargo rustc rustup -- "source ~/.cargo/env"

#-- Julia
[ -d ~/.juliaup/bin ] && export PATH=$PATH:~/.juliaup/bin

#-- VirtualEnv, VirtualEnvWrapper
[ -s ~/.local/bin/virtualenvwrapper.sh ] && \
  export WORKON_HOME=~/.virtualenvs && \
  export PROJECT_HOME=~/mystuff/dev/virtualenvs && \
  export VIRTUALENVWRAPPER_SCRIPT=~/.local/bin/virtualenvwrapper.sh && \
  . ~/.local/bin/virtualenvwrapper_lazy.sh