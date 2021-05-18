#!/bin/bash

. ../../VERSION.sh

read -p "CloudBeaver Config Directory: " CLOUDBEAVER_CONFIG_DIR
read -p "CloudBeaver domain name: " CLOUDBEAVER_DOMAIN


sudo mkdir -p $CLOUDBEAVER_CONFIG_DIR
sudo chmod 777 $CLOUDBEAVER_CONFIG_DIR

export CLOUDBEAVER_CONFIG_DIR=$CLOUDBEAVER_CONFIG_DIR
export CLOUDBEAVER_DOMAIN=$CLOUDBEAVER_DOMAIN

envsubst < CloudBeaver-Certificate.yaml | kubectl apply -f -
envsubst < CloudBeaver-Gateway.yaml | kubectl apply -f -

envsubst < CloudBeaver-PersistentVolume.yaml | kubectl apply -f -
envsubst < CloudBeaver-PersistentVolumeClaim.yaml | kubectl apply -f -

envsubst < CloudBeaver-Deployment.yaml | kubectl apply -f -

envsubst < CloudBeaver-Service.yaml | kubectl apply -f -
envsubst < CloudBeaver-VirtualService.yaml | kubectl apply -f -