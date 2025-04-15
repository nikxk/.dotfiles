# Setting up this repo

After [connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), 

```bash
git clone git@github.com:nikxk/.dotfiles.git ~/.dotfiles
```
Then add symlinks to necessary dotfiles:
```bash
find ~/.dotfiles/ -mindepth 1 -maxdepth 1 -name ".*" ! -name ".git" -exec ln -fs {} ~/ \;
```

Add the essential packages listed below. 
To set up tmux, install the [tmux plugin manager](https://github.com/tmux-plugins/tpm) and [gitmux](https://github.com/arl/gitmux).

# Useful packages

Here are some useful packages.

- Essentials

   ```
   tree git vim tmux 
   net-tools openssh-client openssh-server neofetch curl 
   htop btm fd-find bat ripgrep
   python3-pip
   ```
   To set up `bat` and `fd`, run
   ```sh
   mkdir -p ~/.local/bin 
   ln -s /usr/bin/batcat ~/.local/bin/bat
   ln -s $(which fdfind) ~/.local/bin/fd
   ```

- [fzf](https://github.com/junegunn/fzf) for fuzzy finding, navigating through the file system. 

  `C-t` for getting files, `M-c` for changing directories and `C-r` for using bash commands in bash history. Some add-ons are provided [here](./.config/fzf/.fzf.bash). Helps with [git](https://github.com/junegunn/fzf-git.sh) as well.

- [dua](https://github.com/Byron/dua-cli) for tracking memory usage per file/directory with a nice terminal interface

- [texlive](https://www.tug.org/texlive/quickinstall.html) for compiling LaTeX documents

Also check out 
- [broot](https://github.com/Canop/broot) as a file explorer
- [gitui](https://github.com/extrawurst/gitui) as a terminal UI for git
- [peek](https://github.com/phw/peek) for recording the screen to gifs
- [scrcpy](https://github.com/Genymobile/scrcpy) for interacting with Android phones
- [kwin-gestures](https://github.com/taj-ny/InputActions) for additional touchpad gestures on KDE Plasma, add [this](https://github.com/peterfajdiga/kwin4_effect_geometry_change) to smoothen
- `gnome-shell-extension-system-monitor`
- `gnome-tweaks`

---
# TMUX config

The `prefix` is `C-Space`.

1. Copy mode:
   
   Enter the vi copy mode using `prefix + [`. Use `v` to select (then `C-v` for rectangle selection) or `V` to select lines, `y` to yank and quit.
1. Use `prefix + C-s` to save the tmux sessions, windows and pane paths and positions. This is reloaded across system reboots or on `prefix + C-r`.

## Pane/Window/Session management

### Creation

They open in the same path as the current pane.

- Pane: `prefix + -` to split vertically, `prefix + =` to split horizontally
- Window: `prefix + c`
- Session: `prefix + C` and enter the name of the new session

### Switching

1. Switch panes: `M-Left`, `M-Right`, `M-Up`, `M-Down` or `M-h`, `M-l`, `M-k`, `M-j` to go left, right, up or down respectively.
1. Switch windows: `M-J` for previous, `M-K` for next, `C-\` for last
1. Switch sessions: `M-H` for previous, `M-L` for next

### Kill

`C-d` on a terminal closes it. Otherwise:

- Kill pane: `prefix + x`
- Kill window: `prefix + k`
- Kill session: `prefix + K`

### Breaking

- Break pane into window: `prefix + b`
- Break window into session: `prefix + B` and enter session name

### Other

- Maximize/minimize pane: `C-q`


---
`C-x` means Ctrl+x pressed together, `M-x` means Alt+x pressed together
