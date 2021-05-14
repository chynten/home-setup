#!/bin/bash

. ../../VERSION.sh

read -p "Nextcloud Domain: " NEXTCLOUD_DOMAIN

read -p "Nextcloud config directory" NEXTCLOUD_CONFIG_DIR
read -p "Nextcloud data directory" NEXTCLOUD_DATA_DIR
read -p "Nextcloud database password" NEXTCLOUD_PASSWORD

export NEXTCLOUD_DOMAIN=$NEXTCLOUD_DOMAIN
export NEXTCLOUD_CONFIG_DIR=$NEXTCLOUD_CONFIG_DIR
export NEXTCLOUD_DATA_DIR=$NEXTCLOUD_DATA_DIR
export NEXTCLOUD_PASSWORD=$NEXTCLOUD_PASSWORD

sudo mkdir -p $NEXTCLOUD_DATA_DIR
sudo chmod 777 $NEXTCLOUD_DATA_DIR

sudo mkdir -p $NEXTCLOUD_CONFIG_DIR
sudo chmod 777 $NEXTCLOUD_CONFIG_DIR

envsubst < nextcloud-Namespace.yaml | kubectl apply -f -

kubectl run mysql-client --image=$MYSQL_IMAGE:$MYSQL_VERSION --namespace nextcloud -i --env="NEXTCLOUD_PASSWORD=${NEXTCLOUD_PASSWORD}" --rm --restart=Never --\
  mysql -h mysql-svc.mysql -u root -p$ROOT_PASSWORD <<EOF
    CREATE DATABASE IF NOT EXISTS nextcloud;
    CREATE USER IF NOT EXISTS 'nextcloud'@'%' IDENTIFIED WITH mysql_native_password by '${NEXTCLOUD_PASSWORD}';
    GRANT ALL privileges ON nextcloud.* TO 'nextcloud'@'%';
    FLUSH PRIVILEGES;
EOF

envsubst < nextcloud-Certificate.yaml | kubectl apply -f -
envsubst < nextcloud-Gateway.yaml | kubectl apply -f -

envsubst < nextcloud-PersistentVolumes.yaml | kubectl apply -f -
envsubst < nextcloud-PersistentVolumeClaims.yaml | kubectl apply -f -

envsubst < nextcloud-Deployment.yaml | kubectl apply -f -

envsubst < nextcloud-Service.yaml | kubectl apply -f -
envsubst < nextcloud-VirtualService.yaml | kubectl apply -f -