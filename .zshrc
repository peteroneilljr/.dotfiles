# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ubuntu/.oh-my-zsh"

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
  git 
  gitignore
  ubuntu
  kubectl
  history
  zsh-autosuggestions
  zsh-syntax-highlighting
)
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ubuntu
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
# https://github.com/zsh-users/zsh-syntax-highlighting

source $ZSH/oh-my-zsh.sh

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
alias reload='source ~/.zshrc'

# Terraform Aliases
alias t13='curl -O https://releases.hashicorp.com/terraform/0.13.1/terraform_0.13.1_linux_amd64.zip && unzip terraform*.zip && rm terraform*.zip && sudo mv terraform /usr/local/bin/ || echo "Something went wrong"'
alias t12='curl -O https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip && unzip terraform_*.zip && rm terraform_*.zip && sudo mv terraform /usr/local/bin/ || echo "Something went wrong"'
alias tsdmlinux='[ -d ".terraform" ] && curl -J -O -L https://app.strongdm.com/downloads/terraform-provider/linux && unzip terraform-provider-sdm_v*.zip && rm terraform-provider-sdm_v*.zip && mv terraform-provider-sdm_v* .terraform/plugins/linux_amd64/ || echo "It looks like you are not in a terraform directory"'


alias t='terraform'
alias tver='terraform --version'

alias ta='terraform apply'
alias taaa='terraform apply -auto-approve'
alias taaarf='terraform apply -auto-approve -refresh=false'
alias tarf='terraform apply -refresh=false'

alias tsl='terraform state list'
alias tss='terraform state show'
alias tsr='terraform state rm'

alias tr='terraform refresh'
alias tp='terraform plan'
alias ti='terraform init'
alias tf='terraform fmt'
alias tfr='terraform fmt -recursive'
alias tv='terraform validate'
alias tg='terraform get -update && terraform init'

alias tt='terraform taint'
alias tc='terraform console'
alias to='terraform output'