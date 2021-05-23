#!/bin/bash

. ../../VERSION.sh

read -p "Timemachine Config Directory: " TIMEMACHINE_CONFIG_DIR
read -p "Timemachine Data Directory: " TIMEMACHINE_DATA_DIR
read -p "Timemachine username: " USERNAME
read -p "Timemachine password: " PASSWORD

export TIMEMACHINE_CONFIG_DIR=$TIMEMACHINE_CONFIG_DIR
export TIMEMACHINE_DATA_DIR=$TIMEMACHINE_DATA_DIR
export USERNAME=`echo -n $USERNAME | base64 -w 0`
export PASSWORD=`echo -n $PASSWORD | base64 -w 0`

sudo mkdir -p $TIMEMACHINE_CONFIG_DIR
sudo cp -r avahi-config/* ${TIMEMACHINE_CONFIG_DIR}

envsubst <  timemachine-namespace.yaml | kubectl apply -f -

envsubst < timemachine-secret.yaml | kubectl apply -f -

envsubst < timemachine-PersistentVolume.yaml | kubectl apply -f -
envsubst < timemachine-PresistentVolumeClaim.yaml | kubectl apply -f -
envsubst < timemachine-deployment.yaml | kubectl apply -f -