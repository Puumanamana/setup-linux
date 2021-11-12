# PATH environment variable
export PATH=$HOME/.local/bin:$PATH

# Some other environment variables
export PYTHONDONTWRITEBYTECODE="1"
export EDITOR='emacs'
export NXF_SINGULARITY_CACHEDIR="$HOME/.singularity_images.cache"

# ZSH setup
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color

ZSH_THEME="gianu"

GEOMETRY_COLOR_DIR=yellow
GEOMETRY_COLOR_PROMPT=blue
PROMPT_GEOMETRY_EXEC_TIME=true
GEOMETRY_PLUGIN_HOSTNAME_SUFFIX=":"

DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.zplug/init.zsh
zplug load

# Aliases
alias em='emacs -nw'
alias gitlog="git log --graph --decorate"
alias rm='rm -i'
alias mv='mv -i'

function serve() {
    ip=$(hostname -I | awk '{print $1}')
    echo "http://${ip}:8080"
    http-server -s -p 8080 --no-dotfiles $1
}

function dims() {
    awk -v sep="$2" 'BEGIN{FS=sep}END{print NR" rows, " NF" columns"}' $1
}

# Some keybindings in case it doesn't work directly
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
