#!/bin/bash

# ------ Colors ------
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
# -------------------

# ---------------------------------- Script Progress Bar -------------------------------
# Function progress bar code: https://www.baeldung.com/linux/command-line-progress-bar
bar_size=40
bar_char_done="#"
bar_char_todo="-"
bar_percentage_scale=2

function show_progress {
    current="$1"
    total="$2"

    # calculate the progress in percentage 
    percent=$(bc <<< "scale=$bar_percentage_scale; 100 * $current / $total" )
    # The number of done and todo characters
    done=$(bc <<< "scale=0; $bar_size * $percent / 100" )
    todo=$(bc <<< "scale=0; $bar_size - $done" )

    # build the done and todo sub-bars
    done_sub_bar=$(printf "%${done}s" | tr " " "${bar_char_done}")
    todo_sub_bar=$(printf "%${todo}s" | tr " " "${bar_char_todo}")

    # output the bar
    echo -ne "\e${YELLOW}\rScript Progress : [${done_sub_bar}${todo_sub_bar}] ${percent}%${NC}\n"

    if [ $total -eq $current ]; then
        echo -e "\nDONE"
    fi
    sleep 0.5
}
# --------------------------------------------------------------------------------------

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
    sudo apt-get update -y &>/dev/null
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

# ------------------- Try Catch ----------------------
function try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set -e
}

function catch()
{
    errorCode=$?
    if [ $errorCode -ne 0 ]; then
    echo "Error in execute script!"
    exit $errorCode
    fi
}
#-----------------------------------------------------

function line-()
{
    pwd "blue" "------------------------------------------------------------------"
}

try
(
    clear
    pwc "blue" "-------------- Update System ----------------"
    show_progress 1 7
    update_system

    clear
    pwc "blue" "------------ Install git and wget -----------"
    show_progress 2 7
    sudo apt-get install wget &>/dev/null

    clear
    pwc "blue" "-------------- Download NeoVim --------------"
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb &>/dev/null
    show_progress 3 7

    clear
    pwc "blue" "-------------- Install NeoVim ---------------"
    show_progress 4 7
    sudo dpkg -i nvim-linux64.deb

    clear
    pwc "blue" "------------ Download vim plug --------------"
    show_progress 5 7
    check_plug_file

    clear
    pwc "blue" "------ Copying the folder with Settings------"
    show_progress 6 7
    cp -r nvim ~/.config

    clear
    pwc "blue" "---------- Install NeoVim Plugins -----------"
    show_progress 7 7
    nvim --headless +PlugInstall +qall

    clear
    pwc "green" "==================================================="
    pwc "green" "| NeoVim Installed and configured successfully ✅ |"
    pwc "green" "==================================================="
)
catch