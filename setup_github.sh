#!/bin/bash

# Create a key for github
if [[ ! -z ~/.ssh/github ]];
then
  ssh-keygen -t rsa -b 4096 -C "peteroneilljr@gmail.com" -f $HOME/.ssh/github -P ""
  ssh-add -K $HOME/.ssh/github
  cat <<CONFIG_SETTINGS >> ~/.ssh/config
Host github.com
  HostName github.com
  User git
  AddKeysToAgent yes
  IdentityFile $HOME/.ssh/github
CONFIG_SETTINGS
  echo "add public key to GitHub"
  echo "pbcopy $HOME/.ssh/github.pub"
fi
