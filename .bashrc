#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
HISTSIZE=-1

export LC_ALL=C
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export PATH=$PATH:~/.cargo/bin/
export BAT_PAGER="less -iFx4 --mouse --wheel-lines=4"
export EXA_COLORS="reset:ex=31" # only color directories and executables

alias lsx='exa -lbh --group-directories-first'
alias loc='tokei' # lines of code
alias catr='cat -v' # cat-raw

alias gu='git-user'
alias gua='git-user add'
alias guc='git-user current'

alias neofetch='neofetch --off --color_blocks off | head -n -2'
alias cpu='echo -e "$(cat /proc/cpuinfo | grep "model name" | uniq | sed "s/.*model name[[:space:]:]*//")\n$(cat /proc/cpuinfo | grep -i "cpu cores" | uniq | sed "s/.*cpu cores[[:space:]:]*"//) Cores, $(cat /proc/cpuinfo | grep siblings | uniq | sed s/.*siblings[[:space:]:]*//) Threads\n$(lscpu | grep "CPU max MHz" | sed "s/.*CPU max MHz[[:space:]:]*//" | cut -f 1 -d ".") MHz"'
alias mainboard='cat /sys/devices/virtual/dmi/id/board_{vendor,name,version}' # ; sudo dmesg | grep DMI: | sed "s/.*DMI[[:space:]:]*//"
alias memory='echo $(perl -E "printf(\"%.1f\", $(cat /proc/meminfo | grep MemTotal | sed s/[^[:digit:]]//g)*1000/1024/1024/1024)") GiB Memory'
alias gpu='cat "/proc/driver/nvidia/gpus/0000:0a:00.0/information" | grep Model | sed s/.*Model[[:space:]:]*//' # only nvidia support
alias system='echo -e "CPU\n$(cpu | sed "s/^/> /")\n\nMemory\n$(memory | sed "s/^/> /")\n\nGPU\n$(gpu | sed "s/^/> /")\n\nMainboard\n$(mainboard | sed "s/^/> /")"'

source ~/.config/broot/launcher/bash/br
