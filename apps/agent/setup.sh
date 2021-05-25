#!/bin/bash

. ../../VERSION.sh

read -p "Huginn Domain: " HUGINN_DOMAIN
read -p "MySQL Root Password: " ROOT_PASSWORD
read -p "Huginn DB Password: " HUGINN_DB_PASSWORD
read -p "Huginn data dir: " HUGINN_DATA_DIR
read -p "Gmail email: " GMAIL_EMAIL
read -p "Gmail SMTP Password: " SMTP_PASSWORD

kubectl exec --stdin --tty mysql-statefuleset-0 -n mysql -- mysql -u root -p$ROOT_PASSWORD <<EOF
    CREATE DATABASE IF NOT EXISTS huginn;
    CREATE USER IF NOT EXISTS 'huginn'@'%' IDENTIFIED WITH mysql_native_password by '${HUGINN_DB_PASSWORD}';
    GRANT ALL privileges ON huginn.* TO 'huginn'@'%';
    FLUSH PRIVILEGES;
EOF

export HUGINN_DATA_DIR=$HUGINN_DATA_DIR
export HUGINN_DOMAIN=$HUGINN_DOMAIN
export HUGINN_DB_PASSWORD=`echo -n $HUGINN_DB_PASSWORD | base64 -w 0`
export GMAIL_EMAIL=`echo -n $GMAIL_EMAIL | base64 -w 0`
export GMAIL_SMTP_PASSWORD=`echo -n $SMTP_PASSWORD | base64 -w 0`


envsubst < huginn-namespace.yaml | kubectl apply -f -

envsubst < huginn-Certificate.yaml | kubectl apply -f -
envsubst < huginn-Gateway.yaml | kubectl apply -f -

envsubst < huginn-PersistentVolumes.yaml | kubectl apply -f -
envsubst < huginn-PersistentVolumeClaims.yaml | kubectl apply -f -

envsubst < huginn-secret.yaml | kubectl apply -f -

envsubst < huginn-deployment.yaml | kubectl apply -f -

envsubst < huginn-service.yaml | kubectl apply -f -
envsubst < huginn-VirtualService.yaml | kubectl apply -f -
