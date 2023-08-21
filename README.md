# Customization of linux machine
Author: Cedric Arisdakessian

## Setup ssh
1) setup ssh key: `ssh-keygen`
2) setup ssh to remove server: `ssh-copy-id [...]`
3) At the beginning of each new session
`ssh-add`, or if it fails, do  `eval $(ssh-agent)` before
4) Add ssh key to [github](https://github.com/settings/keys)

## Zsh setup

```bash
sudo apt-get install zsh fzy

# Copy configuration
wget https://raw.githubusercontent.com/Puumanamana/setup-linux/master/.zshrc -O ~
```

### Install oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### zplug
```bash
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
source ~/.zplug/init.zsh
```

### Install enhancd and autosuggestions

```bash
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-autosuggestions"
zplug install
```

## Emacs setup

- Check emacs >27
- Clone git@github.com:Emiller88/nextflow-mode.git
    - Dependency: groovy-mode
- Clone https://github.com/zerolfx/copilot.el
    - Dependency: editorconfig
    - Probably need to run copilot-login the first time
- Useful: {yaml,markdown,dockerfile}-mode

## Install mambaforge
For latest version, check [here](https://github.com/conda-forge/miniforge#mambaforge)
```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh \
    && bash Mambaforge-Linux-x86_64.sh
rm -f Mambaforge-Linux-x86_64.sh
```
