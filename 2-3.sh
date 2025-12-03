[Narya]
auto eth0
iface eth0 inet static
    address 192.235.0.42
    netmask 255.255.255.248
    gateway 192.235.0.41
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

    # === SECURITY RULES (MISI 2) ===
    # 1. Izinkan akses DNS (UDP dan TCP) HANYA dari Vilya (192.235.0.43)
    up iptables -A INPUT -i eth0 -p udp --dport 53 -s 192.235.0.43 -j ACCEPT
    up iptables -A INPUT -i eth0 -p tcp --dport 53 -s 192.235.0.43 -j ACCEPT
    
    # 2. Tolak (REJECT) SEMUA akses DNS (Port 53) dari IP LAIN
    up iptables -A INPUT -i eth0 -p udp --dport 53 -j REJECT
    up iptables -A INPUT -i eth0 -p tcp --dport 53 -j REJECT
    
    # 3. Tetap Izinkan Akses Balik (misalnya balasan ping atau balasan query)
    up iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    
    # 4. Tolak Sisanya (Opsional, tapi bagus untuk keamanan)
    up iptables -P INPUT REJECT


service named start

[Testing]
# tes di vilya(bisa diakses)
apt-get update && apt-get install netcat-openbsd -y
nc -zvu 192.235.0.42 53

# penguji ex durin (akses diblokir)
apt-get install netcat-openbsd -y
nc -zv -w 3 192.235.0.42 53

# janlup hapus aturan setelah tes