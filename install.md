# Customization of linux machine
Author: Cedric Arisdakessian

## Create some folders
`mkdir -p ~/.local/bin ~/.local/src ~/.emacs.d`

## Setup ssh
1) setup ssh key: `ssh-keygen`
2) setup ssh to remove server: `ssh-copy-id [...]`
3) At the beginning of each new session
`ssh-add`, or if it fails, do  `eval $(ssh-agent)` before

## Install oh-my-zsh
```bash
sudo apt-get update && sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install zplug
```bash
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
source ~/.zplug/init.zsh
```

## Add config files
`cp configs/.zshrc .`

## Install enhancd and autosuggestions
```bash
sudo apt-get install fzy

zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-autosuggestions"
zplug install
zplug load
```

## http-server
For latest version, check [here](https://nodejs.org/en/)

`wget -qO- c/dist/v12.18.4/node-v12.18.4-linux-x64.tar.xz | tar xz`

Move content and add binaries to PATH. Then, just use npm:
`npm install -g http-server`

Make sure http-server binary is in the PATH as well

## Install miniconda
For latest version, check [here](https://docs.conda.io/en/latest/miniconda.html)
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
```

Install packages using provided yaml file
```bash
source ~/.zshrc
conda env update -n base --file configs/conda.yaml
```

## Install emacs
```bash
sudo apt-get install emacs
git clone https://github.com/Emiller88/nextflow-mode.git configs/nextflow-mode
find configs -name "*.el" -exec cp {} ~/.emacs.d \;
```

Install MELPA packages using the emacs-pkg-install.sh script
```bash
for package in "groovy-mode jedi flycheck-pyflakes yaml-mode";
do
    ./emacs-pkg-install.sh $package
done
```

## Install byobu
https://www.byobu.org/
```bash
sudo apt-get install byobu
mkdir -p ~/.byobu && cp configs/keybindings.tmux ~/.byobu/
```

## Nextflow
```bash
sudo apt-get install default-jre
wget -qO- https://get.nextflow.io | bash
mkdir ~/.local/bin && mv nextflow ~/.local/bin
```

## vl, vll
```bash
wget https://github.com/w9/vll-haskell/releases/download/v0.0.1-hotfix2/vl
wget https://github.com/w9/vll-haskell/releases/download/v0.0.1-hotfix2/vll

chmod +x vl vll && mv vl vll ~/.local/bin
```

## Docker 
Instructions: https://docs.docker.com/engine/install/ubuntu
```bash
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
```

## Singularity 
Instructions: https://github.com/hpcng/singularity/blob/master/INSTALL.md

```bash
sudo apt-get update \
    && sudo apt-get install -y \
            build-essential \
            libseccomp-dev \
            pkg-config \
            squashfs-tools \
            cryptsetup

cd ~/.local/src \
    && wget -qO- https://golang.org/dl/go1.15.2.linux-amd64.tar.gz | tar xz \
    && ln -s ~/.local/src/go/bin/* ~/.local/bin

curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | \
    sh -s -- -b $(go env GOPATH)/bin v1.31.0

# source ~/.zshrc
mkdir -p ${GOPATH}/src/github.com/sylabs && \
  cd ${GOPATH}/src/github.com/sylabs && \
  git clone https://github.com/sylabs/singularity.git && \
  cd singularity

git checkout v3.6.3
./mconfig && \
  cd ./builddir && \
  make && \
  sudo make install

singularity version
```
