# Customization of linux machine
Author: Cedric Arisdakessian

## Setup ssh
1) setup ssh key: `ssh-keygen`
2) setup ssh to remove server: `ssh-copy-id [...]`
3) At the beginning of each new session
`ssh-add`, or if it fails, do  `eval $(ssh-agent)` before

## Install oh-my-zsh
```bash
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
```

## Install miniconda
For latest version, check [here](https://docs.conda.io/en/latest/miniconda.html)
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
```
And install mamba
```
conda install -c conda-forge -y mamba
```

Install packages using provided yaml file
```bash
source ~/.zshrc
mamba env create -f conda-r.yaml
mamba env create -f conda-python.yaml
```
