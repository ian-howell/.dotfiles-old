#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in $HOME/.dotfiles
############################

########## Variables

dir=$HOME/.dotfiles                    # dotfiles directory
olddir=$HOME/.dotfiles_old             # old dotfiles backup directory
files="profile bashrc sh_aliases vim vimrc inputrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in $HOME ..."
mkdir -p $olddir

# change to the dotfiles directory
echo "Changing to the $dir directory ..."
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the $HOME/dotfiles directory specified in $files
echo "Moving any existing dotfiles from $HOME to $olddir"
for file in $files; do
    if [ -e $HOME/.$file ]; then
        mv $HOME/.$file $olddir
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file $HOME/.$file
done

# Create the vim directories
echo "Creating vim backup directory ..."
mkdir -p vim/undo

echo "done"
