# this script can run Arch linux based distros (Manjaro, EndoavourOS etc)

GOARCHI="go1.19.3.linux-amd64.tar.gz"

pacman -Syu && pacman -S vim zsh git openssh wget adobe-source-han-sans-jp-fonts noto-fonts-cjk fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-im --needed

echo "GTK_IM_MODULE=fcitx5" >> /etc/environment
echo "QT_IM_MODULE=fcitx5" >> /etc/environment
echo "XMODIFIERS=@im=fcitx5" >> /etc/environment
echo "DefaultIMModule=fcitx5" >> /etc/environment

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

echo -n "do you want to set up docker? [Y/n]"
read DOCKER_A
case $DOCKER_A in
    "" | [Yy]* )
    pacman -S docker docker-compose
    gpasswd -a $USER docker
    ;;
   * ) echo "skipped docker setting";;
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
    tar -zxvf ~/$GOARCHI -C /usr/local/
    rm -rf ~/$GOARCHI
    ln -s /usr/local/go/bin/go /usr/bin
    ;;
    * ) echo "skipped installing golang" ;;
esac

case $GITHUB_A in
    "" | [Yy]* ) echo "##### GitHub Publick Key #####"; cat ~/.ssh/github.pub; echo "##############################"
esac

wget https://raw.githubusercontent.com/hkiku482/my-config/main/.vimrc ~/.vimrc

# source https://raw.githubusercontent.com/agnoster/agnoster-zsh-theme/master/agnoster.zsh-theme
cat << EOS > /usr/share/zsh/functions/Prompts/prompt_agnoster_setup
typeset -aHg AGNOSTER_PROMPT_SEGMENTS=(
    prompt_status
    prompt_context
    prompt_virtualenv
    prompt_dir
    prompt_git
    prompt_end
)

CURRENT_BG='NONE'
if [[ -z "\$PRIMARY_FG" ]]; then
        PRIMARY_FG=black
fi

SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

prompt_segment() {
  local bg fg
  [[ -n \$1 ]] && bg="%K{\$1}" || bg="%k"
  [[ -n \$2 ]] && fg="%F{\$2}" || fg="%f"
  if [[ \$CURRENT_BG != 'NONE' && \$1 != \$CURRENT_BG ]]; then
    print -n "%{\$bg%F{\$CURRENT_BG}%}\$SEGMENT_SEPARATOR%{\$fg%}"
  else
    print -n "%{\$bg%}%{\$fg%}"
  fi
  CURRENT_BG=\$1
  [[ -n \$3 ]] && print -n \$3
}

prompt_end() {
  if [[ -n \$CURRENT_BG ]]; then
    print -n "%{%k%F{\$CURRENT_BG}%}\$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

prompt_context() {
  local user=`whoami`

  if [[ "\$user" != "\$DEFAULT_USER" || -n "\$SSH_CONNECTION" ]]; then
    prompt_segment \$PRIMARY_FG default " %(!.%{%F{yellow}%}.)\$user@%m "
  fi
}

prompt_git() {
  local color ref
  is_dirty() {
    test -n "\$(git status --porcelain --ignore-submodules)"
  }
  ref="\$vcs_info_msg_0_"
  if [[ -n "\$ref" ]]; then
    if is_dirty; then
      color=yellow
      ref="\${ref} \$PLUSMINUS"
    else
      color=green
      ref="\${ref} "
    fi
    if [[ "\${ref/.../}" == "\$ref" ]]; then
      ref="\$BRANCH \$ref"
    else
      ref="\$DETACHED \${ref/.../}"
    fi
    prompt_segment \$color \$PRIMARY_FG
    print -n " \$ref"
  fi
}

prompt_dir() {
  prompt_segment blue \$PRIMARY_FG ' %~ '
}

prompt_status() {
  local symbols
  symbols=()
  [[ \$RETVAL -ne 0 ]] && symbols+="%{%F{red}%}\$CROSS"
  [[ \$UID -eq 0 ]] && symbols+="%{%F{yellow}%}\$LIGHTNING"
  [[ \$(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}\$GEAR"

  [[ -n "\$symbols" ]] && prompt_segment \$PRIMARY_FG default " \$symbols "
}

prompt_virtualenv() {
  if [[ -n \$VIRTUAL_ENV ]]; then
    color=cyan
    prompt_segment \$color \$PRIMARY_FG
    print -Pn " \$(basename \$VIRTUAL_ENV) "
  fi
}

prompt_agnoster_main() {
  RETVAL=\$?
  CURRENT_BG='NONE'
  for prompt_segment in "\${AGNOSTER_PROMPT_SEGMENTS[@]}"; do
    [[ -n \$prompt_segment ]] && \$prompt_segment
  done
}

prompt_agnoster_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}\$(prompt_agnoster_main) '
}

prompt_agnoster_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_agnoster_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_agnoster_setup "\$@"
EOS

cat << EOS > ~/.zshrc

autoload -Uz promptinit
promptinit
prompt agnoster

setopt histignorealldups sharehistory

bindkey -e

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "\$(dircolors -b)"
zstyle ':completion:*:default' list-colors \${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u \$USER -o pid,%cpu,tty,cputime,cmd'

alias ll='ls -ahlvF'

bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[3~' delete-char
bindkey '\e[2~' quoted-insert
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word
bindkey '\e[5C' forward-word
bindkey '\e[5D' backward-word
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word
EOS

chsh -s /bin/zsh $USER
