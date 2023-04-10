export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git
         zsh-autosuggestions
         zsh-syntax-highlighting
         extract
        )

source $ZSH/oh-my-zsh.sh

alias vim=nvim
alias kc=kubectl
alias kb=kubebuilder
alias proxy=proxy.sh
alias nv=neovide
alias proxy="source /root/proxy.sh"
alias lg=lazygit
. /root/proxy.sh set

# export PATH=$PATH:/usr/local/nvim-linux64/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/node-v18.15.0-linux-x64/bin
export PATH=$PATH:/usr/local/jdk-17.0.5/bin
export PATH=$PATH:/root/go/bin
export PATH=$PATH:/root

# autojump git clone git://github.com/wting/autojump.git || cd autojump || ./install.py
[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
