#!/bin/bash

. ../../VERSION.sh

read -p "WikiJS Domain: " WIKIJS_DOMAIN
read -p "WikiJS Password: " WIKIJS_PASSWORD
read -p "MYSQL Root Password: " ROOT_PASSWORD

export WIKIJS_DOMAIN=$WIKIJS_DOMAIN
export WIKIJS_PASSWORD=$WIKIJS_PASSWORD

kubectl exec --stdin --tty mysql-statefuleset-0 -n mysql -- mysql -u root -p$ROOT_PASSWORD <<EOF
    CREATE DATABASE IF NOT EXISTS wikijs;
    CREATE USER IF NOT EXISTS 'wikijs'@'%' IDENTIFIED WITH mysql_native_password by '${WIKIJS_PASSWORD}';
    GRANT ALL privileges ON wikijs.* TO 'wikijs'@'%';
    FLUSH PRIVILEGES;
EOF

envsubst < wikijs-Namespace.yaml | kubectl apply -f -

envsubst < wikijs-Certificate.yaml | kubectl apply -f -
envsubst < wikijs-Gateway.yaml| kubectl apply -f -

envsubst < wikijs-ConfigMap.yaml | kubectl apply -f -

envsubst < wikijs-Deployment.yaml| kubectl apply -f -

envsubst < wikijs-Service.yaml | kubectl apply -f -
envsubst < wikijs-VirtualService.yaml | kubectl apply -f -