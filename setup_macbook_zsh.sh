#!/bin/bash -xe

# To install
# sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/peteroneilljr/.dotfiles/master/setup_macbook_zsh.sh)"

# ---------------------------------------------------------------------------- #
# Find package manager
# ---------------------------------------------------------------------------- #

if [[ -x "/usr/local/bin/brew" ]]; then 
  PCK_MGR="/usr/local/bin/brew"
else 
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/peteroneilljr/.dotfiles/master/setup_macbook_tools.sh)"
fi

# ---------------------------------------------------------------------------- #
#   # install zsh
# ---------------------------------------------------------------------------- #

if ! command -V zsh; then 
  $PCK_MGR install zsh -y || \
    ( 
      echo "failed zsh install, attempting $PCK_MGR update"
      $PCK_MGR update -y --skip-broken
      $PCK_MGR install zsh -y || ( echo "failed zsh install"; exit 1 )
    )
else
  echo "zsh already installed"
fi

# ---------------------------------------------------------------------------- #
#   # https://github.com/ohmyzsh/ohmyzsh
# ---------------------------------------------------------------------------- #

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
  echo "Installed oh-my-zsh"
else
  echo "oh-my-zsh already installed"
fi

# ---------------------------------------------------------------------------- #
#   # Install zsh-autosuggestions plugin
# ---------------------------------------------------------------------------- #

if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$HOME"/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
  echo "Installed zsh-autosuggestions" || echo "Install failed"
else
  echo "zsh-autosuggestions already installed"
fi

# ---------------------------------------------------------------------------- #
#   # Install zsh-syntax-highlighting plugin
# ---------------------------------------------------------------------------- #

if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$HOME"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
  echo "Installed zsh-syntax-highlighting" || echo "Install failed"
else
  echo "zsh-syntax-highlighting already installed"
fi

# ---------------------------------------------------------------------------- #
# Download dotfiles https://github.com/peteroneilljr/.dotfiles.git
# ---------------------------------------------------------------------------- #

if [[ ! -d "$HOME/.dotfiles" ]]; then
  # Save current zshrc file if it exists
  git clone https://github.com/peteroneilljr/.dotfiles.git "$HOME"/.dotfiles && \
  echo "Installed .dotfiles" || echo "failed to grab .dotfiles from github"
else
  echo ".dotfiles already installed"
fi

# ---------------------------------------------------------------------------- #
# Backup old zshrc and create a symlink to new zshrc
# ---------------------------------------------------------------------------- #

if [[ -f "$HOME/.zshrc" ]] && [[ ! -L "$HOME/.zshrc" ]]; then 
  NOW=$(date +'%m-%d-%Y')
  mv "$HOME"/.zshrc "$HOME"/.zshrc.backup$NOW && \
  echo "created zshrc backup: "$HOME"/.zshrc.backup$NOW"; 
fi

if [[ -L "$HOME/.zshrc" ]]; then 
  echo ".zshrc already linked"; 
else 
  ln -sv ~/.dotfiles/.zshrc "$HOME";
fi
