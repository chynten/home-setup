#!/bin/bash

. ../../VERSION.sh

read -p "Homebridge Domain: " HOMEBRIDGE_DOMAIN
read -p "Homebridge data directory: " HOMEBRIDGE_DATA_DIR

export HOMEBRIDGE_DOMAIN=$HOMEBRIDGE_DOMAIN
export HOMEBRIDGE_DATA_DIR=$HOMEBRIDGE_DATA_DIR

sudo mkdir -p $HOMEBRIDGE_DATA_DIR

envsubst < homebridge-namespace.yaml | kubectl apply -f -

envsubst < nextcloud-Certificate.yaml | kubectl apply -f -
envsubst < nextcloud-Gateway.yaml | kubectl apply -f -

envsubst < homebridge-PersistentVolume.yaml | kubectl apply -f -
envsubst < homebridge-PersistentVolumeClaim.yaml | kubectl apply -f -

envsubst < homebridge-deployment.yaml | kubectl apply -f -

envsubst < homebridge-service.yaml | kubectl apply -f -
envsubst < homebridge-VirtualService.yaml | kubectl apply -f -