# Guide 1: https://wiki.archlinux.org/title/Installation_guide
# Guide 2: https://wiki.archlinux.de/title/Anleitung_für_Einsteiger

# Update pacman.conf
# - Add ParallelDownloads = 5
sudo sed -i "/VerbosePkgLists/a ParallelDownloads = 5" /etc/pacman.conf

# Pacman update packages
sudo pacman -Syu

# Pacman fastest mirrors
sudo pacman -S reflector
sudo reflector --verbose --sort rate -c Germany -p https --ipv4 --ipv6 -f 10 --save /etc/pacman.d/mirrorlist

# Update pacman.conf
# - Enable multilib repo
# - Add chaotic repo
sudo sed -i "s/#\(\[multilib\]\)/\\1\nInclude = \/etc\/pacman.d\/mirrorlist/"
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-'{keyring,mirrorlist}'.pkg.tar.zst'
echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf > /dev/null

# Pacman update packages
sudo pacman -Syu

# Install paru
cd ~
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rmdir paru