#!/bin/bash


# sudo apt install zsh -y
# echo "install oh my zsh..."
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# echo "--------------------"


cp .zshrc ~/

echo "install plugins for zsh"
cd ~/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
source ~/.zshrc
cd ~
echo "--------------------"
