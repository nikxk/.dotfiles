
## Instructions for setting up a new workspace
1. Install Ubuntu 20.04
   1. Download it [here](https://releases.ubuntu.com/focal/)
   1. Install instructions [here](https://help.ubuntu.com/community/Installation/FromUSBStick) for US    B stick
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
   sudo apt install git vim tmux net-tools openssh-client openssh-server neofetch
   ```
1. Follow the instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) to set up SSH for connecting with Github.
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
1. For installing _fzf_:
   ```bash
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   ```
1. For installing _broot_ and _dua_:

   Install rust from [here](https://rustup.rs/). Then 
   ```bash
   sudo apt install build-essential libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev -y
   cargo install --locked broot
   cargo install dua-cli
   ```
