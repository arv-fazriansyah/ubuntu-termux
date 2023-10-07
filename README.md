# Ubuntu Termux Root
Instalasi Ubuntu Base 22.04 ke dalam perangkat smartphone Anda melalui Termux. Untuk memulai sistem, gunakan perintah `ubuntu`.

## PERINGATAN!
Instalasi dilakukan atas risiko Anda sendiri. Saya tidak bertanggung jawab atas kerusakan apa pun yang mungkin terjadi pada perangkat Anda.

## Persyaratan
• Magisk

• Arsitektur arm64, armhf, amd64, atau x86_64

## Instalasi
Gunakan perintah shell berikut di Termux untuk melakukan instalasi:
```bash
curl -s -L https://raw.githubusercontent.com/arv-fazriansyah/ubuntu-termux/main/install.sh -o install && bash install
```
## Uninstall
Pertama, hentikan semua layanan dan keluar dari Ubuntu dengan perintah `exit`, kemudian tutup Termux. Setelah itu, masukkan perintah shell di bawah ini ke Termux untuk melakukan deinstalasi. Jika Anda mengalami masalah, restart smartphone Anda dan jalankan kode lagi.
```bash
su
ubuntu -u
```
atau
```bash
su
ubuntu --uninstall
```
### Masalah saat apt upgrade
Jika Anda mengalami kesulitan dalam melakukan `apt upgrade`, masalah ini terjadi karena Ubuntu tidak mengenali versi kernel dengan benar di libc6. Gunakan perintah di bawah ini untuk mengatasi masalah ini.
```bash
apt-mark hold libc6
```
