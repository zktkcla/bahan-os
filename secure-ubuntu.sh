#!/bin/bash
# secure-ubuntu.sh
# Skrip Konfigurasi Keamanan Dasar Ubuntu (Fokus Cyber Security)

echo "[+] Memperbarui sistem..."
sudo apt update && sudo apt upgrade -y

echo "[+] Menghapus layanan jaringan yang tidak perlu..."
sudo apt remove -y telnet vsftpd samba apache2 nginx avahi-daemon cups rpcbind nfs-common

echo "[+] Menonaktifkan SSH jika tidak diperlukan..."
sudo systemctl disable ssh
sudo systemctl stop ssh

echo "[+] Mengaktifkan firewall (UFW)..."
sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

echo "[+] Menyembunyikan versi kernel dari banner login..."
sudo sed -i 's/#Banner none/Banner \/etc\/issue.net/' /etc/ssh/sshd_config
echo "" | sudo tee /etc/issue.net

echo "[+] Menonaktifkan IPv6 jika tidak digunakan..."
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "[+] Mengaktifkan AppArmor..."
sudo systemctl enable apparmor
sudo systemctl start apparmor

echo "[+] Menginstal Fail2Ban..."
sudo apt install -y fail2ban

echo "[+] Instalasi Lynis untuk audit keamanan..."
sudo apt install -y lynis

echo "[+] Konfigurasi keamanan selesai!"
