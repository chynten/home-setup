#!/bin/bash

. ../../VERSION.sh

read -p "Postgress Admin Password: " POSTGRES_PASSWORD
read -p "Postgres Data Dir: " POSTGRES_DATA_DIR

export POSTGRES_PASSWORD=`echo -n $POSTGRES_PASSWORD | base64 -w 0`
export POSTGRES_DATA_DIR=POSTGRES_DATA_DIR
sudo mkdir -p ${POSTGRES_DATA_DIR}

envsubst < postgres-Namespace.yaml | kubectl apply -f -

envsubst < postgres-PersistentVolume.yaml | kubectl apply -f -
envsubst < postgres-PersistentVolumeClaim.yaml | kubectl apply -f -

envsubst < postgres-Secret.yaml | kubectl apply -f -

envsubst < postgres-StatefulSet.yaml | kubectl apply -f -

envsubst < postgres-Service.yaml | kubectl apply -f -