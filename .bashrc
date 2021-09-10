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
alias hexv='hexv -f Hack,Twemoji'

alias gu='git-user'
alias gua='git-user add'
alias guc='git-user current'

alias mimetype='file -b --mime-type'
alias mimetypec='file -bi' # mimetype with charset
alias fpermso='stat -c %a' # file permissions octal
alias fpermsh='stat -c %A' # file permissions human
alias fchown='stat -c %U:%G' # user:group information

no_home() {
    args="$@"
    unshare -cm --keep-caps bash -c "mount -t tmpfs none /tmp; cp .Xauthority /tmp; mount -t tmpfs none /home/; mount -t tmpfs none /run/media/; cd /home; mkdir -p $USER; cd /home/$USER; mv /tmp/.Xauthority .Xauthority; $args"
}

alias no-net='unshare -cn --keep-caps'
alias no-home='no_home'
alias mp3wrap2='find . -maxdepth 1 -iname "*.mp3" -print0 | sort -z | xargs -0 mp3wrap output.mp3 && mp3val -f output_MP3WRAP.mp3 && rm output_MP3WRAP.mp3.bak'
alias mpe-key='python -c "$(echo ZnJvbSBoYXNobGliIGltcG9ydCBzaGExCmltcG9ydCByYW5kb20sIHN0cmluZwoKCmRlZiBnZW5lcmF0ZV9yYW5kb21fYWxwaGFudW1fc3RyKGxlbmd0aDogaW50KSAtPiBzdHI6CiAgICBzID0gIiIKICAgIGZvciBfIGluIHJhbmdlKGxlbmd0aCk6CiAgICAgICAgcyArPSByYW5kb20uU3lzdGVtUmFuZG9tKCkuY2hvaWNlKHN0cmluZy5hc2NpaV91cHBlcmNhc2UgKwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJpbmcuZGlnaXRzKQogICAgcmV0dXJuIHMKCgpkZWYgZG91YmxlX2hhc2goY29kZTogc3RyKSAtPiBzdHI6CiAgICBoYXNoID0gc2hhMShjb2RlLmVuY29kZSgiVVRGLTgiKSkuaGV4ZGlnZXN0KCkKICAgIGhhc2ggPSBzaGExKGhhc2guZW5jb2RlKCJVVEYtOCIpKS5oZXhkaWdlc3QoKQogICAgcmV0dXJuIGhhc2gKCgpkZWYga2V5Z2VuKHJlZ2lzdHJhdGlvbl9jb2RlOiBzdHIsIGNvbXB1dGVyX2lkOiBzdHIpIC0+IHN0cjoKICAgIHJlZ2lzdHJhdGlvbl9oYXNoID0gZG91YmxlX2hhc2gocmVnaXN0cmF0aW9uX2NvZGUpCiAgICBjb21wdXRlcl9oYXNoID0gZG91YmxlX2hhc2goY29tcHV0ZXJfaWRbOi00XSkKICAgIGNvbWJpbmVkX2hhc2ggPSAiIgogICAgZm9yIGkgaW4gcmFuZ2UobGVuKHJlZ2lzdHJhdGlvbl9oYXNoKSk6CiAgICAgICAgY29tYmluZWRfaGFzaCArPSByZWdpc3RyYXRpb25faGFzaFtpXSArIGNvbXB1dGVyX2hhc2hbaV0KICAgIGNvbWJpbmVkX2hhc2ggPSBzaGExKGNvbWJpbmVkX2hhc2guZW5jb2RlKCJVVEYtOCIpKS5oZXhkaWdlc3QoKQogICAgcmV0dXJuIGNvbWJpbmVkX2hhc2gudXBwZXIoKSArIGdlbmVyYXRlX3JhbmRvbV9hbHBoYW51bV9zdHIoMTApCgoKZGVmIG1haW4oKToKICAgIHMgPSAiTWFzdGVyIFBERiBFZGl0b3IgNS54IEtleWdlbiBbYnkgbjBrMG0zLCBvcmlnaW5hbGx5IGJ5IFJhZGlYWDExXSIKICAgIHByaW50KHMpCiAgICBwcmludCgiPSIgKiBsZW4ocykpCiAgICBwcmludCgpCiAgICBmb3JtYXRfc3R5bGUgPSAiezo8MjB9OiAiCiAgICBjb21wdXRlcl9pZCA9IGlucHV0KGZvcm1hdF9zdHlsZS5mb3JtYXQoIkNvbXB1dGVyIElEIikpCiAgICBpZiBsZW4oY29tcHV0ZXJfaWQpICE9IDQwOgogICAgICAgIHByaW50KAogICAgICAgICAgICAiW0VSUk9SXSBDb21wdXRlciBJRCBtdXN0IGJlIGEgNDAgY2hhcmFjdGVyIHN0cmluZywgaW5jbHVkaW5nIFwiLVwiIgogICAgICAgICkKICAgICAgICByZXR1cm4KICAgIHJlZ2lzdHJhdGlvbl9jb2RlID0gZ2VuZXJhdGVfcmFuZG9tX2FscGhhbnVtX3N0cigxOCkKICAgICMgcmVnaXN0cmF0aW9uX2NvZGUgPSAiVlZNWDVQSEZGUzZUNk1BTTc2IgogICAgYWN0aXZhdGlvbl9jb2RlID0ga2V5Z2VuKHJlZ2lzdHJhdGlvbl9jb2RlLCBjb21wdXRlcl9pZCkKICAgIHByaW50KGZvcm1hdF9zdHlsZS5mb3JtYXQoIlJlZ2lzdHJhdGlvbiBDb2RlIikgKyByZWdpc3RyYXRpb25fY29kZSkKICAgIHByaW50KGZvcm1hdF9zdHlsZS5mb3JtYXQoIkFjdGl2YXRpb24gQ29kZSIpICsgYWN0aXZhdGlvbl9jb2RlKQogICAgcHJpbnQoKQoKCmlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICBtYWluKCkK | base64 -d)"'

# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages
alias pacsize='LC_ALL=C pacman -Qi | awk "/^Installed Size/{print \$4\$5}" | sed -e s/KiB/*1024/ -e s/MiB/*$((1024*1024))/ -e s/GiB/*$((1024*1024*1024))/ | tr "\n" "+" | head -c -1 | sed -e s/^/scale=1\;\(/ -e s/$/\)\\/\(1024*1024*1024\)\\n/ | bc | sed "s/$/ GiB/"'
alias pacsizes='LC_ALL=C pacman -Qi | awk "/^Name/{name=\$3} /^Installed Size/{print \$4\$5, name}" | sort -hr'
alias pacrmorphans='sudo pacman -Rns $(pacman -Qdtq)'
alias pacrmcache='du -sh /var/cache/pacman/pkg/ && paccache -d | tail -n -1 && read -p "Continue to remove cached packages?" && sudo paccache -r | tail -n -1'
alias allinstalled='pacman -Qqe'
alias aurinstalled='pacman -Qqem'
alias pacinstalled='comm -23 <(allinstalled) <(aurinstalled)'
alias chaoticinstalled='paclist chaotic-aur'
alias checkrebuildc='checkrebuild -i chaotic-aur'
alias rmsyspkgs='grep -P ^\(\?\!xorg\|plasma\)'
alias srcinfo='makepkg --printsrcinfo > .SRCINFO'
alias checkaurupd='python3 ~/Programme/AUR_packages/check_crates_updates.py'

#alias neofetch='neofetch --off --color_blocks off | head -n -2'
alias cpu='echo -e "$(cat /proc/cpuinfo | grep "model name" | uniq | sed "s/.*model name[[:space:]:]*//")\n$(cat /proc/cpuinfo | grep -i "cpu cores" | uniq | sed "s/.*cpu cores[[:space:]:]*"//) Cores, $(cat /proc/cpuinfo | grep siblings | uniq | sed s/.*siblings[[:space:]:]*//) Threads\n$(lscpu | awk "/CPU max MHz/ {print \$4}" | cut -f 1 -d ".") MHz"'
alias mainboard='cat /sys/devices/virtual/dmi/id/board_{vendor,name,version}' # ; sudo dmesg | grep DMI: | sed "s/.*DMI[[:space:]:]*//"
alias memory='echo $(perl -E "printf(\"%.1f\", $(cat /proc/meminfo | grep MemTotal | sed s/[^[:digit:]]//g)*1000/1024/1024/1024)") GiB Memory'
alias gpu='cat "/proc/driver/nvidia/gpus/$(ls -1 /proc/driver/nvidia/gpus/ | head -n 1)/information" | grep Model | sed s/.*Model[[:space:]:]*//' # only nvidia support
alias system='echo -e "CPU\n$(cpu | sed "s/^/> /")\n\nMemory\n$(memory | sed "s/^/> /")\n\nGPU\n$(gpu | sed "s/^/> /")\n\nMainboard\n$(mainboard | sed "s/^/> /")"'
alias ipl='ip a | awk "/inet 192/ {print \$2}" | cut -d "/" -f 1'
alias ipr='echo -e "$(curl -s -4 ifconfig.co)\n$(curl -s -6 ifconfig.co)"'

# Upload file to 0x0.st and copy url to clipboard
0x0() {
    url=$(curl -s -F "file=@$1" "https://0x0.st" | tr -d "\n")
    echo -n "$url" | xclip -selection clipboard -i
    echo "$url"
}

chr() {
  [ "$1" -lt 256 ] || return 1
  printf "\\$(printf '%03o' "$1")\n"
}

ord() {
  LC_CTYPE=C printf '%d\n' "'$1"
}

source ~/.config/broot/launcher/bash/br
