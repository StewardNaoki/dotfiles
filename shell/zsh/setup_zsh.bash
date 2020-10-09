#!/bin/bash

OH_MY_ZSH=$HOME"/.oh-my-zsh"


_install_oh_my_zsh() {
    if [ -d "${OH_MY_ZSH}"  ]; then
        cd "${OH_MY_ZSH}"
        echo "Change directory to `pwd`"
        echo "${OH_MY_ZSH} exists. Git pull to update..."
        git pull
        cd - > /dev/null 2>&1
        echo "Change directory back to `pwd`"
    else
        echo "${OH_MY_ZSH} not exists. Install..."
        #git clone git@github.com:robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
        #wget --no-check-certificate http://install.ohmyz.sh -O - | sh
        git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
    fi
}

config_zsh() {
    _install_oh_my_zsh
    create_symlinks "zsh/zshrc" ".zshrc"
    _config_shell
    # TODO: See ~/.oh-my-zsh/custom/
    create_symlinks "zsh/tanky.zsh-theme" "${OH_MY_ZSH}/themes/tanky.zsh-theme"
    # chsh -s `which zsh` # TODO: If zsh is an alias?
    echo "[INFO] Change your shell manually"
}

# sudo apt install zsh
# # # chsh -s $(which zsh)
# # cd ~ && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

cp $my_dir/naoki.zsh-theme ~/.oh-my-zsh/custom/themes/naoki.zsh-theme

# echo $my_dir/naoki.zsh-theme
