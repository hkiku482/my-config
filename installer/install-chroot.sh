##### AFTER arch-chroot #####
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc

echo "Please enter the hostname of this PC: "
read HOSTNAME
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=jp106" >> /etc/vconsole.conf
echo $HOSTNAME >> /etc/hostname
unset HOSTNAME

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen
locale.gen

pacman -Syu
pacman -S archlinux-keyring
pacman -S grub efibootmgr networkmanager vi sudo
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

passwd
echo "Please enter your name: "
read USERNAME
useradd -m $USERNAME
passwd $USERNAME
gpasswd -a $USERNAME wheel

echo "This script has completed"
