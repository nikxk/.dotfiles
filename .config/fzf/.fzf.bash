# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/tools/fzf/bin* ]]; then
  PATH="$HOME/tools/fzf/bin${PATH:+:${PATH}}"
fi

if [[ -f "$HOME/.config/fzf/fzf-git.sh" ]]; then
	source "$HOME/.config/fzf/fzf-git.sh"
fi

# for displaying as long a tree as will fit in the terminal
treefit() {
	terminal_height=$LINES

	for ((depth = 3; depth >= 1; depth--)); do
		tree_output=$(tree -CFt -L $depth "$1" 2>/dev/null)
		output_height=$(echo "$tree_output" | wc -l)

		if ((output_height <= terminal_height)); then
			echo "$tree_output"
			return
		fi
	done

	echo "$tree_output"
}
export -f treefit

# for previewing a file or directory
fzf_preview_f_or_d() {
	if [ -f "$1" ]; then
		bat --color=always --style=changes,header,grid "$1"
	elif [ -d "$1" ]; then
		treefit "$1"
	else
		echo "Not a file or directory."
	fi
}
export -f fzf_preview_f_or_d

# set fzf settings for file preview
export FZF_DEFAULT_OPTS="--height=90% --layout=reverse --info=inline --bind change:first"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS \
  --preview='[ -z {q} ] && treefit . || fzf_preview_f_or_d {}' \
  --bind shift-up:preview-page-up,shift-down:preview-page-down \
  --bind 'ctrl-a:select-all'"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS \
  --preview='[ -z {q} ] && treefit . || treefit {}' \
  --bind shift-up:preview-page-up,shift-down:preview-page-down"
export FZF_CTRL_T_COMMAND='fd -HI --ignore-file $HOME/.config/fzf/.fzffdignore'
export FZF_ALT_C_COMMAND='fd -HI --type d --ignore-file $HOME/.config/fzf/.fzffdignore'

eval "$(fzf --bash)"
