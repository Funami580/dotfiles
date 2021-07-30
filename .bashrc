#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
HISTSIZE=5000
HISTFILESIZE=-1
HISTIGNORE='&:[ ]*'

shopt -q -s histappend
shopt -q -s nocaseglob

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
alias hexv='hexv -f Hack'

# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages
alias pacsize='LC_ALL=C pacman -Qi | awk "/^Installed Size/{print \$4\$5}" | sed -e s/KiB/*1024/ -e s/MiB/*$((1024*1024))/ -e s/GiB/*$((1024*1024*1024))/ | tr "\n" "+" | head -c -1 | sed -e s/^/scale=1\;\(/ -e s/$/\)\\/\(1024*1024*1024\)\\n/ | bc | sed "s/$/ GiB/"'
alias pacsizes='LC_ALL=C pacman -Qi | awk "/^Name/{name=\$3} /^Installed Size/{print \$4\$5, name}" | sort -hr'
alias pacrmorphans='sudo pacman -Rns $(pacman -Qdtq)'
alias pacrmcache='du -sh /var/cache/pacman/pkg/ && paccache -d | tail -n -1 && read -p "Continue to remove cached packages?" && sudo paccache -r | tail -n -1'
alias allinstalled='pacman -Qqe'
alias aurinstalled='pacman -Qqem'
alias pacinstalled='comm -23 <(allinstalled) <(aurinstalled)'
alias chaoticinstalled='paclist chaotic-aur'

alias neofetch='neofetch --off --color_blocks off | head -n -2'
alias cpu='echo -e "$(cat /proc/cpuinfo | grep "model name" | uniq | sed "s/.*model name[[:space:]:]*//")\n$(cat /proc/cpuinfo | grep -i "cpu cores" | uniq | sed "s/.*cpu cores[[:space:]:]*"//) Cores, $(cat /proc/cpuinfo | grep siblings | uniq | sed s/.*siblings[[:space:]:]*//) Threads\n$(lscpu | grep "CPU max MHz" | sed "s/.*CPU max MHz[[:space:]:]*//" | cut -f 1 -d ".") MHz"'
alias mainboard='cat /sys/devices/virtual/dmi/id/board_{vendor,name,version}' # ; sudo dmesg | grep DMI: | sed "s/.*DMI[[:space:]:]*//"
alias memory='echo $(perl -E "printf(\"%.1f\", $(cat /proc/meminfo | grep MemTotal | sed s/[^[:digit:]]//g)*1000/1024/1024/1024)") GiB Memory'
alias gpu='cat "/proc/driver/nvidia/gpus/$(ls -1 /proc/driver/nvidia/gpus/ | head -n 1)/information" | grep Model | sed s/.*Model[[:space:]:]*//' # only nvidia support
alias system='echo -e "CPU\n$(cpu | sed "s/^/> /")\n\nMemory\n$(memory | sed "s/^/> /")\n\nGPU\n$(gpu | sed "s/^/> /")\n\nMainboard\n$(mainboard | sed "s/^/> /")"'
alias ipl='ip address | grep "inet 192" | sed "s/^.*inet \(192\.[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+\).*$/\1/"'
alias ipr='echo -e "$(curl -s -4 ifconfig.co)\n$(curl -s -6 ifconfig.co)"'

chr() {
  [ "$1" -lt 256 ] || return 1
  printf "\\$(printf '%03o' "$1")\n"
}

ord() {
  LC_CTYPE=C printf '%d\n' "'$1"
}

source ~/.config/broot/launcher/bash/br
