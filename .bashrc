# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

## Custom commands

# For making and changing into a directory
mkcd() {
	mkdir -p "$1" && cd "$1"
}

# for activating a python pip virtual environment
pyenv() {
	source ~/.venv/"$1"/bin/activate
}

# for clearing ~/downloads/share/ and copying the listed files there
sshare() {
	# Step 1: Delete existing files in ~/downloads/share/
	rm -rf ~/downloads/share/*

	# Step 2: Copy provided files to ~/downloads/share/
	for file in "$@"; do
		cp -r "$file" ~/downloads/share/
	done

	tree -CtF ~/downloads/share/
}

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

# set the bash prompt
PROMPT_DIRTRIM=3
PS1="\[\033[38;5;27m\]\w \[\033[0m\]\[\033[38;5;42m\]❯ \[\033[0m\]"

# make vim default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# setup broot
source $HOME/.config/broot/launcher/bash/br

# for a GO install
export PATH=$PATH:/usr/local/go/bin

# setup fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# set fzf settings for file preview
export FZF_DEFAULT_OPTS="--height=90% --layout=reverse --info=inline --bind change:first"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS \
  --preview='[ -z {q} ] && treefit . || fzf_preview_f_or_d {}' \
  --bind shift-up:preview-page-up,shift-down:preview-page-down \
  --bind 'ctrl-a:select-all'"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS \
  --preview='[ -z {q} ] && treefit . || treefit {}' \
  --bind shift-up:preview-page-up,shift-down:preview-page-down"
export FZF_CTRL_T_COMMAND='fd -HI --ignore-file $HOME/.dotfiles/.fzffdignore'
export FZF_ALT_C_COMMAND='fd -HI --type d --ignore-file $HOME/.dotfiles/.fzffdignore'

# >> for auto launching the ssh agent (for gitui) (from https://docs.github.com/en/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases#auto-launching-ssh-agent-on-git-for-windows)
env=~/.ssh/agent.env

agent_load_env() { test -f "$env" && . "$env" >|/dev/null; }

agent_start() {
	(
		umask 077
		ssh-agent >|"$env"
	)
	. "$env" >|/dev/null
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(
	ssh-add -l >|/dev/null 2>&1
	echo $?
)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
	agent_start
	ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
	ssh-add
fi

unset env
# <<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nsk/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/home/nsk/miniconda3/etc/profile.d/conda.sh" ]; then
		. "/home/nsk/miniconda3/etc/profile.d/conda.sh"
	else
		export PATH="/home/nsk/miniconda3/bin:$PATH"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<
