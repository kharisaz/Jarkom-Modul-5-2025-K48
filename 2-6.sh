[Palantir]
#tambahkan sebelum aaturan waktu

    # === SECURITY RULES (PORT SCAN PROTECTION) ===
    
    # 1. CEK BLACKLIST: Apakah IP ini sudah ditandai sebagai penyerang?
    # Jika IP ada di daftar 'penyerang_terblokir' (update list agar durasi blokir diperpanjang), REJECT paketnya.
    # Ini memenuhi syarat (b): Penyerang tidak bisa ping, nc, atau curl.
    up iptables -A INPUT -m recent --name penyerang_terblokir --update --seconds 60 -j REJECT

    # 2. LOGGING: Jika IP mengetuk lebih dari 15 kali dalam 20 detik
    # Syarat (a) & (c): Catat ke Log sistem.
    up iptables -A INPUT -m state --state NEW -m recent --name penghitung_scan --rcheck --seconds 20 --hitcount 15 -j LOG --log-prefix "PORT_SCAN_DETECTED: "

    # 3. BLOKIR: Jika IP mengetuk lebih dari 15 kali dalam 20 detik
    # Masukkan IP tersebut ke daftar 'penyerang_terblokir' lalu REJECT.
    up iptables -A INPUT -m state --state NEW -m recent --name penghitung_scan --rcheck --seconds 20 --hitcount 15 -m recent --name penyerang_terblokir --set -j REJECT

    # 4. PENDAFTARAN: Catat setiap koneksi baru ke daftar 'penghitung_scan'
    up iptables -A INPUT -m state --state NEW -m recent --name penghitung_scan --set


[Testing Elendil]
apt-get update && apt-get install nmap -y
nmap -p 1-100 192.235.0.26

# Tes Ping (Harus RTO)
ping 192.235.0.26 -c 3

# Tes Web (Harus Time Out)
curl 192.235.0.26

# Tes Netcat (Harus Time Out)
nc -zv -w 3 192.235.0.26 80


[Palantir]
# Baca kernel log (biasanya log iptables masuk sini)
dmesg | tail -n 20