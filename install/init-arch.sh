# this script can run Arch linux based distros (Archm, Manjaro, EndoavourOS etc)
REPOSITORY_ROOT="https://raw.githubusercontent.com/hkiku482/my-config/main"
TMP_DIR="/tmp/hkiku482-my-config"

sudo pacman -Syu
sudo pacman -S archlinux-keyring
sudo pacman -S zsh git openssh base-devel pacman-contrib --needed

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl "https://archlinux.org/mirrorlist/?country=JP" -o ${TMP_DIR}/mirrorlist
sed -i "s/^#Server/Server/" ${TMP_DIR}/mirrorlist
rankmirrors ${TMP_DIR}/mirrorlist > ${TMP_DIR}/rankmirrorlist
sudo cp ${TMP_DIR}/rankmirrorlist /etc/pacman.d/mirrorlist

sudo pacman -S man nvtop gnu-free-fonts noto-fonts-cjk noto-fonts-emoji fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-im --needed
sudo pacman -S cups wget zsh-autosuggestions zsh-syntax-highlighting --needed

mkdir $TMP_DIR

sudo tee -a /etc/environment <<EOT > /dev/null
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
DefaultIMModule=fcitx5
EOT

# AUR
echo -n "do you want to use aur(yay)? [Y/n]"
read AUR_A
case $AUR_A in
    "" | [Yy]* )
    git clone https://aur.archlinux.org/yay.git ${TMP_DIR}/yay
    PREV_DIR=$(pwd)
    cd ${TMP_DIR}/yay
    makepkg -sirc
    cd $PREV_DIR
    yay -S google-chrome visual-studio-code-bin zoom otf-source-han-code-jp dropbox
    mkdir -p ~/.config/Code/User
    curl "${REPOSITORY_ROOT}/code/settings.json" -o ~/.config/Code/User/settings.json
    curl "${REPOSITORY_ROOT}/code/keybindings.json" -o ~/.config/Code/User/keybindings.json
    ;;
    * ) echo "skipped" ;;
esac

# GitHub
echo -n "do you use github? [Y/n]"
read GITHUB_A
case $GITHUB_A in
    "" | [Yy]* )
    echo -n "enter your github username: "
    read GITNAME
    echo -n "enter your github email: "
    read GITEMAIL
    git config --global user.name $GITNAME
    git config --global user.email $GITEMAIL
    if [ ! -e ~/.ssh/github ]; then
        ssh-keygen -f ~/.ssh/github -t ed25519 -N ""
    fi
    cat << EOS > ~/.ssh/config
Host github.com
    HostName github.com
    IdentityFile ~/.ssh/github
EOS
    chmod 644 ~/.ssh/config
    ;;
   * ) echo "skipped github setting";;
esac

# Docker
echo -n "do you want to set up docker? [Y/n]"
read DOCKER_A
case $DOCKER_A in
    "" | [Yy]* )
    sudo pacman -S docker docker-buildx docker-compose --needed
    sudo gpasswd -a $USER docker
    ;;
   * ) echo "skipped docker setting";;
esac

# Libvirt
echo -n "do you use libvirtd? [Y/n]"
read LIBVIRT_A
case $LIBVIRT_A in
    "" | [Yy]* )
    sudo pacman -S libvirt qemu-full virt-manager dnsmasq dmidecode --needed
    ;;
   * ) echo "skipped to install libvirtd";;
esac

# Rust
echo -n "do you want to get cargo(rustc)? [Y/n]"
read RUSTC_A
case $RUSTC_A in
    "" | [Yy]* )
    sudo pacman -S rustup --needed
    rustup default stable
    ;;
    * ) echo "skipped installing cargo" ;;
esac

# Golang
echo -n "do you want to get golang? [Y/n]"
read GO_A
case $GO_A in
    "" | [Yy]* ) sudo pacman -S go --needed ;;
    * ) echo "skipped installing golang" ;;
esac

# Python
echo -n "do you want to get python? [Y/n]"
read PY_A
case $PY_A in
    "" | [Yy]* ) sudo pacman -S python python-pip --needed ;;
    * ) echo "skipped installing python" ;;
esac

# Desktop
echo -n "do you want to use i3wm? [Y/n]"
read WM_A
case $WM_A in
    "" | [Yy]* )
    curl "${REPOSITORY_ROOT}/i3-dotfiles/use-i3.sh" -o ${TMP_DIR}/i3.sh
    chmod 744 ${TMP_DIR}/i3.sh
    ${TMP_DIR}/i3.sh
    ;;
    * ) echo "skipped installing i3wm" ;;
esac

# Neovim
echo -n "do you want to use neovim? [Y/n]"
read NVIM_A
case $NVIM_A in
    "" | [Yy]* )
    sudo pacman -S nvim --needed
    mkdir ~/.config/nvim
    git clone https://github.com/hkiku482/simple-nvim.git ~/.config/nvim
    rm -rf ~/.config/nvim/.git
    yay -S nvim-packer-git
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    ;;
    * ) echo "skipped installing neovim" ;;
esac
rm ~/.config/nvim/.git
rm ~/.config/nvim/.gitignore

# Zsh
sudo curl https://raw.githubusercontent.com/agnoster/agnoster-zsh-theme/master/agnoster.zsh-theme -o /usr/share/zsh/functions/Prompts/prompt_agnoster_setup
curl "${REPOSITORY_ROOT}/user/.zshrc" -o ~/.zshrc
chsh -s /bin/zsh $USER

rm -rf $TMP_DIR

echo "================="
echo "REBOOT RECOMENDED"
echo "================="
