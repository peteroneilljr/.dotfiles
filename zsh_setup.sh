#!/bin/bash

# Create a key for github
if [[ -z ~/.ssh/github ]];
then
  ssh-keygen -t rsa -b 4096 -C "peteroneilljr@gmail.com" -f $HOME/.ssh/github -P ""
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/github
fi

# install zsh
if ! command -V zsh; 
then 
  sudo apt install zsh -y
  # https://github.com/ohmyzsh/ohmyzsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # setup autocopmlete and hilighting
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

  # download .zshrc
  git clone https://github.com/peteroneilljr/.dotfiles.git ~

  # create symlink
  ln -sv ~/.dotfiles/.zshrc ~
fi


