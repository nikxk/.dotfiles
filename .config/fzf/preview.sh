#!/bin/sh
# Preview helper for fzf. Shared by .fzf.bash and .fzf.zsh.
#
# Usage:
#   preview.sh tree [DIR]   - print the deepest `tree` view that fits in $LINES
#   preview.sh PATH         - bat preview for files, treefit for dirs

treefit() {
    o=""
    for d in 3 2 1; do
        o=$(tree -CFt -L "$d" "${1:-.}" 2>/dev/null)
        h=$(printf "%s\n" "$o" | wc -l)
        if [ "$h" -le "${LINES:-40}" ]; then
            printf "%s\n" "$o"
            return
        fi
    done
    printf "%s\n" "$o"
}

case "$1" in
    tree) treefit "${2:-.}" ;;
    "")   treefit . ;;
    *)
        if   [ -f "$1" ]; then bat --color=always --style=changes,header,grid "$1"
        elif [ -d "$1" ]; then treefit "$1"
        else echo "Not a file or directory."
        fi
        ;;
esac
