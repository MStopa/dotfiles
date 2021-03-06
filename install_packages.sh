#!/bin/bash

APT_PACKAGES="stow git vim-gtk3 curl fortune clang cowsay build-essential cmake python3-dev python-pip python3-venv screenfetch tmux compiz-plugins-extra clipit zsh tig ranger cheat jq"

SNAP_PACKAGES="rg"

PIP_PACKAGES="pip virtualenv sudocabulary"

# It is possible that you don't need all these packages at the moment
echo -e "\e[30;47mInstalling apt packages.\e[0m"
apt update
apt -y install $APT_PACKAGES
apt upgrade

echo -e "\e[30;47mInstalling snap packages.\e[0m"
apt update
apt -y install $APT_PACKAGES
apt upgrade

# Install ripgrep (grep on steroids)
./install-ripgrep-on-ubuntu.sh

# Install highlight
# http://www.andre-simon.de/doku/highlight/en/install.php

# Install GNU parallel
# http://oletange.blogspot.com/2013/04/why-not-install-gnu-parallel.html

echo -e "\e[30;47mInstalling pip packages.\e[0m"
pip install --upgrade $PIP_PACKAGES

echo -e "\e[30;47mInstalling pip packages.\e[0m"
pip install --upgrade $PIP_PACKAGES


# zsh and customizations
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


# setup zsh as default shell (needed logout)
chsh -s $(which zsh)


# enable zsh plugins and show full filepath in shell prompt
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

sed -i "s/%c/%d/g" ~/.oh-my-zsh/themes/robbyrussell.zsh-theme
sed -i "s/^plugins=.*$/plugins=(git history history-substring-search dircycle dirhistory fasd vi-mode last-working-dir zsh-autosuggestions zsh-syntax-highlighting)/g" ~/.zshrc


# tmux with sane configuration. You can further adjust it later with dotfiles/tmux/ files
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .


# powerlevel10k (faster than powerlevel9k) and nerd fonts
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

cd
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh

# fasd (z) (check if current release is supported)
sudo add-apt-repository ppa:aacebedo/fasd
sudo apt-get update
sudo apt-get install fasd

#fzf (ctrl-R ctrl-T)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


# Below are things Vim related. It is possible that you don't want them!


#setup vim vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#install gnu global
echo "use: https://gist.github.com/y2kr/2ff0d3e1c7f20b0925b2"
echo "check for never link (6.6.4) and later"

# custom python folding rules for vim
mkdir ~/.vim/syntax
wget https://www.vim.org/scripts/download_script.php?src_id=9584

#echo -e "\e[30;47mInstalling Pathogen.\e[0m"
#mkdir -p ~/.vim/autoload ~/.vim/bundle && \
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# compiling YCM (obsolete, we have better things now, will be updated soon)
#cd ~/.vim/bundle/YouCompleteMe;./install.py --clang-completer

# now compare your ~/.zshrc with dotfiles/zsh/.zshrc and update your configuration with proper things
