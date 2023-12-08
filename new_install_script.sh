#!/bin/bash

sudo apt update
mkdir Downloads
cd Downloads

# install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# install git
sudo apt install git

# install tmux
sudo apt install tmux
