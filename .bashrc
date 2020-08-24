# History control
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTFILESIZE=2000000
shopt -s histappend

# COLOURS! YAAAY!
export TERM=xterm-256color

# Obviously.
export EDITOR=/usr/bin/code

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi