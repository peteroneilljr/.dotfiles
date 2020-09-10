#!/bin/bash -xe

# install zsh
if ! command -V zsh; 
then 
  sudo apt install zsh -y
fi

if [[ "$ZSH" != "*/.oh-my-zsh" ]];
then
  # https://github.com/ohmyzsh/ohmyzsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
  echo "Installed oh-my-zsh" || echo "Install failed"
fi

if [[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]];
then
  # Install zsh-autosuggestions plugin
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions && \
  echo "Installed zsh-autosuggestions" || echo "Install failed"
fi

if [[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]];
then
  # Install zsh-syntax-highlighting plugin
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting && \
  echo "Installed zsh-syntax-highlighting" || echo "Install failed"
fi

if [[ -d "$HOME/plugins/.dotfiles" ]];
then
  # download .zshrc
  git clone https://github.com/peteroneilljr/.dotfiles.git ~ && \
  ln -sv ~/.dotfiles/.zshrc ~ && \
  echo "Installed .dotfiles" || echo "Install failed"
fi
