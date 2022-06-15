sudo apt update
sudo apt install vim zip unzip net-tools network-manager curl cmake build-essential -y

GITHUB_A=""
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


echo -n "do you want to use docker? [Y/n]"
read DOCKER_A
case $DOCKER_A in
    "" | [Yy]* )
    sudo apt install docker docker-compose -y
    sudo gpasswd -a $USER docker
    ;;
    * ) echo "skipped installing docker, docker-compose" ;;
esac

unset GOARCHI GITHUB_A AUTH_KEY_FILE
