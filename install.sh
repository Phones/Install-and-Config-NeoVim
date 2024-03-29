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

    if [ $total -eq $current ]; then
        echo -ne "\e${GREEN}\r | Script Progress: [${done_sub_bar}${todo_sub_bar}] ${percent}% |${NC}\n"
    else
        echo -ne "\e${YELLOW}\r  Script Progress: [${done_sub_bar}${todo_sub_bar}] ${percent}%${NC}\n"
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
        pwc "yellow" "vim plug file does not exist, downloading"
        wget -P $(pwd)/nvim/autoload/ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        pwc "yellow" "Vim Plug File Exist"
    fi
    sleep 1
}
#-----------------------------------------------------

# --------------- Verify if nvim-linux64.deb exist -----------
function check_nvim_installer_file()
{
    FILE_PATH=$(pwd)/nvim-linux64.deb
    if ! test -f "$FILE_PATH"; then
        pwc "yellow" "Nvim installer file does not exist, downloading"
        wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb &>/dev/null
    else 
        pwc "yellow" "Nvim installer File Exist"
    fi
    sleep 1
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
    pwc "blue" "----------------------------------------------------------------------"
    sleep 0.5
}

function install_prerequisites()
{
    sudo apt-get install wget git python3 python3-pip python-is-python3 gcc g++ cmake
}

function delete_downloaded_files()
{
    vim_plug_path=$(pwd)/nvim/autoload/plug.vim
    rm -rf $vim_plug_path
    rm -rf nvim-linux64.deb
}

function clean_old_packages()
{
    sudo apt-get autoremove -y &>/dev/null
    sudo apt-get autoclean -y &>/dev/null
}

function remove_old_neovim()
{
    sudo apt-get purge neovim -y &>/dev/null
    sudo snap remove neovim &>/dev/null
    
    read -p "Do you want to backup your nvim folder?[y/n] " backup_nvim
    backup_nvim=${backup_nvim^^}
    if [ $backup_nvim = "N" ]; then
        rm -rf /home/$USER/.config/nvim
    else
        mv /home/$USER/.config/nvim /home/$USER/.config/nvim.backup
    fi
}

function install_nodejs()
{
    sudo apt-get purge nodejs -y &>/dev/null
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - 
    sudo apt install -y nodejs
}


function check_and_install_nodejs()
{
    # check nodejs exist
    if node --version >/dev/null 2>&1; then
        #check nodejs version
        nodejs_version=$(node --version)
        required_version="v16.0.0"

        pwc "blue" "Node exist! Node version: $nodejs_version"
        printf -v versions '%s\n%s' "$nodejs_version" "$required_version"
        if [[ $versions = "$(sort -V <<< "$versions")" ]]; then
            pwc "blue" "Removing old nodejs and install new version" 
            sudo apt-get purge node
            install_nodejs
        else
            pwc "green" "Node version found already meets the requirements"
        fi
    else
        pwc "green" "installing node js"
        install_nodejs
    fi
    # for the user to see the prints
    sleep 2
}

#------ Installation and configuration commands ------
declare -a TEXT_NAME_COMANDS=(
    "------------------Removing old NeoVim --------------------"
    "------------------ check and install nodejs --------------"
    "-----------------Cleaning old packages -------------------"
    "------------------ Update System -------------------------"
    "--------------- Install prerequisites --------------------"
    "------------- Install pynvim black flake8 ----------------"
    "------------------- Download NeoVim ----------------------"
    "-------------------- Install NeoVim ----------------------"
    "------------------ Download vim plug ---------------------"
    "------------ Copying the folder with Settings-------------"
    "----------------- Install NeoVim Plugins -----------------"
    "---------------- Delete downloaded files -----------------"
)

declare -a ALL_COMANDS=(
    "remove_old_neovim"
    "check_and_install_nodejs"
    "clean_old_packages"
    "update_system"
    "install_prerequisites"
    "pip install pynvim black flake8"
    "check_nvim_installer_file"
    "sudo dpkg -i nvim-linux64.deb"
    "check_plug_file"
    "cp -r nvim /home/$USER/.config/"
    "nvim --headless +PlugInstall +qall"
    "delete_downloaded_files"
)
#-----------------------------------------------------


num_comands=${#ALL_COMANDS[@]}
pwc "green" "Num comands: ${num_comands}"
for ((i = 0; i < ${num_comands}; i++)); do
    try
    (
        clear
        pwc "blue" "${TEXT_NAME_COMANDS[$i]}> Step [$i/$num_comands]"
        show_progress $i $num_comands
        line-with_sleep
        ${ALL_COMANDS[$i]}
    )
    catch
done

clear
pwc "green" "======================================================================="
pwc "green" "|          ✅ NeoVim Installed and configured successfully ✅         |"
pwc "green" "======================================================================="
show_progress $num_comands $num_comands
pwc "green" "======================================================================="
