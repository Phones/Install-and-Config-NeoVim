#!/bin/bash

# ------ Colors ------
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
# -------------------

# ------------------  print with color -----------------------
function pwc()
{
    text_color=${1^^}
    text=${2^^}

    echo -e "\e${!text_color} ${text} ${NC}"
}
# ------------------- System Update ------------------

function update_system()
{
    pwc "blue" "atualizando o sistema"
    sudo apt-get update -y
    # sudo apt-get upgrade -y
}
# ----------------------------------------------------

# --------------- Verify if Plug.vim exist -----------
function check_plug_file()
{
    FILE_PATH=$(pwd)/nvim/autoload/plug.vim
    if ! test -f "$FILE_PATH"; then
        pwd "yellow" "vim plug file does not exist, downloading"
        wget -P $(pwd)/nvim/autoload/ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        pwd "yellow" "Vim Plug File Exist"
    fi
}
#-----------------------------------------------------

pwc "blue" "Update System"
update_system

pwc "blue" "Install git and wget"
sudo apt-get install wget &>/dev/null

pwc "blue" "Download NeoVim"
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb

pwc "blue" "Install NeoVim"
sudo dpkg -i nvim-linux64.deb

pwc "blue" "Download vim plug"
check_plug_file

pwc "blue" "Copying the folder with Settings"
cp -r nvim ~/.config

pwc "blue" "Install NeoVim Plugins"
nvim --headless +PlugInstall +qall

pwc "green" "NeoVim Installed and configured successfully!!!"