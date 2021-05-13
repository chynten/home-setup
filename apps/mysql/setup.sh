#!/bin/bash

. ../../VERSION.sh

read -p "MySQL Config Directory: " MYSQL_CONFIG_DIR
read -p "MySQL Root Password: " ROOT_PASSWORD
read -p "Datadog database password: " DATADOG_MYSQL_PASSWORD

sudo mkdir -p $MYSQL_CONFIG_DIR
sudo chmod 777 $MYSQL_CONFIG_DIR

export ROOT_PASSWORD='echo -n $ROOT_PASSWORD | base64 -w 0'
export DATADOG_MYSQL_PASSWORD=$DATADOG_MYSQL_PASSWORD
export MYSQL_CONFIG_DIR=$MYSQL_CONFIG_DIR

envsubst < mysql-Namespace.yaml | kubectl apply -f -

envsubst < mysql-Secret.yaml | kubectl apply -f -
envsubst < mysql-ConfigMap.yaml | kubectl apply -f -

envsubst < mysql-PersistentVolume.yaml | kubectl apply -f -
envsubst < mysql-PersistentVolumeClaim.yaml | kubectl apply -f -

envsubst < mysql-Service.yaml | kubectl apply -f -
envsubst < mysql-StatefulSet.yaml | kubectl apply -f -