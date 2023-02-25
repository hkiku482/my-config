REPOSITORY_ROOT="https://raw.githubusercontent.com/hkiku482/my-config/main"

sudo pacman -S xorg-server xorg-xinit xautolock --needed
sudo gpasswd -a $USER video

sudo pacman -S lightdm lightdm-webkit2-greeter lightdm-webkit-theme-litarvan --needed

sudo pacman -S i3-wm rofi i3blocks xss-lock feh picom network-manager-applet --needed
sudo pacman -S light pavucontrol pulseaudio pamixer thunar tumbler gvfs gvfs-smb udiskie ttf-roboto-mono ttf-dejavu awesome-terminal-fonts --needed
yay -S i3lock-color

sudo pacman -S archlinux-wallpaper alacritty bpytop neofetch conky --needed

mkdir ~/.config/i3
mkdir ~/.config/rofi
mkdir ~/.config/i3blocks
mkdir ~/.config/alacritty
mkdir ~/.config/conky

curl "${REPOSITORY_ROOT}/i3/i3.config" -o ~/.config/i3/config
curl "${REPOSITORY_ROOT}/i3/i3-appearance.config" -o ~/.config/i3/appearance
curl "${REPOSITORY_ROOT}/i3/handler/i3lock-color.sh" -o ~/.config/i3/i3lock-color.sh
chmod 744 ~/.config/i3/i3lock-color.sh

curl "${REPOSITORY_ROOT}/i3/config.rasi" -o ~/.config/rofi/config.rasi

curl "${REPOSITORY_ROOT}/i3/i3blocks.config" -o ~/.config/i3blocks/config
curl "${REPOSITORY_ROOT}/i3/handler/battery.sh" -o ~/.config/i3blocks/battery.sh
chmod 744 ~/.config/i3blocks/battery.sh
curl "${REPOSITORY_ROOT}/i3/handler/audio.sh" -o ~/.config/i3blocks/audio.sh
chmod 744 ~/.config/i3blocks/audio.sh

curl "${REPOSITORY_ROOT}/i3/alacritty.yml" -o ~/.config/alacritty/alacritty.yml

sudo curl "${REPOSITORY_ROOT}/xorg/30-touchpad.conf" -o /etc/X11/xorg.conf.d/

git clone https://github.com/hkiku482/simple-conky.git ~/.config/conky
rm -rf ~/.config/conky/.git
