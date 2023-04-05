REPOSITORY_ROOT="https://raw.githubusercontent.com/hkiku482/my-config/main"

sudo pacman -S xorg-server xorg-xinit xautolock --needed
sudo gpasswd -a $USER video

sudo pacman -S lightdm lightdm-webkit2-greeter lightdm-webkit-theme-litarvan --needed

sudo pacman -S i3-wm rofi i3blocks xss-lock feh picom network-manager-applet --needed
sudo pacman -S light acpi pavucontrol pulseaudio pamixer thunar tumbler gvfs gvfs-smb udiskie ttf-roboto-mono ttf-dejavu awesome-terminal-fonts --needed
yay -S i3lock-color

sudo pacman -S archlinux-wallpaper alacritty bpytop neofetch conky --needed

mkdir -p ~/.config/i3
mkdir -p ~/.config/rofi
mkdir -p ~/.config/i3blocks
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/conky

curl "${REPOSITORY_ROOT}/i3-dotfiles/alacritty/alacritty.yml" -o ~/.config/alacritty/alacritty.yml

curl "${REPOSITORY_ROOT}/i3-dotfiles/i3/config" -o ~/.config/i3/config
curl "${REPOSITORY_ROOT}/i3-dotfiles/i3/appearance.conf" -o ~/.config/i3/appearance.conf
curl "${REPOSITORY_ROOT}/i3-dotfiles/i3/i3lock-color.sh" -o ~/.config/i3/i3lock-color.sh
chmod 744 ~/.config/i3/i3lock-color.sh

curl "${REPOSITORY_ROOT}/i3-dotfiles/i3blocks/config" -o ~/.config/i3blocks/config
curl "${REPOSITORY_ROOT}/i3-dotfiles/i3blocks/audio.sh" -o ~/.config/i3blocks/audio.sh
curl "${REPOSITORY_ROOT}/i3-dotfiles/i3blocks/battery.sh" -o ~/.config/i3blocks/battery.sh
chmod 744 ~/.config/i3blocks/battery.sh
chmod 744 ~/.config/i3blocks/audio.sh

curl "${REPOSITORY_ROOT}/i3-dotfiles/rofi/config.rasi" -o ~/.config/rofi/config.rasi
curl "${REPOSITORY_ROOT}/i3-dotfiles/rofi/color.rasi" -o ~/.config/rofi/color.rasi

sudo curl "${REPOSITORY_ROOT}/xorg/30-touchpad.conf" -o /etc/X11/xorg.conf.d/

git clone https://github.com/hkiku482/simple-conky.git ~/.config/conky
rm -rf ~/.config/conky/.git
