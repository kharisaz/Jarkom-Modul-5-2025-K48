[Vilya]
apt-get update && apt-get install isc-dhcp-server -y

nano /etc/default/isc-dhcp-server
#isi
INTERFACESv4="eth0"

nano /etc/dhcp/dhcpd.conf
#isi
# Konfigurasi Global
default-lease-time 600;
max-lease-time 7200;
option domain-name-servers 192.235.0.42; # IP Narya (DNS)
option domain-name "aliansi.rpl";

# 1. SUBNET A7 (Jaringan Vilya Sendiri - WAJIB ADA supaya service jalan)
subnet 192.235.0.40 netmask 255.255.255.248 {
}

# 2. SUBNET A5 (Khamul - 5 Host)
subnet 192.235.0.32 netmask 255.255.255.248 {
    range 192.235.0.34 192.235.0.38;
    option routers 192.235.0.33; # IP Wilderland (Gateway A5)
}

# 3. SUBNET A4 (Durin - 50 Host)
subnet 192.235.0.64 netmask 255.255.255.192 {
    range 192.235.0.66 192.235.0.126;
    option routers 192.235.0.65; # IP Wilderland (Gateway A4)
}

# 4. SUBNET A9 (Elendil & Isildur - 200 & 30 Host)
subnet 192.235.1.0 netmask 255.255.255.0 {
    range 192.235.1.2 192.235.1.254;
    option routers 192.235.1.1; # IP Minastir (Gateway A9)
}

# 5. SUBNET A13 (Gilgalad & Cirdan - 100 & 20 Host)
subnet 192.235.0.128 netmask 255.255.255.128 {
    range 192.235.0.130 192.235.0.254;
    option routers 192.235.0.129; # IP AnduinBanks (Gateway A13)
}


service isc-dhcp-server restart


[Minastir, AnduinBanks, Rivendell, dan Wilderland]

apt-get update && apt-get install isc-dhcp-relay -y

nano /etc/default/isc-dhcp-relay
#ubah bagian berikut

# Target DHCP Server (IP Vilya)
SERVERS="192.235.0.43"

# Interface yang melayani DHCP (Bisa diisi spesifik atau kosongkan agar semua interface)
INTERFACES=""


service isc-dhcp-relay restart


[Narya]

apt-get update && apt-get install bind9 -y

# 1. Config Zone
nano /etc/bind/named.conf.local
# Isi:
zone "aliansi.rpl" {
    type master;
    file "/etc/bind/db.aliansi";
};

# 2. BUAT DATABASE DARI NOL (JANGAN COPY)
nano /etc/bind/db.aliansi

# Paste isinya manual ke dalam file kosong tersebut:
;
; BIND data file for aliansi.rpl
;
$TTL    604800
@       IN      SOA     aliansi.rpl. root.aliansi.rpl. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      aliansi.rpl.
@       IN      A       192.235.0.42
palantir IN     A       192.235.0.26
ironhills IN    A       192.235.0.6

# 3. Config Forwarder
nano /etc/bind/named.conf.options

# Isi (Pastikan syntax kurung kurawal benar):
options {
    directory "/var/cache/bind";
    
    forwarders {
        8.8.8.8;
    };
    
    allow-query { any; };
    dnssec-validation no;
};

service named start


[Palantir]

#Setting IP Static: 192.235.0.26/30, Gateway 192.235.0.25
apt-get update && apt-get install nginx -y
echo "Welcome to Palantir" > /var/www/html/index.html
service nginx start

[IronHills]

#Setting IP Static: 192.235.0.6/30, Gateway 192.235.0.5
apt-get update && apt-get install nginx -y
echo "Welcome to IronHills" > /var/www/html/index.html
service nginx start



===[pengujian]=== (ex Durin / Elendil)

apt-get update && apt-get install isc-dhcp-client -y
dhclient -v eth0
ip a
#IP durin harus antara 192.235.0.66 s.d 192.235.0.126
#IP Elendil harus antara 192.235.1.2 s.d 192.235.1.254

cat /etc/resolv.conf
# Harus ada: nameserver 192.235.0.42

# Tes DNS Resolve
nslookup palantir.aliansi.rpl
# Output harus: Address 192.235.0.26
nslookup ironhills.aliansi.rpl
# Output harus: Address 192.235.0.6

# Tes Web Server
curl palantir.aliansi.rpl
curl ironhills.aliansi.rpl

ping google.com -c 3
# Harus Reply