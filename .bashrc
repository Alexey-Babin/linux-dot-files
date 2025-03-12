#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# all about BASH PROMPT-----------------------------------------------------
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac
# ------------End of prompt configuration----------------------------------

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# shellcheck source=/dev/null
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi  

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/.commonrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/.commonrc"

# -------------For domain accounts use zsh if it is installed --------------
# if [[ -x /usr/bin/zsh ]] && [[ "$(whoami)" =~ .*"@iibbank.com" ]]; then
#    echo 'starting zsh'
#    exec /usr/bin/zsh
# fi

#if [[ "$TERM" != "screen-256color" ]]; then
  #tmux_session=$(echo "$USER" | tr . -)  
  #tmux attach-session -t "$tmux_session" || tmux new-session -s "$tmux_session"
  #exit
#fi
#alias tmux="TERM=screen-256color-bce tmux"

[[ ! -s "$HOME/.cargo/env" ]] || . "$HOME/.cargo/env"

command -v zoxide > /dev/null 2>&1 && eval "$(zoxide init bash)"


[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.bash" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.bash"
[ -f "$HOME/programs/fzf-tab-completion/bash/fzf-bash-completion.sh" ] && source "$HOME/programs/fzf-tab-completion/bash/fzf-bash-completion.sh"
bind -x '"\t": fzf_bash_completion'

_fzf_bash_completion_loading_msg() { echo "${PS1@P}${READLINE_LINE}" | tail -n1; }
