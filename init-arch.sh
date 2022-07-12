sudo pacman -Syy
sudo pacman -S vim zsh git wget openssh adobe-source-han-sans-jp-fonts noto-fonts-cjk

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
    wget -P ~/ https://go.dev/dl/$GOARCHI
    sudo tar -zxvf ~/$GOARCHI -C /usr/local/
    rm -rf ~/$GOARCHI
    sudo ln -s /usr/local/go/bin/go /usr/bin
    ;;
    * ) echo "skipped installing golang" ;;
esac

case $GITHUB_A in
    "" | [Yy]* ) cat ~/.ssh/github.pub
esac

echo -n "do you want to remove this script? [Y/n]"
read RMV
case $RMV in
    "" | [Yy]* )
        if [ -e ./init.sh ]; then
            rm ./init.sh
        fi
    ;;
    * ) echo "skipped to remove this script" ;;
esac

mkdir ~/workspaces
mkdir ~/Downloads/AUR

cd ~/Downloads/AUR
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -si
cd ~/Downloads/AUR
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin
makepkg -si

unset GITNAME GITEMAIL SSHCONFIG VIMRC GITHUB_A RUSTC_A GO_A RMV
