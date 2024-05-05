
## Instructions for setting up a new workspace
1. Install Ubuntu 20.04
   1. Download it [here](https://releases.ubuntu.com/focal/)
   1. Install instructions [here](https://help.ubuntu.com/community/Installation/FromUSBStick) for USB stick
   1. Etch it onto a USB drive using [balena etcher](https://etcher.balena.io/#download-etcher)
   1. Restart the new PC with the USB drive plugged in and install Ubuntu.
   1. Take out the USB stick and restart the PC.
   1. Log in, plug in the USB and use gparted to free it.
1. Install a browser (Google Chrome)
   ```sh
   wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
   sudo dpkg -i google-chrome-stable_current_amd64.deb
   rm google-chrome-stable_current_amd64.deb
   ```
1. Install some necessary software:
   ```sh
   sudo apt update
   sudo apt install git vim tmux net-tools openssh-client openssh-server neofetch curl bat htop python-is-python3 python3-pip python3.8-venv ripgrep gnome-shell-extension-system-monitor gnome-tweaks
   mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat
   ```
1. Follow the instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) to set up SSH for connecting with GitHub.
1. Clone this repository
   ```sh
   git clone git@github.com:nikxk/.dotfiles.git ~/.dotfiles
   ```
1. Run this command (it adds all files in the git repo except the README to the root folder):
   ```bash
   find ~/.dotfiles/ -mindepth 1 -maxdepth 1 -name ".*" ! -name ".git" -exec ln -fs {} ~/ \;
   ```
1. Run this command, which adds `tmux-plugins`:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   python3 -m pip install --user libtmux
   ```
   And from inside tmux, do `prefix+r` to reload and `prefix+I` to install the plugins.
1. For installing [fzf](https://github.com/junegunn/fzf):
   ```bash
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   ```
1. For installing [broot](https://github.com/Canop/broot), [dua](https://github.com/Byron/dua-cli), [gitui](https://github.com/extrawurst/gitui) and [bottom](https://github.com/ClementTsang/bottom):

   Install rust from [here](https://rustup.rs/). Then 
   ```bash
   sudo apt install build-essential libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev -y
   cargo install --locked broot
   cargo install dua-cli
   cargo install gitui
   cargo install bottom --locked
   
   broot
   ```
1. For installing [gitmux](https://github.com/arl/gitmux):

   Install Go from [here](https://go.dev/doc/install). Then
   ```sh
   go install github.com/arl/gitmux@latest
   ```

Also check out 
- [peek](https://github.com/phw/peek) (for getting gifs of the screen)

---
## Using TMUX

1. The `prefix` is `C-Space`.
1. New pane/window/session
   
   (They open in the same path as the current pane.)

   - Pane: `prefix + -` to split vertically, `prefix + =` to split horizontally
   - Window: `prefix + c`
   - Session: `prefix + C` and enter the name of the new session
1. Break into window/session

   - Pane into window: `prefix + b`
   - Window into session: `prefix + B` and enter session name
1. Kill window/session

   - Kill window: `prefix + k`
   - Kill session: `prefix + K`
1. Switch panes: `M-Left`, `M-Right`, `M-Up`, `M-Down` or `M-h`, `M-l`, `M-k`, `M-j`
1. Switch windows: `M-J` for previous, `M-K` for next, `C-\` for last
1. Switch sessions: `M-H` for previous, `M-L` for next
1. Maximize/minimize pane: `C-q`
1. Copy mode:
   
   Enter the vi copy mode using `prefix + [`. Use `v` to select (then `r` for rectangle selection), `y` to yank and quit.
1. Use `prefix + C-s` to save the tmux sessions, windows and pane paths and positions. This is reloaded across system reboots or on `prefix + C-r`.
   
