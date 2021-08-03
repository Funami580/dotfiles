# - https://wiki.archlinux.org/title/Simple_stateful_firewall
# - https://wiki.archlinux.org/title/iptables

delete_table() {
    sudo iptables -t $1 -F
    sudo iptables -t $1 -X
    sudo iptables -t $1 -Z
    
    sudo ip6tables -t $1 -F
    sudo ip6tables -t $1 -X
    sudo ip6tables -t $1 -Z
}

open_port_tcp_only() {
    sudo iptables -A TCP -p tcp --dport  $1 -j ACCEPT
    sudo ip6tables -A TCP -p tcp --dport  $1 -j ACCEPT
}

open_port_udp_only() {
    sudo iptables -A UDP -p udp --dport  $1 -j ACCEPT
    sudo ip6tables -A UDP -p udp --dport  $1 -j ACCEPT
}

open_port() {
    if [ "$2" == "tcp" ]; then
        open_port_tcp_only $1
    elif [ "$2" == "udp" ]; then
        open_port_udp_only $1
    else
        open_port_tcp_only $1
        open_port_udp_only $1
    fi
}

open_local_port_tcp_only() {
    # https://www.inetdaemon.com/tutorials/internet/ip/addresses/special.shtml
    sudo iptables -A TCP -p tcp --dport $1 -s 0.0.0.0/8 -j ACCEPT
    sudo iptables -A TCP -p tcp --dport $1 -s 127.0.0.0/8 -j ACCEPT
    sudo iptables -A TCP -p tcp --dport $1 -s 10.0.0.0/8 -j ACCEPT
    sudo iptables -A TCP -p tcp --dport $1 -s 172.16.0.0/12 -j ACCEPT
    sudo iptables -A TCP -p tcp --dport $1 -s 192.168.0.0/16 -j ACCEPT
    sudo iptables -A TCP -p tcp --dport $1 -j DROP
    
    sudo ip6tables -A TCP -p tcp --dport $1 -s ::/128 -j ACCEPT
    sudo ip6tables -A TCP -p tcp --dport $1 -s ::1/128 -j ACCEPT
    sudo ip6tables -A TCP -p tcp --dport $1 -s fd00::/8 -j ACCEPT
    sudo ip6tables -A TCP -p tcp --dport $1 -j DROP
}

open_local_port_udp_only() {
    # https://www.inetdaemon.com/tutorials/internet/ip/addresses/special.shtml
    sudo iptables -A UDP -p udp --dport $1 -s 0.0.0.0/8 -j ACCEPT
    sudo iptables -A UDP -p udp --dport $1 -s 127.0.0.0/8 -j ACCEPT
    sudo iptables -A UDP -p udp --dport $1 -s 10.0.0.0/8 -j ACCEPT
    sudo iptables -A UDP -p udp --dport $1 -s 172.16.0.0/12 -j ACCEPT
    sudo iptables -A UDP -p udp --dport $1 -s 192.168.0.0/16 -j ACCEPT
    sudo iptables -A UDP -p udp --dport $1 -j DROP
    
    sudo ip6tables -A UDP -p udp --dport $1 -s ::/128 -j ACCEPT
    sudo ip6tables -A UDP -p udp --dport $1 -s ::1/128 -j ACCEPT
    sudo ip6tables -A UDP -p udp --dport $1 -s fd00::/8 -j ACCEPT
    sudo ip6tables -A UDP -p udp --dport $1 -j DROP
}

open_local_port() {
    if [ "$2" == "tcp" ]; then
        open_local_port_tcp_only $1
    elif [ "$2" == "udp" ]; then
        open_local_port_udp_only $1
    else
        open_local_port_tcp_only $1
        open_local_port_udp_only $1
    fi
}

# Remove existing rules
sudo iptables -F
sudo iptables -X
sudo ip6tables -F
sudo ip6tables -X

delete_table filter
delete_table nat
delete_table mangle
delete_table raw
delete_table security

sudo modprobe -r iptable_nat
sudo modprobe -r iptable_mangle
sudo modprobe -r iptable_raw
sudo modprobe -r iptable_security

sudo modprobe -r ip6table_nat
sudo modprobe -r ip6table_mangle
sudo modprobe -r ip6table_raw
sudo modprobe -r ip6table_security

# Create new chains
sudo iptables -N TCP
sudo iptables -N UDP

sudo ip6tables -N TCP
sudo ip6tables -N UDP

# Default behaviour: only allow outgoing packets
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD DROP

sudo ip6tables -P INPUT DROP
sudo ip6tables -P OUTPUT ACCEPT
sudo ip6tables -P FORWARD DROP

# Allow loopback traffic
sudo iptables -A INPUT -i lo -j ACCEPT
sudo ip6tables -A INPUT -i lo -j ACCEPT

# Allow incoming packets from established connections
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo ip6tables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Drop invalid packets
sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo ip6tables -A INPUT -m conntrack --ctstate INVALID -j DROP

# Allow icmp packets
sudo iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
sudo ip6tables -A INPUT -p ipv6-icmp --icmpv6-type 128 -m conntrack --ctstate NEW -j ACCEPT
sudo ip6tables -A INPUT -s fe80::/10 -p ipv6-icmp -j ACCEPT

# Allow incoming DHCPv6 packets
sudo ip6tables -A INPUT -p udp --sport 547 --dport 546 -j ACCEPT

# Check for ports in TCP/UDP chain
sudo iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
sudo iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP

sudo ip6tables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
sudo ip6tables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP

# Requests to non-open ports
sudo iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
sudo iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
sudo iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable

sudo ip6tables -A INPUT -p udp -j REJECT
sudo ip6tables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
sudo ip6tables -A INPUT -j REJECT

# SSH: tcp/22
open_port 22 tcp

# CUPS/IPP: tcp/631
open_port 631 tcp

# HTTP: tcp/udp/80
open_port 80

# HTTPS: tcp/udp/443
open_local_port 443

# HTTP alternative port only for local network: tcp/udp/8080
open_local_port 8080

# Minecraft: tcp/udp/25565
open_port 25565

# Save
sudo iptables-save -f /etc/iptables/iptables.rules
sudo ip6tables-save -f /etc/iptables/ip6tables.rules

# Continue?
echo iptables.rules
cat /etc/iptables/iptables.rules
echo
echo
echo ip6tables.rules
cat /etc/iptables/ip6tables.rules
read -p "Continue and enable/start services?"

# Enable services
sudo systemctl enable iptables.service
sudo systemctl enable ip6tables.service

# Start services
sudo systemctl start iptables.service
sudo systemctl start ip6tables.service