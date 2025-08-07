#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ..="cd .."
alias ....="cd ../.."

alias gs="git status"
alias ga="git add"
alias gc="git commit"

PS1='[\u@\h \W]\$ '


export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export SUDO_EDITOR="/usr/bin/nvim"
