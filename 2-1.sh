[Osgiliath]

# Ganti Internet (NAT1) - DHCP

auto eth0
iface eth0 inet dhcp
    post-up sleep 5 && IP=$(ip -4 addr show eth0 | grep inet | awk '{print $2}' | cut -d/ -f1) && iptables -t nat -A POSTROUTING -s 192.235.0.0/23 -o eth0 -j SNAT --to-source $IP


[Testing]
apt-get update && apt-get install iptables -y
