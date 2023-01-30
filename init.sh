#!/usr/bin/env bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~ #
#        Setup shell
# ~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Install zsh if not there and a few other packages (emacs, docker)
sudo apt-get update -y && apt-get install -y zsh fzy emacs docker

# Download oh-my-zsh
echo y | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# Download my .zshrc
wget https://raw.githubusercontent.com/Puumanamana/setup-linux/master/.zshrc -O .zshrc && source ~/.zshrc

# zplug for plugins
source ~/.zplug/init.zsh

# Better cd command
zplug "b4b4r07/enhancd", use:init.sh
# Gray autosuggestion
zplug "zsh-users/zsh-autosuggestions"
zplug install

# ~~~~~~~~~~~~~~~~~~~~~~~~~ #
#        Setup mamba
# ~~~~~~~~~~~~~~~~~~~~~~~~~ #
conda install -y mamba
# Python env
mamba create -n py3 -c conda-forge -c bioconda -y pandas-gbq seaborn scipy scikit-learn scikit-survival xgboost
# R env
mambda create -n r -c conda-forge -c bioconda -y \
       r-remotes r-biocmanager r-tidyverse r-circlize r-survminer r-bigrquery r-ggpubr \
       bioconductor-deseq2 bioconductor-edger bioconductor-complexheatmap
# General bioinfo env
mambda create -n bioinfo -c conda-forge -c bioconda -y \
       seqtk samtools sra-tools fastp emboss parallel star bwa
