
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
   sudo apt install git vim tmux net-tools openssh-client openssh-server neofetch curl bat
   mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat
   ```
1. Follow the instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) to set up SSH for connecting with GitHub.
1. Clone this repository
   ```sh
   git clone git@github.com:nikxk/.dotfiles.git ~/.dotfiles
   ```
1. Run this command (it adds all files in the git repo except the README to the root folder):
   ```bash
   find ~/.dotfiles/ -mindepth 1 -maxdepth 1 ! -name 'README.md' ! -name '.git' -exec ln -fs {} ~/ \;
   ```
1. Run this command, which adds `tmux-plugins`:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```
   And from inside tmux, do `prefix+r` to reload and `prefix+I` to install the plugins.
1. For installing [_fzf_](https://github.com/junegunn/fzf):
   ```bash
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   ```
1. For installing [broot](https://github.com/Canop/broot), [dua](https://github.com/Byron/dua-cli) and [gitui](https://github.com/extrawurst/gitui):

   Install rust from [here](https://rustup.rs/). Then 
   ```bash
   sudo apt install build-essential libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev -y
   cargo install --locked broot
   cargo install dua-cli
   cargo install gitui
   
   broot
   ```
1. For installing [gitmux](https://github.com/arl/gitmux):

   Install Go from [here](https://go.dev/doc/install). Then
   ```sh
   go install github.com/arl/gitmux@latest
   ```
