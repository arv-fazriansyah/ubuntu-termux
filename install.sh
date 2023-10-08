#!/system/bin/sh

#localbuild="/data/local/tmp/ubuntu"
localbuild="/data/data/com.termux/files/home/ubuntu"

if [ "$EUID" -ne 0 ]
then
    # Alat yang diperlukan di Termux untuk menginstal ubuntu
    pkg up -y -qq
    pkg install tsu -y -qq
    pkg install git -y -qq
    pkg install xz-utils -y -qq
    pkg install wget -y -qq

    #sudo mount -o rw,remount /data 2> /dev/null

    # Memeriksa arsitektur perangkat
    case `dpkg --print-architecture` in
        aarch64)
            archurl="arm64" ;;
        arm)
            archurl="armhf" ;;
        amd64)
            archurl="amd64" ;;
        x86_64)
            archurl="amd64" ;;
        *)
        echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m Arsitektur tidak dikenal \e[0m"; exit 1;;
        
    esac

    # Mengunduh file-file yang diperlukan untuk berfungsi dengan baik
    git clone https://github.com/arv-fazriansyah/ubuntu-termux.git
    cd ubuntu-termux

    # Mengunduh Basis Ubuntu 22.04 sesuai dengan arsitektur
    wget "https://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04-base-$archurl.tar.gz" -O ubuntu-base.tar.gz

    # Membuat folder di sistem
    sudo mkdir -p $localbuild                                    # Folder untuk instalasi ubuntu
    sudo mkdir -p $localbuild/dev                                # Folder untuk sumber daya tambahan ubuntu
    sudo mkdir -p $localbuild/run/sshd                           # Membuat direktori /run/sshd jika belum ada
    

    # Mengekstrak sistem ubuntu ke dalam folder yang telah dibuat di sistem
    sudo tar -xzf ./ubuntu-base.tar.gz --exclude='dev' -C $localbuild

    # Mengubah izin file
    chmod 777 ./scripts/ubuntu
    chmod 644 ./scripts/passwd
    chmod 644 ./scripts/resolv.conf
    chmod 644 ./scripts/hosts
    chmod 644 ./scripts/group
    chmod 640 ./scripts/shadow
    chmod 640 ./scripts/gshadow
    chmod 755 ./scripts/adduser

    # Konfigurasi yang diperlukan untuk menjalankan Ubuntu
    sudo mv ./scripts/resolv.conf $localbuild/etc                # Menambahkan DNS
    sudo mv ./scripts/hosts $localbuild/etc                      # Menambahkan domain lokal
    sudo mv ./scripts/group $localbuild/etc                      # Izin grup
    sudo mv ./scripts/passwd $localbuild/etc                     # Izin pengguna
    sudo mv ./scripts/shadow $localbuild/etc                     # Keamanan informasi akun
    sudo mv ./scripts/gshadow $localbuild/etc                    # Keamanan informasi grup
    sudo mv ./scripts/adduser $localbuild/sbin                   # Skrip kustom, untuk memperbaiki masalah internet
    mv ./scripts/ubuntu $PREFIX/bin                              # Pintasan untuk memulai ubuntu

    # Membersihkan instalasi
    rm -rf ../ubuntu-termux
    rm ../install

    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m Instalasi berhasil! \e[0m"
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m Gunakan perintah 'ubuntu' untuk memulai sistem. \e[0m"
else
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m Instalasi tidak berfungsi langsung dari root. \e[0m"
fi
