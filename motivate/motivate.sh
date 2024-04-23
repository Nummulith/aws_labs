#!/bin/bash -v


# git

sudo yum install git -qy


# motivate

git clone https://github.com/mubaris/motivate.git
cd motivate/motivate
sudo ./install.sh
source ~/.bashrc


# cowsay

sudo yum install cowsay -qy


# run

motivate | cowsay -f $(ls /usr/share/cowsay/ | shuf -n1)
