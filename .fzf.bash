# Setup fzf
# ---------
if [[ ! "$PATH" == */home/nsk/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/nsk/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/nsk/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/nsk/.fzf/shell/key-bindings.bash"
