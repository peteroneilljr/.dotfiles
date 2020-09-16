#!/bin/bash -xe

# ---------------------------------------------------------------------------- #
# Find package manager
# ---------------------------------------------------------------------------- #
if [[ -x "/usr/bin/apt-get" ]]; then 
  PCK_MGR="/usr/bin/apt-get"
elif [[ -x "/usr/bin/yum" ]]; then 
  PCK_MGR="/usr/bin/yum"
else 
  echo "Not yum or apt exiting" 
fi
$PCK_MGR update -y

# ---------------------------------------------------------------------------- #
# Setup vim
# https://github.com/neovim/neovim/wiki/Installing-Neovim
# https://spacevim.org/
# ---------------------------------------------------------------------------- #
if ! command -V nvim; then
  if [[ $PCK_MGR == "/usr/bin/yum" ]]; then 
    # adds repository for yum package manager 
    $PCK_MGR install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm; 
  fi
  $PCK_MGR install -y neovim
else
  echo "neovim already installed"
fi
if [[ ! -d "$HOME/.SpaceVim" ]]; then
  curl -sLf https://spacevim.org/install.sh | bash
else
  echo "SpaceVim already installed"
fi
# ---------------------------------------------------------------------------- #
# Install kubernetes
# ---------------------------------------------------------------------------- #
if ! command -V kubectl; then 
  curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x ./kubectl
  mv ./kubectl /usr/local/bin/kubectl
else
  echo "kubectl already installed"
fi
