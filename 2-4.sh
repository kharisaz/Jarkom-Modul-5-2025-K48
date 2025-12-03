[IronHills]

#tambah config
# 1. Aturan Waktu: BLOKIR jika Senin s.d Jumat (Weekdays)
up iptables -A INPUT -p tcp --dport 80 -m time --weekdays Mon,Tue,Wed,Thu,Fri -j REJECT

# 2. Aturan Faksi: IZINKAN Subnet Teman (Hanya akan diproses jika Lolos aturan No 1 / Hari Sabtu-Minggu)
# Faksi Kurcaci (Durin - A4)
up iptables -A INPUT -p tcp --dport 80 -s 192.235.0.64/26 -j ACCEPT
# Faksi Pengkhianat (Khamul - A5)
up iptables -A INPUT -p tcp --dport 80 -s 192.235.0.32/29 -j ACCEPT
# Faksi Manusia (Elendil & Isildur - A9)
up iptables -A INPUT -p tcp --dport 80 -s 192.235.1.0/24 -j ACCEPT

# 3. Aturan Sisa: BLOKIR Siapapun yang tidak masuk daftar teman (Contoh: Elf Gilgalad)
up iptables -A INPUT -p tcp --dport 80 -j REJECT

#make sure web server dan ironhills nginx aktif

#cmd today (wed)
date -s "2025-10-01 10:00:00"


[Testing Durin]
apt-get update
curl ironhills.aliansi.rpl


#ubah hari di ironhills (sat), lalu ulangi tes durin
date -s "2025-10-04 10:00:00"
