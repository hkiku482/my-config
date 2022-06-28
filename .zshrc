HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
ZSH_THEME="adam2"
setopt autocd
unsetopt beep
bindkey -v

zstyle :compinstall filename "/home/$USER/.zshrc"

autoload -Uz compinit
compinit

autoload -Uz promptinit
promptinit
prompt $ZSH_THEME

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -ahlvF'

cdll() {
    \cd "$@" && ll
}
alias cd='cdll'
alias cd..='cd ../'
