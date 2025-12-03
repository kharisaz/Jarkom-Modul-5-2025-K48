[IronHills]
auto lo
iface lo inet loopback
    up sysctl -w net.ipv4.ip_forward=1

auto eth0
iface eth0 inet static
    address 192.235.0.6
    netmask 255.255.255.252
    gateway 192.235.0.5
    # DNS untuk kebutuhan install paket
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

    up iptables -F

    # Jika koneksi > 3, langsung tolak. Jangan buang waktu cek hari/teman.
    up iptables -A INPUT -p tcp --syn --dport 80 -m connlimit --connlimit-above 3 -j REJECT

    # Tolak akses Senin-Jumat
    up iptables -A INPUT -p tcp --dport 80 -m time --weekdays Mon,Tue,Wed,Thu,Fri -j REJECT

    # Izinkan Teman (Kurcaci & Manusia)
    up iptables -A INPUT -p tcp --dport 80 -s 192.235.0.64/26 -j ACCEPT
    up iptables -A INPUT -p tcp --dport 80 -s 192.235.0.32/29 -j ACCEPT
    up iptables -A INPUT -p tcp --dport 80 -s 192.235.1.0/24 -j ACCEPT

    # 4. ATURAN SISA (Blokir Orang Asing / Elf di Hari Libur)
    up iptables -A INPUT -p tcp --dport 80 -j REJECT


#cmd
# Set waktu ke HARI SABTU
date -s "2025-10-04 10:00:00"


[Elendil]
apt-get update && apt-get install apache2-utils -y
ab -n 100 -c 10 http://ironhills.aliansi.rpl/

#ubah hari di ironhills (wed), lalu ulangi tes elendil
date -s "2025-10-01 10:00:00"