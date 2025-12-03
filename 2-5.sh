[Palantir]

#config
auto eth0
iface eth0 inet static
	address 192.235.0.26
	netmask 255.255.255.252
	gateway 192.235.0.25
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

    # 1. Aturan Faksi ELF (Subnet A13: 192.235.0.128/25)
    # Izinkan HANYA jam 07.00 - 15.00
    up iptables -A INPUT -p tcp --dport 80 -s 192.235.0.128/25 -m time --timestart 07:00 --timestop 15:00 -j ACCEPT

    # 2. Aturan Faksi MANUSIA (Subnet A9: 192.235.1.0/24)
    # Izinkan HANYA jam 17.00 - 23.00
    up iptables -A INPUT -p tcp --dport 80 -s 192.235.1.0/24 -m time --timestart 17:00 --timestop 23:00 -j ACCEPT

    # 3. Aturan Sisa: BLOKIR SEMUA akses Web selain yang diizinkan di atas
    # (Jika Elf akses jam 16.00, dia tidak kena aturan 1, maka jatuh ke sini -> REJECT)
    up iptables -A INPUT -p tcp --dport 80 -j REJECT


[Testing]
#pastikan nginx palantir dan web server aktif ()
#case 1 (palantir)
date -s "10:00:00"

#Tes dari Gilgalad (Elf) dan Elendil (Manusia)
curl palantir.aliansi.rpl


#case 2 (palantir)
date -s "20:00:00"

#do the same broww