#!/bin/bash

function install {
    for var in "$@"
    do
        which $var &> /dev/null

        if [ $? -ne 0 ]; then
            echo "Installing: ${var}..."
            sudo apt install -y $var
        else
            echo "Already installed: ${var}"
        fi
    done
}

function vs_install {
    for var in "$@"
    do
        name="${var}"
        code --install-extension ${name} --force
    done
}


### vscode

echo "⌨️  Installing VSCode"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
install apt-transport-https
sudo apt update


install code

#generate list of extention with code --list-extensions
# vs_install 