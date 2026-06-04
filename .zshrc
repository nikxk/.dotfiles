# ~/.zshrc: executed by zsh for interactive shells.
# Mirrors ~/.bashrc, adapted for zsh.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load aliases (shared with bash)
[ -f "${HOME}/.dotfiles/bash_files/.bash_aliases" ] && . "${HOME}/.dotfiles/bash_files/.bash_aliases"

## HISTORY ##
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=100000
setopt APPEND_HISTORY         # append, don't overwrite
setopt INC_APPEND_HISTORY     # write to history file immediately, not at exit
setopt SHARE_HISTORY          # share history across running shells
setopt HIST_IGNORE_DUPS       # don't store consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS   # also remove older duplicate entries
setopt HIST_IGNORE_SPACE      # commands starting with space aren't saved
setopt HIST_REDUCE_BLANKS     # trim superfluous whitespace from entries
setopt HIST_VERIFY            # show !! expansion before running it

## DIRECTORY NAVIGATION ##
setopt AUTO_CD                # bare directory name => cd into it
setopt AUTO_PUSHD             # every cd pushes to the dir stack
setopt PUSHD_IGNORE_DUPS      # don't push duplicates onto the stack
setopt PUSHD_SILENT           # quiet pushd/popd
setopt CORRECT                # spelling correction for commands
setopt EXTENDED_GLOB          # enables ^, ~, # glob operators

## COMPLETION ##
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Hostname completion for ssh / scp / sftp / rsync from ~/.ssh/config Host entries.
# Restricting tag-order to `hosts` keeps macOS daemon users (_amavisd, _ard, ...)
# out of the candidate list, mirroring bash's `_known_hosts` behavior.
() {
    local -a hosts
    [[ -r ~/.ssh/config ]] && \
        hosts=( ${(s: :)${${(M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }} )
    hosts=( ${hosts:#*[*?]*} )      # drop wildcards like `Host *`
    zstyle ':completion:*:(ssh|scp|sftp|rsync):*' hosts $hosts
    zstyle ':completion:*:(ssh|scp|sftp|rsync):*' tag-order 'hosts'
}

## KEY BINDINGS ##
bindkey -e                    # emacs-style line editing (^A, ^E, ^R, ...)
# Up/Down: search history for entries that start with what you've typed so far
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
# Ctrl-X Ctrl-E: open $EDITOR to edit the current command line (like bash)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

## PROMPT ##
# %3~ = current dir, last 3 components (like PROMPT_DIRTRIM=3 in bash)
setopt PROMPT_SUBST
PROMPT='%F{27}%3~%f %F{42}❯%f '

## ENV ##
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export VISUAL=vim
export EDITOR="$VISUAL"

[ -f ~/.ssh/id_ed25519 ] && ssh-add -q ~/.ssh/id_ed25519 2>/dev/null

## PATH ##
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "/usr/local/go/bin" ] && export PATH="$PATH:/usr/local/go/bin"
[ -d "$HOME/go/bin" ] && export PATH="$PATH:$HOME/go/bin"
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# fzf: prefer the zsh integration, fall back to the bash one
if [ -f "$HOME/.config/fzf/.fzf.zsh" ]; then
    source "$HOME/.config/fzf/.fzf.zsh"
elif [ -f "$HOME/.config/fzf/.fzf.bash" ]; then
    source "$HOME/.config/fzf/.fzf.bash"
fi

# broot launcher (`br` function)
[ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

# De-duplicate $PATH (zsh keeps `path` and `PATH` linked; -U enforces uniqueness)
typeset -U path PATH


# Added by Antigravity CLI installer
export PATH="/Users/nsk/.local/bin:$PATH"
