### The .py extension is only used for some highlighting in my text editor
###
### Nothing = Default repositories and Chaotic AUR repository
### @ = AUR package
### % = cargo install
### ? = --asdeps
### < = user confirmation before installation
### > = print to console after installation

> Microcode needs to be installed manually: intel-ucode or amd-ucode

# Pacman
pacman-contrib # paccache, paclist, ...
rebuild-detector
arch-rebuild-order
reflector

# Network
networkmanager
iptables
fail2ban
whois

# Audio
pipewire
?pipewire-alsa
?pipewire-pulse
?pipewire-jack
?gst-plugin-pipewire

# Build system
pkgconf
autoconf
automake
make
cmake
gcc
m4
patch
fakeroot
meson
ninja

# File systems
btrfs-progs # Btrfs
e2fsprogs # ext3 / ext4
ntfs-3g # NTFS
dosfstools # FAT
exfatprogs # exFAT
mtpfs # MTP devices
hfsprogs # for macOS

# Archives and compression
arj
unarj
unace
unrar
unarchiver
zip
unzip
bzip2
tar
xz
gzip
cpio
lrzip
lzop
p7zip
p7zip-gui # GUI application
ark # GUI application

# Git
git
git-delta
@git-interactive-rebase-tool-git
gitui

# Fonts
adobe-source-code-pro-fonts
adobe-source-han-sans-otc-fonts
noto-fonts
noto-fonts-emoji
noto-fonts-cjk
ttf-dejavu
ttf-liberation
ttf-hack

# Graphics driver etc.
< Is your graphics card from Nvidia? Cancel, if not.
nvidia
opencl-nvidia
cuda

# Printer
cups
cups-pdf

# Other CLI tools
bash-completion
findutils
grep
sed
gawk
perl
nmap
wget
wget2
which
bc
nano
neovim
dos2unix
openssh
stress
xclip
imagemagick # convert (for images)
perl-archive-zip # CRC32
moreutils # errno
bind # dig (dns lookup)
dog # Rust alternative: dig (dns lookup)
dust # Rust alternative: du (disk usage)
bottom # nice cli system monitoring in Rust
bandwhich # nice cli bandwith usage in Rust
xh # Rust alternative: curl
fd # Rust alternative: find
ripgrep # Rust alternative: grep
sd # Rust alternative: sed
bat # Rust alternative: cat
exa # Rust alternative: ls
miniserve # Serve files via HTTP
hyperfine # Benchmark commands
tokei # Lines of code
hexyl # Hex viewer
tealdeer # Tldr client
broot # Fuzzy search + tree + cd
pueue # Command scheduler
megatools # CLI for MEGA
speedtest-cli # Internet speedtest
neofetch # System information tool
%git-user # Switch git users
%xcol # Rust alternative: column
%hexv # Alternative hex viewer

# Console
alacritty
konsole

# Java
> Run archlinux-java
jdk-openjdk
jdk7-openjdk
jdk8-openjdk
jdk11-openjdk
openjdk-doc
openjdk-src
openjdk7-doc
openjdk7-src
openjdk8-doc
openjdk8-src
openjdk11-doc
openjdk11-src
java-openjfx
java-openjfx-doc
java-openjfx-src
java8-openjfx
java8-openjfx-doc
java8-openjfx-src
java11-openjfx
java11-openjfx-doc
java11-openjfx-src

# Java decompiler
@jd-gui-bin
@luyten

# Kotlin
kotlin
@ki-shell-bin

# Android
android-studio
android-emulator
android-platform
android-sdk
android-sdk-platform-tools
android-udev
@android-sdk-build-tools
@android-apktool
@android-x86-64-system-image

# Python
python
python-pip
python-setuptools
python-sphinx
pypy3

# Rust
rustup
sccache
clang # necessary as linker for mold
@mold
cargo-audit
cargo-udeps
cargo-outdated
@wasm-pack
@cargo-profiler
@cargo-license
@cargo-pkgbuild
@cargo-clone
@cargo-nono

# Language Server Protocol
rust-analyzer
bash-language-server
python-language-server
lua-language-server
texlab
@java-language-server
@typescript-language-server-bin
@nodejs-svelte-language-server
@dockerfile-language-server
@sql-language-server

# Browsers
librewolf
librewolf-ublock-origin
librewolf-extension-localcdn
ungoogled-chromium
firefox-developer-edition
firefox-developer-edition-i18n-de

# Tor
tor
torbrowser-launcher

# E-mail
thunderbird
thunderbird-i18n-de

# Video players
mpv
vlc

# Video tools
@ffmpeg-full
obs-studio
davinci-resolve
kdenlive
mediainfo
mediainfo-gui
makemkv
mkvtoolnix-cli
mkvtoolnix-gui
@mkv-extractor-qt
@?mkclean
@?mkvalidator

# Downloader
jdownloader2
@?phantomjs-bin
youtube-dl
youtube-dlp
you-get
streamlink
@annie

# IDEs
> You may need to export CLION_JDK=/usr/lib/jvm/java-11-openjdk in /etc/profile or /etc/environment
intellij-idea-ultimate-edition
intellij-idea-ultimate-edition-jre
pycharm-professional
clion
vscodium
kdevelop

# File transfer
filezilla # FTP
deluge-gtk # Torrent

# File sharing
@ffsend-bin
@imgur.sh

# Audio
audacious
audacity
easytag
kid3
mp3wrap
@mp3val

# Communication
> You may need to override the .desktop file for Discord
discord_arch_electron
signal-desktop
element-desktop
teamspeak3

# Image viewer/editors
gwenview
gimp
krita
inkscape
@xnconvert

# Image compression
optipng # Lossless PNG
guetzli # Lossy JPEG

# Text editors with GUI
kate
libreoffice-still
libreoffice-still-de
ghostwriter # Markdown editor

# Text diffs with GUI
kdiff3
kompare

# File managers and tools
dolphin
krusader
kfind
krename
filelight # View disk usage information
deja-dup # Backup tool

# Boot sticks and imagers
ventoy-bin
balena-etcher
@rpi-imager

# LaTeX
texlive-most
texworks
kile

# OCR + Tesseract
gimagereader-qt
tesseract-data-deu
tesseract-data-eng
tesseract-data-spa
tesseract-data-jpn

# Maths
geogebra
kcalc

# Screen sharing
anydesk-bin
teamviewer
zoom
rustdesk

# Aegisub
< Install Aegisub? Cancel, if not.
@aegisub-ttools-meson-git
@aegisub-dependency-control
@aegisub-subinspector-git
@aegisub-yutils

# Other GUI applications
> You may want to create a shortcut for flameshot
okular # PDF viewer
flameshot # Screenshot
k3b # Burn disks
keepassxc # Password manager
kcolorchooser # Choose color from desktop
fontforge # Font editor
acetoneiso2 # ISO manager
kdiskmark # HDD/SSD benchmarking
google-earth-pro # Google Earth
qemu # Emulator and virtualizer
wireshark-qt # See network traffic
partitionmanager # KDE partition manager
@nbteditor-bin # NBT editor for Minecraft

# Games
< Install games?
wine
proton-ge-custom-bin
steam
minecraft-launcher

> Autostart: Discord, Thunderbird