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
@coredns-bin

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
clang
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
lhasa
p7zip
p7zip-gui # GUI application
ark # GUI application

# Git
git
git-delta
@git-interactive-rebase-tool-bin
gitui

# Fonts
adobe-source-code-pro-fonts
adobe-source-han-sans-otc-fonts
noto-fonts
noto-fonts-cjk
ttf-bitstream-vera
ttf-twemoji
ttf-liberation
ttf-hack
> You need to execute a command similar to: sudo cp /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/

# Graphics driver etc.
< Is your graphics card from Nvidia? Cancel, if not. If yes, enable Full Composition Pipeline.
nvidia
?nvidia-settings
?opencl-nvidia
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
jq
nmap
wget
?ca-certificates
wget2
?ca-certificates
which
bc
nano
neovim
dos2unix
openssh
stress
xclip
imagemagick # convert (for images)
?djvulibre
?ghostscript
?imagemagick-doc
?libheif
?libraw
?librsvg
?libwebp
?libwmf
?libxml2
?ocl-icd
?openexr
?openjpeg2
?pango
traceroute
perl-archive-zip # CRC32
moreutils # errno
bind # dig (dns lookup)
dog # Rust alternative: dig (dns lookup)
dust # Rust alternative: du (disk usage)
diskus # Another disk usage tool, more simplistic
bottom # nice cli system monitoring in Rust
bandwhich # nice cli bandwith usage in Rust
xh # Rust alternative: curl
fd # Rust alternative: find
ripgrep # Rust alternative: grep
sd # Rust alternative: sed
bat # Rust alternative: cat
bat-extras # Extra functionality, e.g. batgrep
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
fastfetch-git # System information tool
mcfly # Bash better history
pax-utils # lddtree
@htmlq-bin # jq for html
@py-spy-bin # Python profiler
@pastel-bin # Color helper
@dnspeep-bin # Show dns requests
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
@mold
cargo-audit
cargo-udeps
cargo-outdated
cargo-flamegraph
@wasm-pack-bin
@cargo-license
@cargo-clone
@cargo-nono-bin

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
opera

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
?libfdk-aac
davinci-resolve
kdenlive
mediainfo
mediainfo-gui
makemkv
?lib32-glibc
mkvtoolnix-cli
mkvtoolnix-gui
@mkv-extractor-qt
@?mkclean
@?mkvalidator
kamoso # Webcam

# Downloader
jdownloader2
@?phantomjs-bin
yt-dlp
youtube-dl
?python-pycryptodome
?rtmpdump
youtube-dlp
?rtmpdump
you-get
?python-pysocks
streamlink
@annie-bin

# IDEs
> You may need to export CLION_JDK=/usr/lib/jvm/java-11-openjdk in /etc/profile or /etc/environment
intellij-idea-ultimate-edition
?intellij-idea-ultimate-edition-jre
pycharm-professional
?cython
?python-pytest
clion
?clion-jre
?clion-gdb
?clion-cmake
?clion-lldb
?gcc
?clang
vscodium
kdevelop

# File transfer
filezilla # FTP
deluge-gtk # Torrent

# File sharing
@ffsend-bin

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
?xdg-utils
signal-desktop
telegram-desktop
element-desktop
teamspeak3

# Image viewer/editors
gwenview
?kimageformats
?qt5-imageformats
gimp
?poppler-glib
krita
inkscape
?scour
@xnconvert

# Image compression
optipng # Lossless PNG
guetzli # Lossy JPEG
libwebp # WebP

# Text editors with GUI
kate
libreoffice-still
libreoffice-still-de
?coin-or-mp
?gst-plugins-base-libs
?gtk3
ghostwriter # Markdown editor
?mathjax
?pandoc

# Text diffs with GUI
kdiff3
kompare

# File managers and tools
dolphin
@rootactions-servicemenu
@kde-servicemenus-pdf
@kde-service-menu-reimage
?jhead
kfind
krename
filelight # View disk usage information
deja-dup # Backup tool

# Boot sticks and imagers
ventoy-bin
balena-etcher
@rpi-imager-bin
?udisks2
?dosfstools

# LaTeX
texlive-most
texworks
?gsfonts
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
?unrar
?ebook-tools
flameshot # Screenshot
k3b # Burn disks
?cdparanoia
?cdrdao
?cdrtools
?dvd+rw-tools
?emovix
?transcode
?vcdimager
keepassxc # Password manager
kcolorchooser # Choose color from desktop
fontforge # Font editor
acetoneiso2 # ISO manager
?p7zip
kdiskmark # HDD/SSD benchmarking
google-earth-pro # Google Earth
virtualbox # Virtualizer
qemu # Emulator and virtualizer
wireshark-qt # See network traffic
partitionmanager # KDE partition manager
@mullvad-vpn-bin
@nbteditor-bin # NBT editor for Minecraft

# Games
< Install games?
wine
wine-mono
winetricks
proton-ge-custom-bin
@?xboxdrv
steam
minecraft-launcher
minetest

> Autostart: Discord, Thunderbird, Mullvad, Signal, Telegram