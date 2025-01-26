REPOSITORY_ROOT="https://raw.githubusercontent.com/hkiku482/my-config/main"

sudo pacman -S --noconfirm --needed xorg-server
sudo pacman -S --noconfirm --needed lightdm lightdm-webkit2-greeter lightdm-webkit-litarvan
sudo pacman -S --noconfirm --needed cinnamon materia-gtk-theme cosmic-icon-theme
sudo pacman -S --noconfirm --needed firefox alacritty gnu-free-fonts noto-fonts-cjk noto-fonts-emoji ttf-roboto-mono ttf-dejavu awesome-terminal-fonts fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-im

sudo sed -i 's/#greeter-session=.*/greeter-session=lightdm-webkit2-greeter/' /etc/lightdm/lightdm.conf
sudo sed -i 's/antergos/litarvan/' /etc/lightdm/lightdm-webkit2-greeter.conf

sudo tee -a /etc/environment <<EOT > /dev/null
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
DefaultIMModule=fcitx5
EOT

mkdir -p ~/.config/alacritty
curl "${REPOSITORY_ROOT}/desktop/common/alacritty/alacritty.toml" -o ~/.config/alacritty/alacritty.toml
curl "${REPOSITORY_ROOT}/user/keymap.txt" -o ~/keymap.txt
