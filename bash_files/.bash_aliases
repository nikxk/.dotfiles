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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# quickies
alias v='nvim'
alias g='gitui'
alias p='python'
t() { tmux attach 2>/dev/null || tmux; }

alias sauu='sudo apt update && sudo apt upgrade -y'
alias sai='sudo apt install -y'

alias rsynci='rsync -azh --info=progress2'

alias cd.='cd ..'
alias cd..='cd ../..'
alias cd...='cd ../../..'
alias cd....='cd ../../../..'
alias cdd='cd ~/downloads'

# For making and changing into a directory
mkcd() {
	mkdir -p "$1" && cd "$1"
}

# rare
alias show_colors='for i in {0..255}; do  printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i ; if ! (( ($i + 1 ) % 8 )); then echo ; fi ; done'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
