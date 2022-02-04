export CLOUDSDK_PYTHON=python          # prevent it from looking for python2, python2.7

GCLOUD_INSTANCE='ml-west1-spot'
GCLOUD_ZONE='us-west1-b'
GCLOUD_PROJECT="private-229003"

## export for envsubst usage in mutagen project yml
export GCLOUD_HOST="${GCLOUD_INSTANCE}.${GCLOUD_ZONE}.${GCLOUD_PROJECT}"

function gcloud-get-ip() {
    gcloud compute instances describe $1 --format='get(networkInterfaces[0].accessConfigs[0].natIP)' --zone $GCLOUD_ZONE
}

function gcloud-tunnel() {
    set -x
    instance=$1
    port=$2
    echo "Starting tunnel to $instance on port $port"
    autossh -f -M 0 -C -N -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" -o ExitOnForwardFailure=yes -L ${port}:localhost:${port} $(gcloud-get-ip $instance)
}

function gcloud-curl() {
    curl --header "Authorization: Bearer $(gcloud auth print-access-token)" $*
}


alias gstart="gcloud compute instances start $GCLOUD_INSTANCE --zone $GCLOUD_ZONE"
alias gstop="gcloud compute instances stop $GCLOUD_INSTANCE --zone $GCLOUD_ZONE"
alias gssh="gcloud compute ssh $GCLOUD_INSTANCE --zone $GCLOUD_ZONE"
alias gtunnel="gcloud-tunnel $GCLOUD_INSTANCE 8888"
alias glist="gcloud compute instances list"
alias gdescribe="gcloud compute instances describe $GCLOUD_INSTANCE"
