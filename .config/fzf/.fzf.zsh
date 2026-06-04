# Setup fzf for zsh
# -----------------
if [[ -d "$HOME/.fzf/bin" && ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    PATH="$HOME/.fzf/bin${PATH:+:${PATH}}"
fi

if [[ -f "$HOME/.config/fzf/fzf-git.sh" ]]; then
    source "$HOME/.config/fzf/fzf-git.sh"
fi

# Convenience wrappers around the shared preview script
treefit()             { "$HOME/.config/fzf/preview.sh" tree "${1:-.}" }
fzf_preview_f_or_d()  { "$HOME/.config/fzf/preview.sh" "$1" }

# fzf preview/option settings (preview logic lives in preview.sh)
export FZF_DEFAULT_OPTS="--height=90% --layout=reverse --info=inline --bind change:first"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS \
  --preview='[ -z {q} ] && \"\$HOME/.config/fzf/preview.sh\" tree . || \"\$HOME/.config/fzf/preview.sh\" {}' \
  --bind shift-up:preview-page-up,shift-down:preview-page-down \
  --bind 'ctrl-a:select-all'"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS \
  --preview='[ -z {q} ] && \"\$HOME/.config/fzf/preview.sh\" tree . || \"\$HOME/.config/fzf/preview.sh\" tree {}' \
  --bind shift-up:preview-page-up,shift-down:preview-page-down"
export FZF_CTRL_T_COMMAND='fd -HI --ignore-file $HOME/.config/fzf/.fzffdignore'
export FZF_ALT_C_COMMAND='fd -HI --type d --ignore-file $HOME/.config/fzf/.fzffdignore'

eval "$(fzf --zsh)"
