#!/bin/bash

# Create a key for github
if [[ -z ~/.ssh/github ]];
then
  ssh-keygen -t rsa -b 4096 -C "peteroneilljr@gmail.com" -f $HOME/.ssh/github -P ""
  cat <<CONFIG_SETTINGS >> ~/.ssh/config
Host github.com
  HostName github.com
  User git
  AddKeysToAgent yes
  IdentityFile $HOME/.ssh/github
CONFIG_SETTINGS
fi