#!/bin/bash

###################################
# Update and Upgrade
###################################
echo
echo "Updating and upgrading..."
echo
apt-get update && apt-get full-upgrade -y

###################################
# Function
###################################

function install {
    for var in "$@"
    do
        which $var &> /dev/null

        if [ $? -ne 0 ]; then
            echo "Installing: ${var}..."
            sudo apt install -y $var
        else
            echo "Already installed: ${var}"
        fi
    done
}

###################################
# Installations
###################################
echo
echo "Installing programs..."
echo

### basic

install chrome-gnome-shell
install chromium-browser
install curl
install exfat-utils
install file
install git
install htop
install vim
install wget
install tree
install thefuck
install gnupg ca-certificates

### tools
install vlc skype ubuntu-restricted-addons

# install skype

### repositories
install git ssh openssh-server filezilla filezilla-common

### latex
install texlive-full

### gnome
install gnome-tweaks -y
install chrome-gnome-shell -y

### archieve
install rar unrar p7zip-full p7zip-rar -y

### wine

install wine64 wine32

### synaptic 

install synaptic

### stacer

# wget https://github.com/oguzhaninan/Stacer/releases/download/v1.0.4/Stacer_1.0.4_amd64.deb
# sudo dpkg --install Stacer_1.0.4_amd64.deb

sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt-get update
sudo apt-get install stacer
### gaming

install steam

### flatpack

install flatpak
install snap

### gimp

install gimp

### Fonts
install Ubuntu-restricted-extras font-manager
### Keepass

install keepassxc
# https://ssd.eff.org/fr/module/guide-pratique-utiliser-keepassxc

### batetry life saver

install tlp tlp-rdw

### python
install python3-pip
pip3 install numpy

### terminator

# sudo add-apt-repository ppa:gnome-terminator
# sudo apt-get update -y
sudo apt-get install terminator

### c++

sudo apt install g++
sudo apt install build-essential

### Rust

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

### Fun

install cmatrix sl neofetch hollywood

### Ubuntu cleaner

sudo add-apt-repository ppa:gerardpuig/ppa
sudo apt-get update
sudo apt-get install ubuntu-cleaner -y

### preloader

install preload

### bleachbit

install bleachbit

# sudo apt-get  install git gnome-tweak-tool synaptic wine64 -y
# git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
# ~/.bash_it/install.sh
# sudo apt-get install  -y
# sudo apt-get install synaptic
# sudo apt remove apport apport-gtk
# sudo apt-get install Ubuntu-restricted-extras
# sudo apt-get install tlp tlp-rdw
# sudo systemct1 enable tlp


# sudo apt-get install gnome-software-plugin-flatpak
# sudo add-apt-repository ppa:gerardpuig/ppa
# sudo apt-get update
# sudo apt-get install Ubuntu-cleaner
# sudo apt install steam
# sudo add-apt-repository ppa:otto-kesselgulasch/gimp
# sudo apt-get update


###################################
# Cleaning
###################################
echo
echo "Cleaning..."
sudo apt upgrade -y
sudo apt-get autoclean
sudo apt-get clean
sudo apt-get autoremove

###################################
# Directory management
###################################
echo
echo "Creating directories"


mkdir -p ~/Workspace/
mkdir -p ~/Videos/Movies
mkdir -p ~/Documents/Personal
mkdir -p ~/Documents/Administrative

###################################
# Finish!
###################################
echo
echo "Finish! All done!"
echo

###################################
# Look for more !
###################################
echo
echo "https://www.tecmint.com/things-to-do-after-installing-ubuntu-20-04/"
echo "https://www.omgubuntu.co.uk/2020/04/things-to-do-after-installing-ubuntu"
echo "https://www.youtube.com/watch?v=MNX7HgcWqHc"
echo "https://victoria.dev/blog/how-to-set-up-a-fresh-ubuntu-desktop-using-only-dotfiles-and-bash-scripts/"

echo "install the drivers" 

###################################
# Reboot
###################################

sudo reboot


###################################
# TODO
###################################


# Window tiling
# Themes
# finish directory system
# swap
# install chromium
# dropbox
# spotify
# change host name
# prefix usr/local
# telegram
# Organize My Files

# theme https://www.reddit.com/r/unixporn/comments/it4fut/gnome_material_shell_one_year_update/
# https://material-shell.com/#material-shell
# https://linuxhint.com/25_best_gnome_extensions/
# https://itsfoss.com/speed-up-ubuntu-1310/