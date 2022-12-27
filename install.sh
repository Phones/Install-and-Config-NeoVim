#!/bin/bash -i

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
    echo -ne "\e${YELLOW}\r  Script Progress: [${done_sub_bar}${todo_sub_bar}] ${percent}%${NC}\n"

    if [ $total -eq $current ]; then
        echo -e "\nDONE"
    fi
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

function line-with_sleep()
{
    pwc "blue" "--------------------------------------------------------------------"
    sleep 0.5
}

function download_neo_vim()
{
    sudo apt-get install wget &>/dev/null
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb &>/dev/null
}

function install_you_complete_me_plugin()
{
    sudo apt get install build-essential cmake vim-nox python3-dev
}

#------ Installation and configuration commands ------
declare -a TEXT_NAME_COMANDS=(
    "------------------------ Update System -----------------------------"
    "-------------------------- install pynvim --------------------------"
    "------------------------- Download NeoVim --------------------------"
    "-------------------------- Install NeoVim --------------------------"
    "------------------------ Download vim plug -------------------------"
    "------------------ Copying the folder with Settings----------------"
    "----------------------- Install NeoVim Plugins ---------------------"
)

declare -a ALL_COMANDS=(
    "update_system"
    "pip install pynvim"
    "download_neo_vim"
    "sudo dpkg -i nvim-linux64.deb"
    "check_plug_file"
    "cp -r nvim .config"
    "pip install pynvim"
    "nvim --headless +PlugInstall +qall"
)
#-----------------------------------------------------

num_comands=${#ALL_COMANDS[@]}
pwc "green" "Num comands: ${num_comands}"
for ((i = 0; i < ${num_comands}; i++)); do
    try
    (
        clear
        pwc "blue" "${TEXT_NAME_COMANDS[$i]}"
        show_progress $i $num_comands
        line-with_sleep
        ${ALL_COMANDS[$i]}
    )
    catch
done

pwc "green" "==================================================="
pwc "green" "| NeoVim Installed and configured successfully ✅ |"
pwc "green" "==================================================="
