#!/bin/bash

# This scirpt will install various necessary tools
# for the new environment

echo "apt install ..."
sudo apt update
sudo apt install net-tools
sudo apt install openssh-server
sudo apt install gcc
sudo apt install g++
sudo apt install ripgrep
sudo apt install fd-find
sudo apt install zsh
sudo apt install curl
echo "--------------------"

cd ~

echo "install oh my zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "--------------------"


echo "install plugins for zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins
echo "--------------------"

echo "git clone WSLConfig"
git clone https://github.com/FBamx/WSLConfig.git
mv WSLConfig/* WSLConfig/.zshrc WSLConfig/.tmux.conf ./
echo "--------------------"


echo "install lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
echo "--------------------"


echo "install nvim"
curl -L https://github.com/neovim/neovim/releases/tag/stable/nvim.appimage
chmod u+x nvim.appimage && sudo mv nvim.appimage /usr/bin/nvim
echo "--------------------"


echo "git clone nvim conf"
git clone https://github.com/FBamx/lazynvim.git -b master ~/.config/nvim
echo "--------------------"


echo "install docker"
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "--------------------"


echo "if the environment is WSL, please configure /etc/wsl.conf like follow"
echo "[boot]"
echo "systemd=true"
echo "done"

