# Customization of linux machine
Author: Cedric Arisdakessian

## Setup ssh

1. setup ssh key: `ssh-keygen`
2. setup ssh for passwordless login: `ssh-copy-id [...]`
3. Add ssh key to [github](https://github.com/settings/keys)

## Zsh setup

```bash
sudo apt-get update && sudo apt-get install zsh fzy git
```

### Install oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy configuration
wget  -O ~/.zshrc https://raw.githubusercontent.com/Puumanamana/setup-linux/master/.zshrc
```

### zplug
```bash
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh \
&& source ~/.zplug/init.zsh
```

### Install enhancd and autosuggestions

```bash
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-autosuggestions"
zplug install
```

## Emacs setup

### Install

- Check emacs >27, and if not, uninstall and reinstall

```bash
# If emacs is old
sudo apt-get uninstall emacs-bin-common
# Figure out a way to install >27 if not available on current system (e.g., flatpak, conda, snap,...)

# Copy configuration
mkdir -p ~/.emacs.d && wget -O ~/.emacs.d/init.el https://raw.githubusercontent.com/Puumanamana/setup-linux/master/init.el
```

#### Nextflow mode

`git clone https://github.com/Emiller88/nextflow-mode.git nextflow-mode`
Dependency: groovy-mode

#### Copilot mode

`git clone https://github.com/zerolfx/copilot.el`

Dependency: editorconfig

Need to run copilot-login the first time

#### Nice to have

{yaml,markdown,dockerfile}-mode

## Install mambaforge
For latest version, check [here](https://github.com/conda-forge/miniforge#mambaforge)
```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh \
    && bash Mambaforge-Linux-x86_64.sh
rm -f Mambaforge-Linux-x86_64.sh
```
