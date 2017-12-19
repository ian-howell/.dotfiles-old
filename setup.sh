#!/bin/bash
############################
# This script downloads and sets up an environment
############################

########## Variables

ARTIFACT_DIR = $HOME/setup_artifacts

VIM_ARTIFACTS = $ARTIFACT_DIR/vim_artifacts

##########

# Do this before moving into the artifacts directory
echo "Setting up dotfiles"
source setup_dotfiles.sh

echo "Setting up essentials"
apt-get -q=2 update
apt-get -q=2 install curl git make

# Create a directory to hold the artifacts from the setup process
if [ -e $ARTIFACT_DIR ]; then
    mkdir $ARTIFACT_DIR
fi
cd $ARTIFACT_DIR

echo "Setting up Vim"
if [ -e $VIM_ARTIFACTS ]; then
    mkdir $VIM_ARTIFACTS
fi
cd $VIM_ARTIFACTS
# Get vim source
git clone https://github.com/vim/vim.git

# Build and configure
make
make install

# Get and configure Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
cd $ARTIFACT_DIR
