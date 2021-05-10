#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

export PATH=$PATH:~/.cargo/bin/
export BAT_PAGER="less -iFx4 --mouse --wheel-lines=4"
export EXA_COLORS="reset:ex=31"

alias lsx='exa -lbh --group-directories-first'

alias gu='git-user'
alias gua='git-user add'
alias guc='git-user current'

source ~/.config/broot/launcher/bash/br
