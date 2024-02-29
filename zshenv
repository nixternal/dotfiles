skip_global_compinit=1

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

#-- Really more for when ssh'd into a machine for weird home/pup/pdn/end issue
bindkey "^[[1~" beginning-of-line
bindkey "^[[6~" prev
bindkey "^[[5~" next
bindkey "^[[4~" end-of-line

#-- General Exports
export TERM=xterm-256color
export ACK_COLOR_FILENAME="bold white"
export ACK_COLOR_MATH="bold red"
export COLORFGBG="default;default"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -RN '

#-- Paths
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/snap/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/opt/lilypond-2.24.3/bin

#-- Source Highlight manpages
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
#alias jserve='bundle exec jekyll serve'
alias jserve="bundle exec jekyll build && bash -c 'cd _site && python -m http.server 3000'" # Ruby 3.0 work around
alias ll='ls -al'
alias ls='ls --color=auto '
alias man='LC_ALL=C LANG=C man'
alias ta='tmux attach'
alias top=htop

#-- Rust
if [ -f "$HOME/.cargo/env" ];then
    . "$HOME/.cargo/env"
fi

#-- NVM lazy load so starting new shell doesn't take so long to load
if [ -d "$HOME/.nvm" ]; then
    declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
    NODE_GLOBALS+=("node")
    NODE_GLOBALS+=("nvm")
    load_nvm() {
        export NVM_DIR=$HOME/.nvm
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    }
    for cmd in "${NODE_GLOBALS[@]}"; do
        eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
    done
fi

#-- Perl
PATH="/home/rich/.perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/rich/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/rich/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/rich/.perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/rich/.perl5"; export PERL_MM_OPT;
#-- ChordPro
PERL5LIB=$PERL5LIB:$HOME/.perl5/lib/perl5/ChordPro/lib; export PERL5LIB;
