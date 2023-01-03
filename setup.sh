#! /bin/bash

# Usage
# After a fresh (or not so fresh) install of linux, this script will allow me to install and maintain 
# certain configurations and themes that have been installed over and over

# Program Installations

function install_utils(){
    sudo apt-get install curl jq
}

function install_git(){
	command -v git 2>&1 >/dev/null 	# Taking output and sending it to dev/null (no output on screen)
	GIT_IS_PRESENT=$? 		# Check the error status. 0=OK
	if [[ $GET_IS_PRESENT -ne 0  ]]; then
		echo "Installing Git"
		sudo apt-get install git -y
	elif [[ $GET_IS_PRESENT -eq 0 ]]; then
	       echo "Git is installed"	
	fi
}

function install_vim(){
	command -v vim 2>&1 >/dev/null
	VIM_IS_PRESENT=$?
	# User vimrc file: "$HOME/.vimrc"
	VIMRC="$HOME/.vimrc"
	if [[ ! -e $VIMRC || .vimrc -nt $VIMRC || -s $VIMRC ]]; then # if .vimrc does not exist, source is newer, or existing is of size 0, add it.
		echo "Adding vimrc file to $HOME/.vimrc"
		ln -snf .vimrc $VIMRC
		if [[ $? -ne 0 ]]; then
			echo "Vim RC successfully created"
		else
			echo "Adding the .vimrc file was unsuccessful"
		fi
	else
		echo "Vimrc file is all set."
	fi	       
}


#function install_tmux(){
#
#}


# Theme Configuration
function install_conky(){
    command -v conky 2>&1 >/dev/null
    CONKY_IS_PRESENT=$?

    if [[ $CONKY_IS_PRESENT -ne 0 ]]; then
        echo "Conky is not present... Installing"
	sudo apt-get install conky-all -y
    else
        echo "Conky is present"
    fi
    #make symlinksi (Target -> Link Name)
    echo "Creating Synlinks"
    ln -snf $(pwd)/conky $HOME/.config/conky 
    # Add to crontab
    echo "Updating Users crontab"
    echo -e "#Launch Conky on start up\n@reboot /home/black/Projects/linux-config/conky/Betelgeuse/launch.sh" | crontab
    crontab -l
}



install_git
install_vim
install_conky
