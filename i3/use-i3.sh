REPOSITORY_ROOT="https://raw.githubusercontent.com/hkiku482/my-config/main"

sudo pacman -S xorg-server xorg-xinit xautolock light --needed
sudo pacman -S lightdm lightdm-webkit2-greeter --needed
sudo pacman -S i3-wm rofi i3blocks pamixer xss-lock --needed
yay -S i3lock-color
sudo pacman -S alacritty bpytop neofetch picom conky feh --needed

mkdir ~/.config/i3
mkdir ~/.config/rofi
mkdir ~/.config/i3blocks

curl "${REPOSITORY_ROOT}/i3/i3.config" -o ~/.config/i3/config
curl "${REPOSITORY_ROOT}/i3/handler/i3lock-color.sh" -o ~/.config/i3/i3lock-color.sh

curl "${REPOSITORY_ROOT}/i3/config.rasi" -o ~/.config/rofi/config.rasi

curl "${REPOSITORY_ROOT}/i3/i3blocks.config" -o ~/.config/i3blocks/config
curl "${REPOSITORY_ROOT}/i3/handler/battery.sh" -o ~/.config/i3blocks/battery.sh
curl "${REPOSITORY_ROOT}/i3/handler/audio.sh" -o ~/.config/i3blocks/audio.sh
