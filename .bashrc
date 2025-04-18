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

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Load aliases if available
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

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

# set the bash prompt with fallback for virtual terminals
PROMPT_DIRTRIM=3
if [ "$TERM" = "linux" ]; then
    # Simple prompt for virtual console with standard '>' character
    PS1="\[\033[38;5;39m\]\w \[\033[0m\]\[\033[38;5;42m\]> \[\033[0m\]"
else
    # Rich prompt for graphical terminals with Unicode character
    PS1="\[\033[38;5;27m\]\w \[\033[0m\]\[\033[38;5;42m\]❯ \[\033[0m\]"
fi

# make vim default editor
export VISUAL=vim
export EDITOR="$VISUAL"

[ -d "/usr/local/go/bin" ] && export PATH=$PATH:/usr/local/go/bin
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"
[ -f ~/.config/fzf/.fzf.bash ] && source ~/.config/fzf/.fzf.bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# TeX Live 2025 paths
[ -d "$HOME/tools/texlive/2025/bin/x86_64-linux" ] && export PATH="$HOME/tools/texlive/2025/bin/x86_64-linux:$PATH"
[ -d "$HOME/tools/texlive/2025/texmf-dist/doc/man" ] && export MANPATH="$HOME/tools/texlive/2025/texmf-dist/doc/man:$MANPATH"
[ -d "$HOME/tools/texlive/2025/texmf-dist/doc/info" ] && export INFOPATH="$HOME/tools/texlive/2025/texmf-dist/doc/info:$INFOPATH"
