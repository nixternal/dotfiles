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
POWERLEVEL9K_OS_ICON_FOREGROUND='255'
POWERLEVEL9K_OS_ICON_BACKGROUND='000'
POWERLEVEL9K_LINUX_ICON=''
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
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs ram history os_icon)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2

#-- ZSH ZStyle Configs
zstyle ':completion:*:commands' rehash true
unsetopt hist_verify
setopt globdots

#-- ZSH Tweaks
autoload -U compinit
compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
