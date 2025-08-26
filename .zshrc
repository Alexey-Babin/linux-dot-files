#!/bin/zsh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [[ "$TERM" =~ ^linux ]] ; then
    ZSH_THEME="clean"
else
    ZSH_THEME="powerlevel10k/powerlevel10k"
fi

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# UPDATE oh-my-zsh
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 7

# You can also set it to another string to have that shown instead of the default red dots.
# COMPLETION_WAITING_DOTS="true"
COMPLETION_WAITING_DOTS="%F{red}…%f"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# The command execution time stamp shown in the history command output.
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    tmux
    git
    zsh-fzf-history-search
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

# run0 should start with bash shell, not zsh
command -v run0 >/dev/null 2>&1 && alias run0='run0 --setenv=SHELL=/usr/bin/bash'


[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/common-profile" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/common-profile"

[ -f "$HOME/programs/lf/etc/lfcd.sh" ] && source "$HOME/programs/lf/etc/lfcd.sh"


# fzf and features
[[ ! -s "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]] || source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
[[ -f "$HOME/programs/fzf-tab-completion/zsh/fzf-zsh-completion.sh" ]] && source "$HOME/programs/fzf-tab-completion/zsh/fzf-zsh-completion.sh"

# -----BEGIN fzf-tab-completion tuning (ansible managed) ----- 
zstyle ':completion:*' fzf-search-display true
zstyle ':completion:*' fzf-completion-opts --preview='eval $HOME/scripts/preview {1}' --preview-window="hidden"
zstyle ':completion::*:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-completion-opts --preview='eval eval echo "{1}"'
zstyle ':completion::*:(ps|kill|procs):*' fzf-completion-opts --preview='
  eval set -- {+1}
  { ps --forest -o pid=,cmd= -g "$(ps -o sid:1= -p "$@")" || pstree "$@" || echo "$@" } 2>/dev/null
' --preview-window='down,30%,border-horizontal,nohidden,nowrap' --multi
zstyle ':completion::*:systemctl::*' fzf-completion-opts --preview='
  eval set -- {1} { systemctl status $@ } 2>/dev/null
'
# -----END fzf-tab-completion tuning (ansible managed) ----- 


# zsh completion for procs
command -v procs > /dev/null 2>&1 && source <(procs --gen-completion-out zsh)

# zoxide (aka z replacement for cd)
command -v zoxide > /dev/null 2>&1 && eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.config/.p10k.zsh.
[[ ! -f ~/.config/.p10k.zsh && ZSH_THEME == "powerlevel10k/powerlevel10k" ]] || source ~/.config/.p10k.zsh


