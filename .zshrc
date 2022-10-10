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

function conda_on() {
    __conda_setup="$('~/.miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "~/.miniconda3/etc/profile.d/conda.sh" ]; then
            . "~/.miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="~/.miniconda3/bin:$PATH"
        fi
    fi
}

function mamba_on() {
    if [ -f "~/.miniconda3/etc/profile.d/mamba.sh" ]; then
        . "~/.miniconda3/etc/profile.d/mamba.sh"
    fi
}

function serve() {
    ip=$(hostname -I | awk '{print $1}')
    echo "http://${ip}:8080"
    http-server -c -1 -s -p 8080 --no-dotfiles $1
}

function dims() {
    awk -v sep="$2" 'BEGIN{FS=sep}END{print NR" rows, " NF" columns"}' $1
}
