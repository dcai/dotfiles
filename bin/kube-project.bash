#!/bin/bash

ME=$(basename "$0")

if [[ $# -lt 2 ]]; then
    echo "$ME {project_id} {cluster_name}"
    exit
fi

ACCOUNT=${1-"heydcai@gmail.com"}
PROJECT=${2-"foleo"}
GCP_ZONE=${3-"australia-southeast1-a"}
CLUSTER=$4
# WITH_CLUSTER_CREDENTIALS=${5-"no"}

# eval gcloud auth login "$ACCOUNT"
CMD="gcloud config set account $ACCOUNT"
echo "=> $CMD"
eval $CMD

CMD="gcloud config set compute/zone ${GCP_ZONE}"
echo "=> $CMD"
eval $CMD

CMD="gcloud config set project $PROJECT"
echo "=> $CMD"
eval $CMD
# if [[ $WITH_CLUSTER_CREDENTIALS != "no" ]]; then
# CMD="gcloud container clusters get-credentials $2"
# echo "=> $CMD"
# eval $CMD
# fi

if [[ ! -z "$CLUSTER" ]]; then

    CMD="gcloud container clusters get-credentials $CLUSTER"
    echo "=> $CMD"
    eval $CMD

    CMD="kubectl config use-context gke_${PROJECT}_${GCP_ZONE}_$CLUSTER"
    echo "$CMD"
    echo "=> $CMD"
    eval $CMD
fi

# CMD="gcloud compute project-info add-metadata --metadata google-compute-default-zone=${GCP_ZONE}"
# echo "=> $CMD"
# eval $CMD
