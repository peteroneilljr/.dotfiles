#!/bin/bash 

# add -x for extended output

# ---------------------------------------------------------------------------- #
# Install homebrew and common tools
# ---------------------------------------------------------------------------- #
if ! command -V brew; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else 
  echo "brew already installed"
fi
if ! command -V python3; then
  brew install python3
else 
  echo "python3 already installed"
fi
if ! command -V git; then
  brew install git
else 
  echo "git already installed"
fi
if ! command -V terraform; then
  brew install terraform
else 
  echo "terraform already installed"
fi
if ! command -V nvim; then
  brew install neovim
else 
  echo "neovim already installed"
fi
if ! command -V kubectl; then
  brew install kubectl
else 
  echo "kubectl already installed"
fi
if ! command -V yq; then
  brew install yq
else 
  echo "yq already installed"
fi
if ! command -V jq; then
  brew install jq
else 
  echo "jq already installed"
fi
if ! command -V gmailctl; then
  brew install gmailctl
else 
  echo "gmailctl already installed"
fi
