#!/bin/sh
# Fuzzy finder configuration ()
FD_OPTIONS="--follow --hidden --exclude .git --exclude node_modules"

FZF_FILE_PREVIEW="[[ \$(file --mime {}) =~ 'charset=binary' ]] \
    && \{ [[ ! \$(file --mime {}) =~ 'directory' ]] \
        && file --mime {} \
        || lsd --tree {} | head -n $LINES \} \
    || (less -E {}) 2> /dev/null | head -$LINES"

export FZF_DEFAULT_OPTS=" \
    --height 50% --layout=reverse --border=rounded  \
	--scroll-off=1 --info=inline \
    --preview='$FZF_FILE_PREVIEW' \
    --preview-window='right:60%:hidden:wrap' \
    --multi \
    --prompt 'All∷ ' \
    --bind='ctrl-y:execute-silent(echo {+} | pbcopy)' \
    --bind='ctrl-d:change-prompt(Directories∷ )+reload(fdfind . --type d $FD_OPTIONS)' \
    --bind='ctrl-f:change-prompt(Files∷ )+reload(fdfind . --type f )' \
    --bind='f2:toggle-preview' \
    --bind='ctrl-d:half-page-down,ctrl-u:half-page-up' \
    --bind='ctrl-a:select-all+accept' \
    --color='fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'"

export FZF_DEFAULT_COMMAND="fdfind . $FD_OPTIONS"

export FZF_ALT_C_COMMAND="fdfind --type d $FD_OPTIONS"

export FZF_CTRL_R_OPTS=" \
    --preview 'echo -E {}' --preview-window up:3:hidden:wrap \
    --bind 'ctrl-/:toggle-preview' \
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
    --color header:italic \
    --header 'Press Ctrl-Y to copy command into clipboard'"

export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree"

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
    command=$1
    shift

    case "$command" in
    cd|tree)
        fd . --type=d | fzf --no-multi --preview 'lsd --tree {} | head -n 100'
        ;;
    *)
        fzf "$@"
        ;;
    esac
}
