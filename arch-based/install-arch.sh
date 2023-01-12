# loadkeys jp106
# iwctl
# > station [NIC] connect [SSID]
# > exit
# timedatectl set-ntp true
# fdisk -l
# gdisk /dev/sda
# > n
# > <enter:1>
# > <enter:2048>
# > 512M
# > ef00
# > n
# > <enter:2>
# > <enter:default>
# > 4G
# > 8200
# > n
# > <enter:3>
# > <enter:default>
# > <enter:default>
# > <enter:8300>
# > w
# > Y
# mkfs.fat -F 32 /dev/sda1
# mkswap /dev/sda2
# mkfs.ext4 /dev/sda3
# mount /dev/sda3 /mnt
# mount --mkdir /dev/sda1 /mnt/boot
# pacstrap /mnt base linux linux-firmware base-devel
# genfstab -U /mnt >> /mnt/etc/fstab
# arch-chroot /mnt

##### AFTER arch-chroot #####

ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc

echo "Please enter the hostname of this PC: "
read HOSTNAME
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=jp106" >> /etc/vconsole.conf
echo $HOSTNAME >> /etc/hostname
unset HOSTNAME

echo "please edit /etc/locale.gen"
echo "press enter key to continue..."
read
vim /etc/locale.gen
locale.gen

pacman -Syu intel-ucode grub efibootmgr pulseaudio pavucontrol netplan networkmanager sudo
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S git wget openssh adobe-source-han-sans-jp-fonts noto-fonts-cjk zsh vim networkmanager

cat << EOF > /root/.vimrc
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set number
set virtualedit=onemore
set smartindent
set showmatch
set laststatus=2
set wildmode=list:longest
set clipboard=unnamedplus
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
xnoremap p "_dP
xnoremap P "_dP
syntax enable
set expandtab
set tabstop=4
set shiftwidth=4
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <ESC><ESC> :nohlsearch<CR><ESC>
EOF

echo "Change root user password"
passwd

echo "Please enter your name: "
read USERNAME
useradd -m -s /bin/zsh $USERNAME
passwd $USERNAME
usermod -G sudo $USERNAME
unset USERNAME

pacman -S xfce4 lightdm lightdm-gdk-greeter xorg-server xorg-apps fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-im

echo "GTK_IM_MODULE=fcitx5" >> /etc/environment
echo "QT_IM_MODULE=fcitx5" >> /etc/environment
echo "XMODIFIERS=@im=fcitx5" >> /etc/environment
echo "DefaultIMModule=fcitx5" >> /etc/environment

systemctl enable lightdm

echo "This script has completed"
