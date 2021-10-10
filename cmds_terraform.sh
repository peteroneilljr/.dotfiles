# Terraform Aliases
alias tf='terraform'

alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfaarf='terraform apply -auto-approve -refresh=false'
alias tfarf='terraform apply -refresh=false'

alias tfsl='terraform state list'
alias tfslg='terraform state list | grep -i'
alias tfss='terraform state show'
alias tfsr='terraform state rm'

alias tfr='terraform refresh'
alias tfp='terraform plan'
alias tfi='terraform init'
alias tff='terraform fmt'
alias tffr='terraform fmt -recursive'
alias tfv='terraform validate'
alias tfver='terraform version'
alias tfg='terraform get -update && terraform init'

alias tft='terraform taint'
alias tfc='terraform console'
alias tfo='terraform output'
