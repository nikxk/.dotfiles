# ~/.bashrc: executed by bash(1) for non-login shells.
# inspired by https://github.com/mrzool/bash-sensible/blob/master/sensible.bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Tell Readline to use the .inputrc file from the dotfiles directory
[ -f "${HOME}/.dotfiles/bash_files/.inputrc" ] && export INPUTRC="${HOME}/.dotfiles/bash_files/.inputrc"

# Source Bash history settings
[ -f "${HOME}/.dotfiles/bash_files/.history_settings" ] && . "${HOME}/.dotfiles/bash_files/.history_settings"

# Load aliases if available
[ -f "${HOME}/.dotfiles/bash_files/.bash_aliases" ] && . "${HOME}/.dotfiles/bash_files/.bash_aliases"

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

# set the bash prompt with fallback for virtual terminals
PROMPT_DIRTRIM=3
if [ "$TERM" = "linux" ]; then
    # Simple prompt for virtual console with standard '>' character
    PS1="\[\033[38;5;39m\]\w \[\033[0m\]\[\033[38;5;42m\]> \[\033[0m\]"
else
    # Rich prompt for graphical terminals with Unicode character
    PS1="\[\033[38;5;27m\]\w \[\033[0m\]\[\033[38;5;42m\]❯ \[\033[0m\]"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# make vim default editor
export VISUAL=vim
export EDITOR="$VISUAL"

[ -f ~/.ssh/id_ed25519 ] && ssh-add -q ~/.ssh/id_ed25519 2>/dev/null

[ -d "/usr/local/go/bin" ] && export PATH=$PATH:/usr/local/go/bin
[ -d "$HOME/tools/cargo/bin" ] && export PATH="$HOME/tools/cargo/bin:$PATH"
[ -f "$HOME/tools/cargo/env" ] && . "$HOME/tools/cargo/env"
[ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"
[ -f "$HOME/.config/fzf/.fzf.bash" ] && source "$HOME/.config/fzf/.fzf.bash"

# TeX Live 2025 paths
[ -d "$HOME/tools/texlive/2025/bin/x86_64-linux" ] && export PATH="$HOME/tools/texlive/2025/bin/x86_64-linux:$PATH"
[ -d "$HOME/tools/texlive/2025/texmf-dist/doc/man" ] && export MANPATH="$HOME/tools/texlive/2025/texmf-dist/doc/man:$MANPATH"
[ -d "$HOME/tools/texlive/2025/texmf-dist/doc/info" ] && export INFOPATH="$HOME/tools/texlive/2025/texmf-dist/doc/info:$INFOPATH"

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

# Remove duplicate entries from PATH
export PATH="$(awk -v RS=':' '!a[$1]++{if(NR>1)printf ":";printf $1}' <<<"$PATH")"
