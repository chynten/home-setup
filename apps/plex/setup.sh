#!/bin/bash

. ../../VERSION.sh

read -p "Plex Domain: " PLEX_DOMAIN
read -p "Plex Config Directory: " PLEX_CONFIG_DIR
read -p "Plex Media Directory: " PLEX_MEDIA_DIR
read -p "Claim Refenrece (https://www.plex.tv/claim/): " PLEX_CLAIM_REF

export PLEX_DOMAIN=$PLEX_DOMAIN
export PLEX_CONFIG_DIR=$PLEX_CONFIG_DIR
export PLEX_MEDIA_DIR=$PLEX_MEDIA_DIR
export PLEX_CLAIM_REF=`echo -n $PLEX_CLAIM_REF | base64 -w 0`

sudo mkdir -p $PLEX_CONFIG_DIR
sudo chmod 777 $PLEX_CONFIG_DIR

sudo mkdir -p $PLEX_MEDIA_DIR
sudo chmod 777 $PLEX_MEDIA_DIR

envsubst < plex-Namespace.yaml | kubectl apply -f -

envsubst < plex-Gateway.yaml | kubectl apply -f -

envsubst < plex-Certificate.yaml | kubectl apply -f -

envsubst < plex-PersistentVolume.yaml | kubectl apply -f -
envsubst < plex-PresistentVolumeClaim.yaml | kubectl apply -f -

envsubst < plex-Secret.yaml | kubectl apply -f -

envsubst < plex-Deployment.yaml | kubectl apply -f -

envsubst < plex-Service.yaml | kubectl apply -f -
envsubst < plex-VirtualService.yaml | kubectl apply -f -