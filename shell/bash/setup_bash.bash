#!/bin/bash

my_dir="$(dirname "$0")"

### bash-it
cd ~ && git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it &&~/.bash_it/install.sh
cp $my_dir/naoki ~/bash_it/themes/naoki
