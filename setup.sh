#!/bin/bash
############################
# This script downloads and sets up an environment
############################

########## Variables

ARTIFACT_DIR=$HOME/setup_artifacts

DOTFILES=$HOME/.dotfiles
VIM_ARTIFACTS=$ARTIFACT_DIR/vim_artifacts
COMPIZ_CONFIG_DIR=$HOME/.config/compiz-1/compizconfig/

##########

echo "Setting up essentials"
apt-get -q=2 update
apt-get -q=2 install curl git make

# Create a directory to hold the artifacts from the setup process
if [ ! -e $ARTIFACT_DIR ]; then
    mkdir $ARTIFACT_DIR
fi
cd $ARTIFACT_DIR

echo "Setting up Vim"

vim_exists=$(command -v vim)

if [[ $vim_exists -eq 0 ]]; then
    apt-get remove vim
fi

if [ ! -e $VIM_ARTIFACTS ]; then
    mkdir $VIM_ARTIFACTS
fi
cd $VIM_ARTIFACTS
# Get vim source
if [ -e vim ]; then
    rm -fr vim
fi
git clone https://github.com/vim/vim.git

# Build and configure
cd vim/src
make
make install

# Get and configure Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
cd $ARTIFACT_DIR

# Set up my dotfiles
if [ ! -e $DOTFILES ]; then
    git clone https://github.com/ian-howell/.dotfiles.git $DOTFILES
fi
cd $DOTFILES
source setup_dotfiles.sh

# Get compiz
echo "Getting Compiz"
apt-get install compiz compizconfig-settings-manager compiz-fusion-plugins-extra compiz-fusion-plugins-main compiz-plugins
mkdir -p $COMPIZ_CONFIG_DIR
cp $DOTFILES/compiz_profile.bak $COMPIZ_CONFIG_DIR/Default.ini
