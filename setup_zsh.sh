#!/bin/bash -xe

# ---------------------------------------------------------------------------- #
# Find package manager
# ---------------------------------------------------------------------------- #
if [[ -x "/usr/bin/apt-get" ]];
  then PCK_MGR="/usr/bin/apt-get"
elif [[ -x "/usr/bin/yum" ]];
  then PCK_MGR="/usr/bin/yum"
fi
# ---------------------------------------------------------------------------- #
#   # install zsh
# ---------------------------------------------------------------------------- #
if ! command -V zsh; 
then 
  $PCK_MGR update -y
  $PCK_MGR install zsh -y
fi
# ---------------------------------------------------------------------------- #
#   # https://github.com/ohmyzsh/ohmyzsh
# ---------------------------------------------------------------------------- #
if [[ ! "$ZSH" != "$HOME/.oh-my-zsh" ]];
then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
  echo "Installed oh-my-zsh" || echo "Install failed"
else
  echo "oh-my-zsh already installed"
fi
# ---------------------------------------------------------------------------- #
#   # Install zsh-autosuggestions plugin
# ---------------------------------------------------------------------------- #
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]];
then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions && \
  echo "Installed zsh-autosuggestions" || echo "Install failed"
else
  echo "zsh-autosuggestions already installed"
fi
# ---------------------------------------------------------------------------- #
#   # Install zsh-syntax-highlighting plugin
# ---------------------------------------------------------------------------- #
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]];
then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting && \
  echo "Installed zsh-syntax-highlighting" || echo "Install failed"
else
  echo "zsh-syntax-highlighting already installed"
fi
# ---------------------------------------------------------------------------- #
# Download dotfiles https://github.com/peteroneilljr/.dotfiles.git
# ---------------------------------------------------------------------------- #
if [[ ! -d "$HOME/.dotfiles" ]];
then
  # Save current zshrc file if it exists
  git clone https://github.com/peteroneilljr/.dotfiles.git $HOME/ && \
  echo "Installed .dotfiles" || echo "Install failed"
else
  echo ".dotfiles already installed"
fi
# ---------------------------------------------------------------------------- #
# Backup old zshrc and create a symlink to new zshrc
# ---------------------------------------------------------------------------- #
if [[ -f "$HOME/.zshrc" ]] && [[ ! -L "$HOME/.zshrc" ]]; 
  then mv $HOME/.zshrc $HOME/.zshrc.backup && echo "created zshrc backup"; 
fi

if [[ -f "$HOME/.zshrc" ]] && [[ -L "$HOME/.zshrc" ]]; 
  then echo ".zshrc already linked"; 
  else ln -sv ~/.dotfiles/.zshrc $HOME;
fi
# ---------------------------------------------------------------------------- #
# Cleanup file ownership, change shell, and load zsh
# ---------------------------------------------------------------------------- #
chown -R $LOGNAME:$LOGNAME $HOME
chsh -s $(type -p zsh) $USER
zsh