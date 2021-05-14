#!/bin/bash

. ../../VERSION.sh

echo "---> setting up Transmission"
read -p "Transmission domain name: " TRANSMISSION_DOMAIN
read -p "Transmission Admin Username: " username
read -p "Transmission Admin Password: " password
read -p "Transmission config Dir: " TRANSMISSION_CONF_DIR
read -p "Transmission data Dir: " TRANSMISSION_DATA_DIR

sudo mkdir -p ${TRANSMISSION_CONF_DIR}
sudo chmod 777 ${TRANSMISSION_CONF_DIR}
sudo mkdir -p ${TRANSMISSION_DATA_DIR}
sudo chmod 777 ${TRANSMISSION_DATA_DIR}

export TRANSMISSION_DOMAIN=$TRANSMISSION_DOMAIN
export TRANSMISSION_CONF_DIR=$TRANSMISSION_CONF_DIR
export TRANSMISSION_DATA_DIR=$TRANSMISSION_DATA_DIR
export TRANSMISSION_USER_NAME=`echo -n $username | base64 -w 0`
export TRANSMISSION_PASSWORD=`echo -n $password | base64 -w 0`

envsubst < trans-namespace.yaml | kubectl apply -f -

envsubst < trans-Certificate.yaml | kubectl apply -f -
envsubst < trans-Gateway.yaml | kubectl apply -f -

envsubst < trans-PersistentVolume.yaml | kubectl apply -f -
envsubst < trans-PersistentVolumeClaim.yaml | kubectl apply -f -

envsubst < trans-configmap.yaml | kubectl apply -f -
envsubst < trans-secret.yaml | kubectl apply -f -

envsubst < trans-deployment.yaml | kubectl apply -f -

envsubst < trans-service.yaml | kubectl apply -f -
envsubst < trans-VirtualService.yaml | kubectl apply -f -