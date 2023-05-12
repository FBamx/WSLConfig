#!/bin/bash

# This scirpt will install various necessary tools
# for the new environment
# please use bash install.sh not sudo bash isntall.sh
# test

hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
wslip=$(hostname -I | awk '{print $1}')
port=10809

PROXY_HTTP="http://${hostip}:${port}"

export http_proxy="${PROXY_HTTP}"
export HTTP_PROXY="${PROXY_HTTP}"
export https_proxy="${PROXY_HTTP}"
export HTTPS_proxy="${PROXY_HTTP}"

echo "apt install ..."
sudo apt update
sudo apt install net-tools -y
sudo apt install make -y
sudo apt install xsel -y
sudo apt install openssh-server -y
sudo apt install gcc -y
sudo apt install g++ -y
sudo apt isntall wget -y
sudo apt install ripgrep -y
sudo apt install fd-find -y
sudo apt install curl -y
sudo apt install libevent-dev -y
sudo apt install tmux -y
sudo apt install python3.10 -y
echo "--------------------"

echo "install docker"
sudo apt-get install \
	ca-certificates \
	gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
	"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
	sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
echo "--------------------"

echo "test proxy"
curl google.com
echo "--------------------"

cp .tmux.conf ~/
cp proxy.sh ~/
cp jandedobbeleer.omp.json ~/

echo "install go"
wget https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x ./installer_linux
./installer_linux
echo "--------------------"

echo "install lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
echo "--------------------"

echo "install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "--------------------"

echo "install nodejs"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install v16.8.0
echo "--------------------"

echo "install nvim"
wget https://github.com/neovim/neovim/releases/tag/stable/nvim.appimage
chmod u+x nvim.appimage && sudo mv nvim.appimage /usr/bin/nvim
echo "--------------------"

echo "install lf"
wget https://github.com/gokcehan/lf/releases/download/r29/lf-linux-amd64.tar.gz
chmod u+x lf-linux-amd64.tar.gz
tar -zxvf lf-linux-amd64.tar.gz
sudo mv lf /usr/local/bin
rm -rf lf-linux-amd64.tar.gz
mkdir -p ~/.config/lf
cp ./lfrc ~/.config/lf
curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example -o ~/.config/lf/colors
curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example -o ~/.config/lf/icons
echo "--------------------"

echo "install nvim && download nvim conf from github"
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage && sudo mv nvim.appimage /usr/bin/nvim
git clone https://github.com/FBamx/nvchad.git -b master ~/.config/nvim
echo "--------------------"

echo "install logo-ls"
wget https://github.com/Yash-Handa/logo-ls/releases/download/v1.3.7/logo-ls_Linux_x86_64.tar.gz
chmod u+x logo-ls_Linux_x86_64.tar.gz
tar -zxvf logo-ls_Linux_x86_64.tar.gz
cd logo-ls_Linux_x86_64
sudo cp logo-ls /usr/local/bin
sudo cp logo-ls.1.gz /usr/share/man/man1/
cd .. && rm -rf logo-ls*
echo "--------------------"

echo "install autojump"
git clone https://github.com/wting/autojump.git
sudo ln -s /usr/bin/python3 /usr/bin/python
cd autojump
./install.py
cd .. && rm -rf autojump
echo "--------------------"

echo "if the environment is WSL, please configure /etc/wsl.conf like follow"
echo "[boot]"
echo "systemd=true"
echo "done"
