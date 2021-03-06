#!/bin/bash

. ../../VERSION.sh

echo "---> setting up wordpress"

read -p "MySQL root password: " ROOT_PASSWORD
read -p "Wordpress DB Password: " DB_PASSWORD
read -p "Wordpress Data Dir: " WORDPRESS_DATA_DIR
read -p "Wordpress domain name: " WORDPRESS_DOMAIN

kubectl exec --stdin --tty mysql-statefuleset-0 -n mysql -- mysql -u root -p$ROOT_PASSWORD <<EOF
    CREATE DATABASE IF NOT EXISTS wordpress;
    CREATE USER IF NOT EXISTS 'wordpress'@'%' IDENTIFIED WITH mysql_native_password by '${DB_PASSWORD}';
    GRANT ALL privileges ON wordpress.* TO 'wordpress'@'%';
    FLUSH PRIVILEGES;
EOF

sudo mkdir -p $WORDPRESS_DATA_DIR

export WORDPRESS_DATA_DIR=$WORDPRESS_DATA_DIR
export WORDPRESS_DOMAIN=$WORDPRESS_DOMAIN
export WORDPRESS_DB_PASSWORD=`echo -n $DB_PASSWORD | base64 -w 0`

envsubst < wordpress-namespace.yaml | kubectl apply -f -

envsubst < wordpress-Certificate.yaml | kubectl apply -f -
envsubst < wordpress-Gateway.yaml | kubectl apply -f -

envsubst < wordpress-PersistentVolume.yaml | kubectl apply -f -
envsubst < wordpress-PersistentVolumeClaim.yaml | kubectl apply -f -

envsubst < wordpress-secret.yaml | kubectl apply -f -

envsubst < wordpress-deployment.yaml | kubectl apply -f -

envsubst < wordpress-service.yaml | kubectl apply -f -
envsubst < wordpress-virtualservice.yaml | kubectl apply -f -