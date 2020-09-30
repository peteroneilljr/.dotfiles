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
  git 
  gitignore
  kubectl
  history
  zsh-autosuggestions
  zsh-syntax-highlighting
)

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

# Terraform Aliases
alias t13='curl -O https://releases.hashicorp.com/terraform/0.13.1/terraform_0.13.1_linux_amd64.zip && unzip terraform*.zip && rm terraform*.zip && sudo mv terraform /usr/local/bin/ || echo "Something went wrong"'
alias t12='curl -O https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip && unzip terraform_*.zip && rm terraform_*.zip && sudo mv terraform /usr/local/bin/ || echo "Something went wrong"'
alias tsdmlinux='[ -d ".terraform" ] && curl -J -O -L https://app.strongdm.com/downloads/terraform-provider/linux && unzip terraform-provider-sdm_v*.zip && rm terraform-provider-sdm_v*.zip && mv terraform-provider-sdm_v* .terraform/plugins/linux_amd64/ || echo "It looks like you are not in a terraform directory"'


alias t='terraform'

alias ta='terraform apply'
alias taaa='terraform apply -auto-approve'
alias taaarf='terraform apply -auto-approve -refresh=false'
alias tarf='terraform apply -refresh=false'

alias tsl='terraform state list'
alias tslg='terraform state list | grep -i'
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

# Kubectl alias
alias ketish='kubectl run busybox --image=busybox --rm -it --restart=Never -- /bin/sh'
alias ketiwget='kubectl run busybox --image=busybox --rm -it --restart=Never -- wget --timeout 2 -O-'

export dry='--dry-run=client'
export col_name='NAME:metadata.name'
export col_image='IMAGE:spec.containers[].image'
export col_annotation='ANNOTATIONS:metadata.annotations.description'
# Kube Liveness Probes
kube_explain_liveness() {
  kubectl explain pod.spec.containers.livenessProbe
}
kube_liveness_command() {
  # Add liveness exec command
  FILE=$1
  for i in "$@"
  do
    if [[ $i == "$FILE" ]]; then continue; fi
    yq w -i "$FILE" 'spec.containers[0].livenessProbe.exec.command[+]' "$i"
  done
}
kube_liveness_httpget() {
  # Add liveness httpget
  FILE=$1
  HTTPPATH=$2
  PORT=$3
  yq w -i "$FILE" 'spec.containers[0].livenessProbe.httpGet.path' "$HTTPPATH"
  yq w -i "$FILE" 'spec.containers[0].livenessProbe.httpGet.port' "$PORT"
}
kube_liveness_tcp() {
  # Add liveness tcp
  FILE=$1
  PORT=$2
  yq w -i "$FILE" 'spec.containers[0].livenessProbe.tcpSocket.port' "$PORT"
}
kube_liveness_seconds() {
  # Add liveness delay and period 
  FILE=$1
  DELAY=$2
  PERIOD=$3
  yq w -i "$FILE" 'spec.containers[0].livenessProbe.initialDelaySeconds' "$DELAY"
  yq w -i "$FILE" 'spec.containers[0].livenessProbe.periodSeconds' "$PERIOD"
}
# Kube Readiness Probes
kube_explain_readiness() {
  kubectl explain pod.spec.containers.readinessProbe
}
kube_readiness_command() {
  # Add readiness exec command
  FILE=$1
  for i in "$@"
  do
    if [[ $i == "$FILE" ]]; then continue; fi
    yq w -i "$FILE" --style=single 'spec.containers[0].readinessProbe.exec.command[+]' "$i"
  done
}
kube_readiness_httpget() {
  # Add readiness httpget
  FILE=$1
  HTTPPATH=$2
  PORT=$3
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.httpGet.path' "$HTTPPATH"
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.httpGet.port' "$PORT"
}
kube_readiness_tcp() {
  # Add readiness tcp
  FILE=$1
  PORT=$2
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.tcpSocket.port' "$PORT"
}
kube_readiness_seconds() {
  # Add readiness delay and period 
  FILE=$1
  DELAY=$2
  PERIOD=$3
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.initialDelaySeconds' "$DELAY"
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.periodSeconds' "$PERIOD"
}
# kube cronjobs
kube_cronjobs_seconds() {
  # Set the max number of seconds before terminating a job
  FILE=$1
  SECONDS=$2
  yq w -i "$FILE" 'spec.startingDeadlineSeconds' "$SECONDS"
}
# kube jobs
kube_jobs_seconds() {
  # Set the max number of seconds before terminating a job
  FILE=$1
  SECONDS=$2
  yq w -i "$FILE" 'spec.activeDeadlineSeconds' "$SECONDS"
}
kube_jobs_completions() {
  # Set the number of times this job should run
  FILE=$1
  NUM=$2
  yq w -i "$FILE" 'spec.completions' "$NUM"
}
kube_jobs_parallelism() {
  # Set the number of jobs that should run in parrallel
  FILE=$1
  NUM=$2
  yq w -i "$FILE" 'spec.parallelism' "$NUM"
}
# kube configmap
kube_cm_env_file() {
  # Loads configmap as environment variables into a pod
  FILE=$1
  CONFIGMAP=$2
  yq w -i "$FILE" 'spec.containers[0].envFrom[0].configMapRef.name' "$CONFIGMAP"
}
kube_cm_env_key() {
  # Creates a pod environment variable from a config map key
  FILE=$1 # YAML file to update
  CONFIGMAP=$2 # Name of the configmap
  KEY=$3 # Key reference in the configmap
  if [[ -z $4 ]]; then VARNAME="FILL THIS IN"; else VARNAME="$4"; fi
  yq w -i "$FILE" 'spec.containers[0].env[0].name' "$VARNAME"
  yq w -i "$FILE" 'spec.containers[0].env[0].valueFrom.configMapKeyRef.name' "$CONFIGMAP"
  yq w -i "$FILE" 'spec.containers[0].env[0].valueFrom.configMapKeyRef.key' "$KEY"
}
kube_cm_mount() {
  # Mounts a configmap as a volume
  FILE=$1
  CONFIGMAP=$2
  if [[ -z $3 ]]; then MOUNTPATH="FILL THIS IN"; else MOUNTPATH="$3"; fi
  MOUNTPATH=$3
  yq w -i "$FILE" 'spec.containers[0].volumeMounts[0].name' "$CONFIGMAP"
  yq w -i "$FILE" 'spec.containers[0].volumeMounts[0].mountPath' "$MOUNTPATH"
  yq w -i "$FILE" 'spec.volumes[0].name' "$CONFIGMAP"
  yq w -i "$FILE" 'spec.volumes[0].configMap.name' "$CONFIGMAP"
}
# Kube secrets
kube_secrets_mount() {
  # Mounts a secret as a volume
  FILE=$1
  SECRET=$2
  if [[ -z $3 ]]; then MOUNTPATH="FILL THIS IN"; else MOUNTPATH="$3"; fi
  MOUNTPATH=$3
  yq w -i "$FILE" 'spec.containers[0].volumeMounts[0].name' "$SECRET"
  yq w -i "$FILE" 'spec.containers[0].volumeMounts[0].mountPath' "$MOUNTPATH"
  yq w -i "$FILE" 'spec.containers[0].volumeMounts[0].readOnly' "true"
  yq w -i "$FILE" 'spec.volumes[0].name' "$SECRET"
  yq w -i "$FILE" 'spec.volumes[0].secret.secretName' "$SECRET"
}
kube_secrets_env_key() {
  # Creates a pod environment variable from a secret
  FILE=$1 # YAML file to update
  SECRET=$2 # Name of the secret
  KEY=$3 # Key to reference in the secret
  if [[ -z $4 ]]; then VARNAME="FILL THIS IN"; else VARNAME=$4; fi
  yq w -i "$FILE" 'spec.containers[0].env[0].name' "$VARNAME"
  yq w -i "$FILE" 'spec.containers[0].env[0].valueFrom.secretKeyRef.name' "$SECRET"
  yq w -i "$FILE" 'spec.containers[0].env[0].valueFrom.secretKeyRef.key' "$KEY"
}
# Kube Security Context
kube_security_capabilities() {
  # Add security capabilities to container
  FILE=$1
  for i in "$@"
  do
    if [[ $i == "$FILE" ]]; then continue; fi
    yq w -i "$FILE" --style=single 'spec.containers[0].securityContext.capabilities.add[+]' "$i"
  done
}
kube_security_userid() {
  # Add User ID to container
  FILE=$1
  USERID=$2
  yq w -i "$FILE" 'spec.securityContext.runAsUser' "$USERID"
}
kube_security_groupid() {
  # Add Group ID to container
  FILE=$1
  GROUPID=$2
  yq w -i "$FILE" 'spec.securityContext.runAsGroup' "$GROUPID"
}
# Kube install
kube_install_metrics() {
  kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.7/components.yaml
}
kube_install_metrics_insecure() {
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.7/components.yaml
k -n kube-system get deploy metrics-server -oyaml | \
	yq write -- - 'spec.template.spec.containers[0].args[+]' '--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname' | \
	yq write -- - 'spec.template.spec.containers[0].args[+]' '--kubelet-insecure-tls' | \
	kubectl apply -f -
}
# Kube networkPolicy
kube_network_policy_create() {
  # Creates a network policy
  FILE=$1
  NAME=$2
  if [[ -z $3 ]]; then NAMESPACE="default"; else NAMESPACE=$3; fi
  if [[ ! -f $FILE ]]; then touch $FILE; fi
  yq w -i "$FILE" 'apiVersion' "networking.k8s.io/v1"
  yq w -i "$FILE" 'kind' "NetworkPolicy"
  yq w -i "$FILE" 'metadata.name' "$NAME"
  yq w -i "$FILE" 'metadata.namespace' "$NAMESPACE"
  yq w -i "$FILE" 'spec.podSelector.matchLabels.app' "$NAME"
}
kube_network_policy_add_ingress() {
  # Add generic ingress template 
  FILE=$1
  NAME=$2
  if [[ -z $NAME ]]; then NAME="NONAME"; fi
  if [[ ! -f $FILE ]]; then kube_network_policy_create $FILE $NAME; fi
  yq w -i "$FILE" 'spec.policyTypes[+]' "Ingress"
  yq w -i "$FILE" 'spec.ingress[0].from[0].podSelector.matchLabels.app' "$NAME"
  yq w -i "$FILE" 'spec.ingress[0].from[1].namespaceSelector.matchLabels.app' "$NAME"
  yq w -i "$FILE" 'spec.ingress[0].from[2].ipBlock.cidr' "172.17.0.0/16"
  yq w -i "$FILE" 'spec.ingress[0].from[2].ipBlock.except[0]' "172.17.1.0/24"
  yq w -i "$FILE" 'spec.ingress[0].ports[0].protocol' "TCP"
  yq w -i "$FILE" 'spec.ingress[0].ports[0].port' "8080"
}
kube_network_policy_add_egress() {
  # Add generic egress template 
  FILE=$1
  NAME=$2
  if [[ ! -f $FILE ]]; then kube_network_policy_create $FILE $NAME; fi
  yq w -i "$FILE" 'spec.policyTypes[+]' "Egress"
  yq w -i "$FILE" 'spec.egress[0].to[0].ipBlock.cidr' "0.0.0.0/0"
  yq w -i "$FILE" 'spec.egress[0].to[0].ipBlock.except[0]' "10.0.0.0/24"
  yq w -i "$FILE" 'spec.egress[0].ports[0].protocol' "TCP"
  yq w -i "$FILE" 'spec.egress[0].ports[0].port' "8080"
}
# Containers
kube_pod_add_container() {
  # Add generic egress template 
  FILE=$1
  NAME=$2
  IMAGE=$3
  COMMAND=$4
  yq w -i "$FILE" 'spec.containers[1].name' "$NAME"
  yq w -i "$FILE" 'spec.containers[1].image' "$IMAGE"
  yq w -i "$FILE" 'spec.containers[1].command[0]' "/bin/sh"
  yq w -i "$FILE" 'spec.containers[1].command[1]' -- "-c"
  yq w -i "$FILE" --style=single 'spec.containers[1].command[2]' "$COMMAND"
}
# Volumes
kube_volume_create() {
  # Creates a volume
  FILE=$1
  NAME=$2
  yq w -i "$FILE" 'spec.volumes[0].name' "$NAME"
  yq w -i "$FILE" 'spec.volumes[0].emptyDir' ''
}
kube_volume_mount() {
  # Mounts a volume to a container
  FILE=$1
  NAME=$2
  MOUNTPATH=$3
  CONTAINER=$4
  if [[ -z $CONTAINER ]]; then CONTAINER="0"; fi
  yq w -i "$FILE" "spec.containers[$CONTAINER].volumeMounts[0].name" "$NAME"
  yq w -i "$FILE" "spec.containers[$CONTAINER].volumeMounts[0].mountPath" "$MOUNTPATH"
}
# Kube PersistentVolumes
kube_pv_create() {
  # Creates a persistent colume yaml spec
  FILE=$1
  NAME=$2
  STORAGECLASS=$3
  CAPACITY=$4
  ACCESSMODE=$5
  MOUNTPATH=$6
  if [[ ! -f $FILE ]]; then touch $FILE; fi
  if [[ -z $STORAGECLASS ]]; then STORAGECLASS="normal"; fi
  if [[ -z $CAPACITY ]]; then CAPACITY="10GI"; fi
  if [[ -z $ACCESSMODE ]]; then ACCESSMODE="ReadWriteOnce"; fi
  if [[ -z $MOUNTPATH ]]; then MOUNTPATH="/mnt/data"; fi
  yq w -i "$FILE" 'apiVersion' "v1"
  yq w -i "$FILE" 'kind' "PersistentVolume"
  yq w -i "$FILE" 'metadata.name' "$NAME"
  yq w -i "$FILE" 'metadata.labels.type' "local"
  yq w -i "$FILE" 'spec.storageClassName' "$STORAGECLASS"
  yq w -i "$FILE" 'spec.capacity.storage' "$CAPACITY"
  yq w -i "$FILE" 'spec.accessModes[0]' "$ACCESSMODE"
  yq w -i "$FILE" 'spec.hostPath.path' "$MOUNTPATH"
}
kube_pvc_create() {
  # Creates a persistent colume yaml spec
  FILE=$1
  NAME=$2
  STORAGECLASS=$3
  ACCESSMODE=$4
  REQUEST=$6
  if [[ ! -f $FILE ]]; then touch $FILE; fi
  if [[ -z $STORAGECLASS ]]; then STORAGECLASS="normal"; fi
  if [[ -z $ACCESSMODE ]]; then ACCESSMODE="ReadWriteOnce"; fi
  if [[ -z $REQUEST ]]; then REQUEST="3Gi"; fi
  yq w -i "$FILE" 'apiVersion' "v1"
  yq w -i "$FILE" 'kind' "PersistentVolumeClaim"
  yq w -i "$FILE" 'metadata.name' "$NAME"
  yq w -i "$FILE" 'spec.storageClassName' "$STORAGECLASS"
  yq w -i "$FILE" 'spec.accessModes[0]' "$ACCESSMODE"
  yq w -i "$FILE" 'spec.resources.requests.storage' "$REQUEST"
}
kube_pvc_mount() {
  # Mounts pvc to pod yaml
  FILE=$1
  NAME=$2
  yq w -i "$FILE" 'spec.volumes[0].name' "$NAME"
  yq w -i "$FILE" 'spec.volumes[0].persistentVolumeClaim.claimName' "$NAME"
}
