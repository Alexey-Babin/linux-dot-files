#!/bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

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
    git
#    fd
    fzf-tab
    zsh-syntax-highlighting
    zsh-autosuggestions
)


source $ZSH/oh-my-zsh.sh

# zsh completions: https://github.com/zsh-users/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

[ -f "$HOME/.commonrc" ] && source "$HOME/.commonrc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "${XDG_CACHE_HOME:-$HOME/.config}/.p10k.zsh" ]] || source "${XDG_CACHE_HOME:-$HOME/.config}/.p10k.zsh"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
enable-fzf-tab

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# zsh completion for procs
command -v procs > /dev/null 2>&1 && source <(procs --gen-completion-out zsh)

# zoxide (aka z replacement for cd)
command -v zoxide > /dev/null 2>&1 && eval "$(zoxide init zsh)"


