#!/bin/bash

. ../../VERSION.sh

echo "---> setting up Tautulli"
read -p "Tautulli domain name: " TAUTULLI_DOMAIN
read -p "Tautulli config Dir: " TAUTULLI_CONFIG_DIR

sudo mkdir -p $TAUTULLI_CONFIG_DIR
sudo chmod 777 $TAUTULLI_CONFIG_DIR

envsubst < tautulli-Certificate.yaml | kubectl apply -f -
envsubst < tautulli-Gateway.yaml | kubectl apply -f -

envsubst < tautulli-PersistentVolume.yaml | kubectl apply -f -
envsubst < tautulli-PresistentVolumeClaim.yaml | kubectl apply -f -

envsubst < tautulli-deployment.yaml | kubectl apply -f -

envsubst < tautulli-service.yaml | kubectl apply -f -
envsubst < tautulli-VirtualService.yaml | kubectl apply -f -
