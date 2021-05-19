#!/bin/bash
. ../../VERSION.sh

echo "---> setting up Keycloak"
read -p "Keycloak domain name: " KEYCLOAK_DOMAIN
read -p "Keycloak Admin password: " KEYCLOAK_PASSWORD
read -p "Keycloak Data dir: " KEYCLOAK_DATA_DIR

export KEYCLOAK_DOMAIN=$KEYCLOAK_DOMAIN
export KEYCLOAK_PASSWORD=`echo -n $KEYCLOAK_PASSWORD | base64 -w 0`
export KEYCLOAK_DATA_DIR=$KEYCLOAK_DATA_DIR

sudo mkdir -p $KEYCLOAK_DATA_DIR
sudo chmod 777 $KEYCLOAK_DATA_DIR

envsubst < keycloak-Namespace.yaml | kubectl apply -f -

envsubst < keycloak-Certificate.yaml | kubectl apply -f -
envsubst < keycloak-Gateway.yaml | kubectl apply -f -

envsubst < keycloak-Secret.yaml | kubectl apply -f -

envsubst < plex-PersistentVolume.yaml | kubectl apply -f -
envsubst < plex-PresistentVolumeClaim.yaml | kubectl apply -f -

envsubst < keycloak-Deployment.yaml | kubectl apply -f -

envsubst < keycloak-Service.yaml | kubectl apply -f -
envsubst < keycloak-VirtualService.yaml | kubectl apply -f -

