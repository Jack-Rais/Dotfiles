#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export SUDO_EDITOR="/usr/bin/nvim"
