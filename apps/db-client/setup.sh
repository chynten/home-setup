#!/bin/bash

. ../../VERSION.sh

read -p "CloudBeaver Config Directory: " CLOUDBEAVER_CONFIG_DIR
read -p "CloudBeaver domain name: " CLOUDBEAVER_DOMAIN


sudo mkdir -p $CLOUDBEAVER_CONFIG_DIR
sudo chmod 777 $CLOUDBEAVER_CONFIG_DIR

export CLOUDBEAVER_CONFIG_DIR=$CLOUDBEAVER_CONFIG_DIR
export CLOUDBEAVER_DOMAIN=$CLOUDBEAVER_DOMAIN

envsubst < mysql-Namespace.yaml | kubectl apply -f -