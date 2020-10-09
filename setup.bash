#!/bin/bash
dotfilesDir=$(pwd)

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h ~/${1} ]; then
    # Existing symlink 
    echo "Removing existing symlink: ${dest}"
    rm ${dest} 

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${dotfilesDir}/${1} ${dest}
}

linkDotfile .bashrc
linkDotfile .bash_profile
linkDotfile .profile
linkDotfile .aliases

linkDotfile .zshrc

linkDotfile .gitconfig


# cat aliases.txt >> .bashrc
# cat aliases.txt >> .zshrc

### Bash-it
cd ~ && git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it &&~/.bash_it/install.sh
cp ${dotfilesDir}/bash/naoki ~/bash_it/themes/naoki


### zsh

sudo apt install zsh -y
chsh -s $(which zsh)
cd ~ && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

cp ${dotfilesDir}/zsh/naoki.zsh-theme ~/.oh-my-zsh/custom/themes/naoki.zsh-theme

