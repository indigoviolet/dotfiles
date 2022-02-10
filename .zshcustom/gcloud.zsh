export CLOUDSDK_PYTHON=python          # prevent it from looking for python2, python2.7

GCLOUD_INSTANCE='ml-west1-spot'
GCLOUD_ZONE='us-west1-b'
GCLOUD_PROJECT="private-229003"

## export for envsubst usage in mutagen project yml
export GCLOUD_HOST="${GCLOUD_INSTANCE}.${GCLOUD_ZONE}.${GCLOUD_PROJECT}"

function gcloud-curl() {
    curl --header "Authorization: Bearer $(gcloud auth print-access-token)" $*
}


alias gstart="gcloud compute instances start $GCLOUD_INSTANCE --zone $GCLOUD_ZONE"
alias gstop="gcloud compute instances stop $GCLOUD_INSTANCE --zone $GCLOUD_ZONE"
alias gssh="gcloud compute ssh $GCLOUD_INSTANCE --zone $GCLOUD_ZONE"
alias gdescribe="gcloud compute instances describe $GCLOUD_INSTANCE"
alias glist="gcloud compute instances list"
alias gstatus=glist
