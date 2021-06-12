#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

HISTSIZE=-1
export PATH=$PATH:~/.cargo/bin/
export BAT_PAGER="less -iFx4 --mouse --wheel-lines=4"
export EXA_COLORS="reset:ex=31" # only color directories and executables

alias lsx='exa -lbh --group-directories-first'
alias loc='tokei' # lines of code
alias catr='cat -v' # cat-raw

alias gu='git-user'
alias gua='git-user add'
alias guc='git-user current'

source ~/.config/broot/launcher/bash/br
