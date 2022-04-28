# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="xiong-chiamiov"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
  aws
  fig
  gh
  git
  kubectl
  history
  macos
  sublime
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sublime
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gh
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fig
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history
# https://github.com/zsh-users/zsh-autosuggestions
# https://github.com/zsh-users/zsh-syntax-highlighting

source "$ZSH"/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# base aliases 
alias reload='source ~/.zshrc'
alias zshrc='vim ~/.zshrc'

# source Terraform commands
# source ./cmds_terraform.sh

# source Kubernetes commands
# source ./cmds_kube.sh

# # Skip forward/back a word with opt-arrow
bindkey -e
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word 

# cat eof
cateof() {
  # Creates a multiline file
  FILENAME=$1
  CONTENTS=$2
cat <<EOF > $FILENAME
$CONTENTS
EOF
}