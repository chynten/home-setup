#!/bin/bash

. ../../VERSION.sh

read -p "Adguard config directory: " ADGUARD_CONFIG_DIR
read -p "Adguard data directory: " ADGUARD_DATA_DIR
read -p "Adguard domain: " ADGUARD_DOMAIN

export ADGUARD_DOMAIN=$ADGUARD_DOMAIN
export ADGUARD_CONFIG_DIR=$ADGUARD_CONFIG_DIR
export ADGUARD_DATA_DIR=$ADGUARD_DATA_DIR

sudo mkdir -p $ADGUARD_CONFIG_DIR
sudo mkdir -p $ADGUARD_DATA_DIR

envsubst < adguard-namespace.yaml | kubectl apply -f -

envsubst < adguard-PersistentVolume.yaml | kubectl apply -f -
envsubst < adguard-PersistentVolumeClaim.yaml | kubectl apply -f -

envsubst < adguard-deployment.yaml | kubectl apply -f -

envsubst < adguard-service.yaml | kubectl apply -f -
envsubst < adguard-VirtualService.yaml | kubectl apply -f -