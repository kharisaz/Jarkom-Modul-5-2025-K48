[Osgiliath]

auto lo
iface lo inet loopback
    up sysctl -w net.ipv4.ip_forward=1

# Ke Internet (NAT1) - DHCP
auto eth0
iface eth0 inet dhcp

# Ke Rivendell (A6)
auto eth1
iface eth1 inet static
    address 192.235.0.13
    netmask 255.255.255.252

# Ke Moria (A1)
auto eth2
iface eth2 inet static
    address 192.235.0.1
    netmask 255.255.255.252

# Ke Minastir (A8)
auto eth3
iface eth3 inet static
    address 192.235.0.17
    netmask 255.255.255.252

# === ROUTING STATIS ===
up ip route add 192.235.0.4/30 via 192.235.0.2
up ip route add 192.235.0.8/30 via 192.235.0.2
up ip route add 192.235.0.64/26 via 192.235.0.2
up ip route add 192.235.0.32/29 via 192.235.0.2

up ip route add 192.235.0.40/29 via 192.235.0.14

up ip route add 192.235.1.0/24 via 192.235.0.18
up ip route add 192.235.0.20/30 via 192.235.0.18
up ip route add 192.235.0.24/30 via 192.235.0.18
up ip route add 192.235.0.28/30 via 192.235.0.18
up ip route add 192.235.0.128/25 via 192.235.0.18


[Moria]

auto lo
iface lo inet loopback
    up sysctl -w net.ipv4.ip_forward=1

auto eth0
iface eth0 inet static
    address 192.235.0.2
    netmask 255.255.255.252
    up ip route add default via 192.235.0.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

auto eth1
iface eth1 inet static
    address 192.235.0.5
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 192.235.0.9
    netmask 255.255.255.252

# Routing ke Wilderland
up ip route add 192.235.0.64/26 via 192.235.0.10
up ip route add 192.235.0.32/29 via 192.235.0.10


[Wilderland]

auto lo
iface lo inet loopback
    up sysctl -w net.ipv4.ip_forward=1

auto eth0
iface eth0 inet static
    address 192.235.0.10
    netmask 255.255.255.252
    up ip route add default via 192.235.0.9
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

auto eth1
iface eth1 inet static
    address 192.235.0.65
    netmask 255.255.255.192

auto eth2
iface eth2 inet static
    address 192.235.0.33
    netmask 255.255.255.248


[Rivendell]

auto lo
iface lo inet loopback
    up sysctl -w net.ipv4.ip_forward=1

auto eth0
iface eth0 inet static
    address 192.235.0.14
    netmask 255.255.255.252
    up ip route add default via 192.235.0.13
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

auto eth1
iface eth1 inet static
    address 192.235.0.41
    netmask 255.255.255.248


[Minastir]

auto lo
iface lo inet loopback
    up sysctl -w net.ipv4.ip_forward=1

auto eth0
iface eth0 inet static
    address 192.235.0.18
    netmask 255.255.255.252
    up ip route add default via 192.235.0.17
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

auto eth1
iface eth1 inet static
    address 192.235.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 192.235.0.21
    netmask 255.255.255.252

# Routing ke Pelargir
up ip route add 192.235.0.24/30 via 192.235.0.22
up ip route add 192.235.0.28/30 via 192.235.0.22
up ip route add 192.235.0.128/25 via 192.235.0.22


[Pelargir]

auto lo
iface lo inet loopback
    up sysctl -w net.ipv4.ip_forward=1

auto eth0
iface eth0 inet static
    address 192.235.0.22
    netmask 255.255.255.252
    up ip route add default via 192.235.0.21

auto eth1
iface eth1 inet static
    address 192.235.0.29
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 192.235.0.25
    netmask 255.255.255.252

up ip route add 192.235.0.128/25 via 192.235.0.30


[AnduinBanks]

auto lo
iface lo inet loopback
    up sysctl -w net.ipv4.ip_forward=1

auto eth0
iface eth0 inet static
    address 192.235.0.30
    netmask 255.255.255.252
    up ip route add default via 192.235.0.29
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

auto eth1
iface eth1 inet static
    address 192.235.0.129
    netmask 255.255.255.128

[Vilya]

auto eth0
iface eth0 inet static
	address 192.235.0.43
	netmask 255.255.255.248
	gateway 192.235.0.41

up echo nameserver 192.168.122.1 > /etc/resolv.conf

[Narya]

auto eth0
iface eth0 inet static
	address 192.235.0.42
	netmask 255.255.255.248
	gateway 192.235.0.41

up echo nameserver 192.168.122.1 > /etc/resolv.conf

[IronHills]

auto eth0
iface eth0 inet static
	address 192.235.0.6
	netmask 255.255.255.252
	gateway 192.235.0.5

up echo nameserver 192.168.122.1 > /etc/resolv.conf

[Palantir]

auto eth0
iface eth0 inet static
	address 192.235.0.26
	netmask 255.255.255.252
	gateway 192.235.0.25
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

[semua client]

auto eth0
iface eth0 inet dhcp
up echo nameserver 192.168.122.1 > /etc/resolv.conf

[Testing dari ironhills ke Palantir]
ping 192.235.0.30 -c 4