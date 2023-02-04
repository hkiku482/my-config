# this script can run Arch linux based distros (Manjaro, EndoavourOS etc)
REPOSITORY_ROOT="https://raw.githubusercontent.com/hkiku482/my-config/main"
TMP_DIR="/tmp/hkiku482-my-config"

sudo pacman -Syu
sudo pacman -S archlinux-keyring
sudo pacman -S vim neovim zsh git openssh wget noto-fonts-cjk powerline fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-im --needed

mkdir $TMP_DIR

sudo tee -a /etc/environment <<EOT > /dev/null
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
DefaultIMModule=fcitx5
EOT

# AUR
echo -n "do you want to use aur(yay)? [Y/n]"
read RUSTC_A
case $RUSTC_A in
    "" | [Yy]* )
    git clone https://aur.archlinux.org/yay.git ${TMP_DIR}/yay
    PREV_DIR=$(pwd)
    cd ${TMP_DIR}/yay
    makepkg -sirc
    cd $PREV_DIR
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
    sudo pacman -S docker docker-compose --needed
    sudo gpasswd -a $USER docker
    ;;
   * ) echo "skipped docker setting";;
esac

# Rust
echo -n "do you want to get cargo(rustc)? [Y/n]"
read RUSTC_A
case $RUSTC_A in
    "" | [Yy]* ) sudo pacman -S rust --needed ;;
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
    curl "${REPOSITORY_ROOT}/i3/use-i3.sh" -o ${TMP_DIR}/i3.sh
    chmod 744 ${TMP_DIR}/i3.sh
    ${TMP_DIR}/i3.sh
    ;;
    * ) echo "skipped installing python" ;;
esac

# .vimrc
curl "${REPOSITORY_ROOT}/user/.vimrc" -o ~/.vimrc

# Zsh
curl https://raw.githubusercontent.com/agnoster/agnoster-zsh-theme/master/agnoster.zsh-theme -o /usr/share/zsh/functions/Prompts/prompt_agnoster_setup
curl "${REPOSITORY_ROOT}/user/.zshrc" -o ~/.zshrc
chsh -s /bin/zsh $USER

rm -rf $TMP_DIR
