# fail2ban
# https://wiki.archlinux.org/title/Fail2ban
read -p "fail2ban. Proceed?"
sudo pacman -S fail2ban
read -p "Setup files from config?"
sudo mkdir -p /var/log/fail2ban/
read -p "Set in /etc/ssh/sshd_config : LogLevel VERBOSE"
read -p "Continue and enable/start services?"
sudo systemctl enable fail2ban.service
sudo systemctl start fail2ban.service
sudo fail2ban-client status sshd