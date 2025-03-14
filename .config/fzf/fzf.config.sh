#!/usr/bin/bash
# Fuzzy finder configuration ()
FD_OPTIONS="--color always --strip-cwd-prefix --max-depth 3 \
	--follow --hidden --exclude .git --exclude node_modules \
	--exclude .bak"

export FZF_FILE_PREVIEW_LIGHT=" \
   ([[ -d {} ]] && (ls -Alh {})) \
|| ([[ -f {} ]] && \
    ([[ \$(file --mime {}) =~ binary ]] && (file --dereference {}) || (batcat --color=always --plain {} || cat {})) \
) \
|| echo {} 2> /dev/null \
| head -n $LINES"

export FZF_FILE_PREVIEW_FULL="$HOME/scripts/preview {}"

export FZF_FILE_PREVIEW="if command -v preview > /dev/null 2>&1 && ; then
	$FZF_FILE_PREVIEW_FULL
else
	$FZF_FILE_PREVIEW_LIGHT
fi"

export FZF_DEFAULT_OPTS=" 
	--ansi --cycle
    --tiebreak=chunk
    --height 50% --layout=reverse --border=rounded  
	--scroll-off=1 --info=inline 
    --prompt='∷ ' 
    --multi
    --bind='ctrl-y:execute-silent(echo {+} | pbcopy)' 
    --bind='f2:toggle-preview' 
    --bind='ctrl-d:half-page-down,ctrl-u:half-page-up' 
    --bind='ctrl-a:select-all+accept' 
    --bind='tab:down'
    --bind='insert:toggle+down'
    --color='fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899' 
    --preview-window=right:60%:hidden:wrap 
    -1"
export FZF_COMPLETION_OPTS="
  --no-multi-line"

export FZF_PREVIEW_OPTS=" \
    --preview='$FZF_FILE_PREVIEW'"

export FZF_DEFAULT_COMMAND="fdfind --type f $FD_OPTIONS \"$*\""
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="\
    --prompt='Files∷ '
	$FZF_PREVIEW_OPTS
    --bind='ctrl-d:change-prompt(Directories∷ )+reload(fdfind . $FD_OPTIONS --type d )' \
    --bind='ctrl-f:change-prompt(Files∷ )+reload(fdfind . $FD_OPTIONS --type f )' \
"
export FZF_ALT_C_COMMAND="fdfind --type d $FD_OPTIONS $*"
export FZF_ALT_C_OPTS="
    $FZF_PREVIEW_OPTS
    --preview-window=right:60%:nowrap:nohidden"


export FZF_CTRL_R_OPTS=" \
    --preview='echo -E {}' --preview-window=up:3:hidden:wrap \
    --bind='ctrl-/:toggle-preview' \
    --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
    --color=header:italic \
    --scheme=history
    --header='Press Ctrl-Y to copy command into clipboard'"

export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree"

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
    command=$1
    shift

    case "$command" in
    cd | tree)
        fdfind . --type d --follow --hidden --exclude .git --exclude node_modules | \
        fzf --no-multi --preview 'lsd --tree {} | head -n 100' "$@"
        ;;
    export | unset)
        fzf --preview "eval echo \${}" "$@"
        ;;
    ssh)
        fzf --preview 'dig {}' "$@"
        ;;
    *)
        fzf "$@"
        ;;
    esac
}
