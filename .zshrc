export EDITOR=emacs
export PYTHONDONTWRITEBYTECODE="1" # don't write .pyc
export TERM=xterm-256color
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 30   # auto-update every month

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="mm/dd/yyyy" # execution timestamp

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.zplug/init.zsh
zplug load

# Some keybindings in case it doesn't work directly
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Aliases
alias em='emacs -nw'
alias gitlog="git log --graph --decorate"
alias rm='rm -i'
alias mv='mv -i'

function serve() {
    ip=$(hostname -I | awk '{print $1}')
    echo "http://${ip}:8080"
    http-server -c -1 -s -p 8080 --no-dotfiles $1
}

function dims() {
    awk -v sep="$2" 'BEGIN{FS=sep}END{print NR" rows, " NF" columns"}' $1
}

function vll {
    [ -z "$1" ] && echo "Error: File required" && return 1 || file=$1
    ext=${file##*.}

    [ "$ext" = "csv" ] && sep=, || sep=$'\t'
    if [ ! -z "$2" ]; then
        sep="$2"
    fi
    column -t -s $sep $file | less -S
}
