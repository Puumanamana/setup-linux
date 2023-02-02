#!/usr/bin/env bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~ #
#        Setup shell
# ~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Install zsh if not there and a few other packages (emacs, docker)
sudo apt-get update -y && sudo apt-get install -y zsh fzy emacs docker wget git tmux

# Download oh-my-zsh
echo y | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# zplug for plugins
chsh -s /bin/zsh USERNAME
zsh
source ~/.zplug/init.zsh

# Better cd command
zplug "b4b4r07/enhancd", use:init.sh
# Gray autosuggestion
zplug "zsh-users/zsh-autosuggestions"
zplug install

# Download my .zshrc
wget https://raw.githubusercontent.com/Puumanamana/setup-linux/master/.zshrc -O .zshrc && source ~/.zshrc

# ~~~~~~~~~~~~~~~~~~~~~~~~~ #
#        Setup emacs
# ~~~~~~~~~~~~~~~~~~~~~~~~~ #

mkdir -p ~/.emacs.d
wget https://raw.githubusercontent.com/Puumanamana/setup-linux/master/init.el -O .emacs.d/init.el
wget https://raw.githubusercontent.com/Emiller88/nextflow-mode/master/nextflow-mode.el -O .emacs.d/nextflow-mode.el

for pkg in groovy-mode yaml-mode markdown-mode ess helm dockerfile-mode; do
    curl https://raw.githubusercontent.com/Puumanamana/setup-linux/master/emacs-pkg-install.sh | bash -s $pkg
done

# ~~~~~~~~~~~~~~~~~~~~~~~~~ #
#        Setup mamba
# ~~~~~~~~~~~~~~~~~~~~~~~~~ #

curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh" &&
    echo '\nyes\n\nyes\n' | bash Mamba*.sh &&
    rm -f Mamba*.sh

# Python env
mamba create -n py3 -c conda-forge -c bioconda -y pandas-gbq seaborn scipy scikit-learn scikit-survival
# R env
mamba create -n r -c conda-forge -c bioconda -y \
       r-remotes r-biocmanager r-tidyverse r-circlize r-survminer r-bigrquery r-ggpubr \
       bioconductor-deseq2 bioconductor-edger bioconductor-complexheatmap
# General bioinfo env
mamba create -n bioinfo -c conda-forge -c bioconda -y \
       seqtk samtools sra-tools fastp emboss parallel star bwa
       
       
# ~~~~~~~~~~~~~~~~~~~~~~~~~ #
#        GCP only
# ~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Install google cloud sdk
mamba install google-cloud-sdk

# configure docker
gcloud

# Mount a bucket
## Install instructions: https://github.com/GoogleCloudPlatform/gcsfuse/blob/master/docs/installing.md
mkdir FOLDER && gcsfuse --implicit-dirs BUCKET FOLDER 
# Unmount
fusermount -u PATH/TO/FOLDER
