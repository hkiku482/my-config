ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc

echo "Please enter the hostname of this PC: "
read HOSTNAME
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=jp106" >> /etc/vconsole.conf
echo $HOSTNAME >> /etc/hostname
unset HOSTNAME

passwd

echo "Please enter your name: "
read USERNAME
useradd -m -s /bin/bash $USERNAME
passwd $USERNAME
unset USERNAME

pacman -S intel-ucode grub efibootmgr pulseaudio pavucontrol netplan networkmanager sudo
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S git wget openssh adobe-source-han-sans-jp-fonts noto-fonts-cjk
pacman -S gnome gnome-extra fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-im
echo "GTK_IM_MODULE=fcitx5" >> /etc/environment
echo "QT_IM_MODULE=fcitx5" >> /etc/environment
echo "XMODIFIERS=@im=fcitx5" >> /etc/environment
echo "DefaultIMModule=fcitx5" >> /etc/environment

systemctl enable gdm

echo "------- edit some files and type commands -------"
echo "vim /etc/locale.gen"
echo "locale.gen"
echo "visudo"
echo "------- edit some files and type commands -------"
