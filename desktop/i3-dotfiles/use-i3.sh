REPOSITORY_ROOT="https://raw.githubusercontent.com/hkiku482/my-config/main"

sudo pacman -S --noconfirm --needed xorg-server xorg-xinit xf86-input-synaptics xorg-xrandr xorg-xbacklight xautolock
sudo pacman -S --noconfirm --needed brightnessctl acpi pavucontrol pulseaudio pamixer
sudo pacman -S --noconfirm --needed lightdm lightdm-webkit2-greeter lightdm-webkit-theme-litarvan
sudo pacman -S --noconfirm --needed i3-wm rofi i3blocks xss-lock feh picom conky
sudo pacman -S --noconfirm --needed network-manager-applet gnu-free-fonts noto-fonts-cjk noto-fonts-emoji ttf-roboto-mono ttf-dejavu awesome-terminal-fonts fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-im
sudo pacman -S --noconfirm --needed thunar alacritty tumbler gvfs gvfs-smb udiskie dunst archlinux-wallpaper

sudo tee -a /etc/environment <<EOT > /dev/null
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
DefaultIMModule=fcitx5
EOT

yay -S i3lock-color --needed

mkdir -p ~/.config/i3
mkdir -p ~/.config/rofi
mkdir -p ~/.config/i3blocks
mkdir -p ~/.config/picom
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/conky

curl "${REPOSITORY_ROOT}/desktop/common/alacritty/alacritty.toml" -o ~/.config/alacritty/alacritty.toml

curl "${REPOSITORY_ROOT}/desktop/i3-dotfiles/i3/config" -o ~/.config/i3/config
curl "${REPOSITORY_ROOT}/desktop/i3-dotfiles/i3/appearance.conf" -o ~/.config/i3/appearance.conf
curl "${REPOSITORY_ROOT}/desktop/i3-dotfiles/i3/i3lock-color.sh" -o ~/.config/i3/i3lock-color.sh
chmod 744 ~/.config/i3/i3lock-color.sh

curl "${REPOSITORY_ROOT}/desktop/i3-dotfiles/i3blocks/config" -o ~/.config/i3blocks/config
curl "${REPOSITORY_ROOT}/desktop/i3-dotfiles/i3blocks/audio.sh" -o ~/.config/i3blocks/audio.sh
curl "${REPOSITORY_ROOT}/desktop/i3-dotfiles/i3blocks/battery.sh" -o ~/.config/i3blocks/battery.sh
chmod 744 ~/.config/i3blocks/battery.sh
chmod 744 ~/.config/i3blocks/audio.sh

curl "${REPOSITORY_ROOT}/desktop/i3-dotfiles/picom/picom.conf" -o ~/.config/picom/picom.conf

curl "${REPOSITORY_ROOT}/desktop/i3-dotfiles/rofi/config.rasi" -o ~/.config/rofi/config.rasi
curl "${REPOSITORY_ROOT}/desktop/i3-dotfiles/rofi/color.rasi" -o ~/.config/rofi/color.rasi

sudo curl "${REPOSITORY_ROOT}/xorg/30-touchpad.conf" -o /etc/X11/xorg.conf.d/30-touchpad.conf

git clone https://github.com/hkiku482/simple-conky.git ~/.config/conky
rm -rf ~/.config/conky/.git

sudo sed -i 's/#greeter-session=.*/greeter-session=lightdm-webkit2-greeter/' /etc/lightdm/lightdm.conf
sudo sed -i 's/antergos/litarvan/' /etc/lightdm/lightdm-webkit2-greeter.conf
