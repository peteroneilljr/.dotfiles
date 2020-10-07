

source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
alias k=kubectl
complete -F __start_kubectl k


# Execute a kubectl command against all namespaces
alias kca='_kca(){ kubectl "$@" --all-namespaces;  unset -f _kca; }; _kca'

# Apply a YML file
alias kaf='kubectl apply -f'

# Drop into an interactive terminal on a container
alias keti='kubectl exec -ti'

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='kubectl config use-context'
alias kcsc='kubectl config set-context'
alias kcdc='kubectl config delete-context'
alias kccc='kubectl config current-context'

# List all contexts
alias kcgc='kubectl config get-contexts'

# General aliases
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'

# Pod management.
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kgpw='kgp --watch'
alias kgpwide='kgp -o wide'
alias kep='kubectl edit pods'
alias kdp='kubectl describe pods'
alias kdelp='kubectl delete pods'

# get pod by label: kgpl "app=myapp" -n myns
alias kgpl='kgp -l'

# get pod by namespace: kgpn kube-system"
alias kgpn='kgp -n'

# Service management.
alias kgs='kubectl get svc'
alias kgsa='kubectl get svc --all-namespaces'
alias kgsw='kgs --watch'
alias kgswide='kgs -o wide'
alias kes='kubectl edit svc'
alias kds='kubectl describe svc'
alias kdels='kubectl delete svc'

# Ingress management
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress --all-namespaces'
alias kei='kubectl edit ingress'
alias kdi='kubectl describe ingress'
alias kdeli='kubectl delete ingress'

# Namespace management
alias kgns='kubectl get namespaces'
alias kens='kubectl edit namespace'
alias kdns='kubectl describe namespace'
alias kdelns='kubectl delete namespace'
alias kcn='kubectl config set-context $(kubectl config current-context) --namespace'

# ConfigMap management
alias kgcm='kubectl get configmaps'
alias kgcma='kubectl get configmaps --all-namespaces'
alias kecm='kubectl edit configmap'
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'

# Secret management
alias kgsec='kubectl get secret'
alias kgseca='kubectl get secret --all-namespaces'
alias kdsec='kubectl describe secret'
alias kdelsec='kubectl delete secret'

# Deployment management.
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias kgdw='kgd --watch'
alias kgdwide='kgd -o wide'
alias ked='kubectl edit deployment'
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ksd='kubectl scale deployment'
alias krsd='kubectl rollout status deployment'
kres(){
    kubectl set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S)
}

# Rollout management.
alias kgrs='kubectl get rs'
alias krh='kubectl rollout history'
alias kru='kubectl rollout undo'

# Statefulset management.
alias kgss='kubectl get statefulset'
alias kgssa='kubectl get statefulset --all-namespaces'
alias kgssw='kgss --watch'
alias kgsswide='kgss -o wide'
alias kess='kubectl edit statefulset'
alias kdss='kubectl describe statefulset'
alias kdelss='kubectl delete statefulset'
alias ksss='kubectl scale statefulset'
alias krsss='kubectl rollout status statefulset'

# Port forwarding
alias kpf="kubectl port-forward"

# Tools for accessing all information
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'

# Logs
alias kl='kubectl logs'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klf='kubectl logs -f'
alias klf1h='kubectl logs --since 1h -f'
alias klf1m='kubectl logs --since 1m -f'
alias klf1s='kubectl logs --since 1s -f'

# File copy
alias kcp='kubectl cp'

# Node Management
alias kgno='kubectl get nodes'
alias keno='kubectl edit node'
alias kdno='kubectl describe node'
alias kdelno='kubectl delete node'

# PVC management.
alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc --all-namespaces'
alias kgpvcw='kgpvc --watch'
alias kepvc='kubectl edit pvc'
alias kdpvc='kubectl describe pvc'
alias kdelpvc='kubectl delete pvc'


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
  if [[ -z $HTTPPATH ]]; then HTTPPATH="/healtz"; fi
  if [[ -z $PORT ]]; then PORT="80"; fi
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
  if [[ -z $DELAY ]]; then DELAY="5"; fi
  if [[ -z $PERIOD ]]; then PERIOD="5"; fi
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
  if [[ -z $HTTPPATH ]]; then HTTPPATH="/healtz"; fi
  if [[ -z $PORT ]]; then PORT="80"; fi
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.httpGet.path' "$HTTPPATH"
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.httpGet.port' "$PORT"
}
kube_readiness_tcp() {
  # Add readiness tcp
  FILE=$1
  PORT=$2
  if [[ -z $PORT ]]; then PORT="80"; fi
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.tcpSocket.port' "$PORT"
}
kube_readiness_seconds() {
  # Add readiness delay and period 
  FILE=$1
  DELAY=$2
  PERIOD=$3
  if [[ -z $DELAY ]]; then DELAY="5"; fi
  if [[ -z $PERIOD ]]; then PERIOD="5"; fi
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.initialDelaySeconds' "$DELAY"
  yq w -i "$FILE" 'spec.containers[0].readinessProbe.periodSeconds' "$PERIOD"
}
# kube cronjobs
kube_cronjobs_seconds() {
  # Set the max number of seconds before terminating a job
  FILE=$1
  SECONDS=$2
  if [[ -z $SECONDS ]]; then SECONDS="30"; fi
  yq w -i "$FILE" 'spec.startingDeadlineSeconds' "$SECONDS"
}
# kube jobs
kube_jobs_seconds() {
  # Set the max number of seconds before terminating a job
  FILE=$1
  SECONDS=$2
  if [[ -z $SECONDS ]]; then SECONDS="30"; fi
  yq w -i "$FILE" 'spec.activeDeadlineSeconds' "$SECONDS"
}
kube_jobs_completions() {
  # Set the number of times this job should run
  FILE=$1
  NUM=$2
  if [[ -z $NUM ]]; then NUM="5"; fi
  yq w -i "$FILE" 'spec.completions' "$NUM"
}
kube_jobs_parallelism() {
  # Set the number of jobs that should run in parrallel
  FILE=$1
  NUM=$2
  if [[ -z $NUM ]]; then NUM="5"; fi
  yq w -i "$FILE" 'spec.parallelism' "$NUM"
}
# kube configmap
kube_cm_env_file() {
  # Loads configmap as environment variables into a pod
  FILE=$1
  CONFIGMAP=$2
  if [[ -z $CONFIGMAP ]]; then CONFIGMAP="THISCM"; fi
  yq w -i "$FILE" 'spec.containers[0].envFrom[0].configMapRef.name' "$CONFIGMAP"
}
kube_cm_env_key() {
  # Creates a pod environment variable from a config map key
  FILE=$1 # YAML file to update
  CONFIGMAP=$2 # Name of the configmap
  KEY=$3 # Key reference in the configmap
  VARNAME="$4"
  if [[ -z $CONFIGMAP ]]; then CONFIGMAP="THISCM"; fi
  if [[ -z $KEY ]]; then KEY="THISKEY"; fi
  if [[ -z $VARNAME ]]; then VARNAME="THISVAR"; fi
  yq w -i "$FILE" 'spec.containers[0].env[0].name' "$VARNAME"
  yq w -i "$FILE" 'spec.containers[0].env[0].valueFrom.configMapKeyRef.name' "$CONFIGMAP"
  yq w -i "$FILE" 'spec.containers[0].env[0].valueFrom.configMapKeyRef.key' "$KEY"
}
kube_cm_mount() {
  # Mounts a configmap as a volume
  FILE=$1
  CONFIGMAP=$2
  MOUNTPATH=$3
  if [[ -z $CONFIGMAP ]]; then CONFIGMAP="CMNAME"; fi
  if [[ -z $MOUNTPATH ]]; then MOUNTPATH="/mnt/data"; fi
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
  MOUNTPATH=$3
  if [[ -z $SECRET ]]; then SECRET="SECNAME"; fi
  if [[ -z $MOUNTPATH ]]; then MOUNTPATH="/mnt/data"; fi
  yq w -i "$FILE" 'spec.containers[0].volumeMounts[0].name' "$SECRET"
  yq w -i "$FILE" 'spec.containers[0].volumeMounts[0].mountPath' "$MOUNTPATH"
  yq w -i "$FILE" 'spec.containers[0].volumeMounts[0].readOnly' "true"
  yq w -i "$FILE" 'spec.volumes[0].name' "$SECRET"
  yq w -i "$FILE" 'spec.volumes[0].secret.secretName' "$SECRET"
}
kube_secrets_env_key() {
  # Creates a pod environment variable from a secret
  FILE=$1
  SECRET=$2
  KEY=$3
  if [[ -z $SECRET ]]; then SECRET="SECNAME"; fi
  if [[ -z $KEY ]]; then KEY="REF"; fi
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
  # Add User ID to pod
  FILE=$1
  USERID=$2
  if [[ -z $USERID ]]; then USERID="1001"; fi
  yq w -i "$FILE" 'spec.securityContext.runAsUser' "$USERID"
}
kube_security_groupid() {
  # Add Group ID to pod
  FILE=$1
  GROUPID=$2
  if [[ -z $GROUPID ]]; then GROUPID="1001"; fi
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
  NAMESPACE=$3
  if [[ ! -f $FILE ]]; then touch $FILE; fi
  if [[ -z $NAMESPACE ]]; then NAMESPACE="default"; fi
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
  if [[ -z $IMAGE ]]; then IMAGE="busybox"; fi
  if [[ -z $COMMAND ]]; then COMMAND="sleep 36000"; fi
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
  if [[ -z $MOUNTPATH ]]; then MOUNTPATH="/mnt/data"; fi
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
