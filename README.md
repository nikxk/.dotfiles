
## Instructions for setting up a new workspace
1. Follow the instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) to set up SSH for connecting with Github.
2. At the root (~), clone this repository.
3. Run this command (it adds all files in the git repo except the README to the root folder):
```bash
find ~/.dotfile-collection/ -mindepth 1 -maxdepth 1 ! -name 'README.md' ! -name '.git' -exec ln -fs {} ~/ \;
```
4. Run this command, which adds `tmux-plugins`:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
