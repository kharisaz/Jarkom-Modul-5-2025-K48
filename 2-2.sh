[Vilya]
#ganti berikut

auto eth0
iface eth0 inet static
    address 192.235.0.43
    netmask 255.255.255.248
    gateway 192.235.0.41
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
    up iptables -A INPUT -i eth0 -p icmp --icmp-type echo-request -j REJECT

[Testing]
#client mana saja ping ke vilya
ping 192.235.0.43 -c 3

#vilya ping ke client
ping 192.235.0.66 -c 3
ping 8.8.8.8 -c 3