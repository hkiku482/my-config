GOARCHI="go1.18.3.linux-amd64.tar.gz"

sudo pacman -Syy
sudo pacman -S vim zsh git wget openssh adobe-source-han-sans-jp-fonts noto-fonts-cjk fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-im

echo -n "do you want to set up github? [Y/n]"
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


echo -n "do you want to get cargo(rustc)? [Y/n]"
read RUSTC_A
case $RUSTC_A in
    "" | [Yy]* ) curl https://sh.rustup.rs -sSf | sh ;;
    * ) echo "skipped installing cargo" ;;
esac


echo -n "do you want to get golang? [Y/n]"
read GO_A
case $GO_A in
    "" | [Yy]* )
    wget https://go.dev/dl/$GOARCHI -P ~/
    sudo tar -zxvf ~/$GOARCHI -C /usr/local/
    rm -rf ~/$GOARCHI
    sudo ln -s /usr/local/go/bin/go /usr/bin
    ;;
    * ) echo "skipped installing golang" ;;
esac

case $GITHUB_A in
    "" | [Yy]* ) cat ~/.ssh/github.pub
esac

mkdir -p ~/workspaces
mkdir -p ~/Downloads/AUR

# cd ~/Downloads/AUR
# git clone https://aur.archlinux.org/google-chrome.git
# cd google-chrome
# makepkg -si
# cd ~/Downloads/AUR
# git clone https://aur.archlinux.org/visual-studio-code-bin.git
# cd visual-studio-code-bin
# makepkg -si
# cd

unset GITHUB_A GITNAME GITEMAIL RUSTC_A GOARCHI
