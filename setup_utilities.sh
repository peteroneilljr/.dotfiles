#!/bin/bash -xe

# ---------------------------------------------------------------------------- #
# Find package manager
# ---------------------------------------------------------------------------- #
if [[ -x "/usr/bin/apt-get" ]];
  then PCK_MGR="/usr/bin/apt-get"
elif [[ -x "/usr/bin/yum" ]];
  then PCK_MGR="/usr/bin/yum"
else echo "Not yum or apt exiting" 
fi
$PCK_MGR update -y

# ---------------------------------------------------------------------------- #
# Install utilities
# ---------------------------------------------------------------------------- #
if ! command -V unzip; 
then $PCK_MGR install -y unzip 
fi
# ---------------------------------------------------------------------------- #
# Install kubernetes
# ---------------------------------------------------------------------------- #
if ! command -V kubectl; 
then 
  curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x ./kubectl
  mv ./kubectl /usr/local/bin/kubectl
fi