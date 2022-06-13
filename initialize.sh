sudo apt update
sudo apt install vim zip unzip net-tools curl cmake build-essential -y

GOARCHI=""
GITHUB_A=""
RUSTC_A=""
GO_A=""
AUTH_KEY_FILE="~/.ssh/authorized_keys"
GITNAME=""
GITEMAIL=""

if [ ! -e $AUTH_KEY_FILE ]; then
    touch $AUTH_KEY_FILE
    chmod 644 $AUTH_KEY_FILE
fi


echo -n "do you want to set up github? [Y/n]"
read GITHUB_A
case $GITHUB_A in
    "" | [Yy]* )

    echo -n "input your github username: "
    read GITNAME

    echo -n "input your github email: "
    read GITEMAIL

    sudo apt install git -y
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


echo -n "do you want to use docker? [Y/n]"
read DOCKER_A
case $DOCKER_A in
    "" | [Yy]* )
    sudo apt install docker docker-compose -y
    sudo gpasswd -a $USER docker
    ;;
    * ) echo "skipped installing docker, docker-compose" ;;
esac

unset GOARCHI GITHUB_A RUSTC_A GO_A AUTH_KEY_FILE
