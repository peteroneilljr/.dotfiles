#!/bin/bash -x

# ---------------------------------------------------------------------------- #
# Flags
# ---------------------------------------------------------------------------- #
# -s skip updates 
# 
# 
# 
SKIPUPDATE=false
while getopts ":s" opt; do
  case ${opt} in
    s )
      SKIPUPDATE=true
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))
# ---------------------------------------------------------------------------- #
# Find package manager
# ---------------------------------------------------------------------------- #
if [[ -x "/usr/bin/apt-get" ]]; then 
  PCK_MGR="/usr/bin/apt-get"
elif [[ -x "/usr/bin/yum" ]]; then 
  PCK_MGR="/usr/bin/yum"
else 
  echo "Not yum or apt: exiting" 
  exit 1
fi
if [[ $SKIPUPDATE == false ]]; then
  $PCK_MGR update -y || echo "Some packages failed to update"
fi

# ---------------------------------------------------------------------------- #
# Setup vim
# https://github.com/neovim/neovim/wiki/Installing-Neovim
# https://spacevim.org/
# ---------------------------------------------------------------------------- #

if ! command -V nvim; then
  if ! command -V python3; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    ln -sv $PWD/squashfs-root/usr/bin/nvim /usr/bin
  elif [[ $PCK_MGR == "/usr/bin/yum" ]]; then 
    # adds repository for yum package manager 
    $PCK_MGR install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm; 
    $PCK_MGR install -y python3-neovim neovim
  else
    $PCK_MGR install -y neovim
  fi
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
# ---------------------------------------------------------------------------- #
# Install YQ 
# ---------------------------------------------------------------------------- #
if ! command -V yq; then
  YQVERSION='3.4.0'
  YQBINARY='yq_linux_amd64'
  curl -LO "https://github.com/mikefarah/yq/releases/download/$YQVERSION/$YQBINARY"
  chmod +x ./$YQBINARY
  mv ./$YQBINARY /usr/bin/yq
else
  echo "yq already installed"
fi
# ---------------------------------------------------------------------------- #
# Install strongDM 
# ---------------------------------------------------------------------------- #
if ! command -V sdm; then
  curl -J -O -L https://app.strongdm.com/releases/cli/linux && \
  unzip sdmcli* && \
  rm -f sdmcli* && \
  ./sdm install --nologin --user="$(logname)"
else
  echo "sdm already installed"
fi
# ---------------------------------------------------------------------------- #
# Cleanup file ownership
# ---------------------------------------------------------------------------- #
if ! logname; then
  THISUSER="$USER"
else 
  THISUSER="$(logname)"
fi
if [[ "$THISUSER" != "root" ]]; then
  echo "updating file ownership of home directory"
  chown -R "$THISUSER":"$THISUSER" "$HOME"
fi
