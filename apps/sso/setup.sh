#!/bin/bash
. ../../VERSION.sh

echo "---> setting up Keycloak"
read -p "Keycloak domain name: " KEYCLOAK_DOMAIN
read -p "keycloak database Password: " KEYCLOAK_DB_PASSWORD
read -p "Keycloak Admin password: " KEYCLOAK_PASSWORD

export KEYCLOAK_DOMAIN=$KEYCLOAK_DOMAIN
export KEYCLOAK_DB_PASSWORD=`echo -n $KEYCLOAK_DB_PASSWORD | base64 -w 0`
export KEYCLOAK_PASSWORD=`echo -n $KEYCLOAK_PASSWORD | base64 -w 0`

kubectl exec --stdin --tty mysql-statefuleset-0 -n mysql -- mysql -u root -p$ROOT_PASSWORD <<EOF
    CREATE DATABASE IF NOT EXISTS keycloak;
    CREATE USER IF NOT EXISTS 'keycloak'@'%' IDENTIFIED WITH mysql_native_password by '${$KEYCLOAK_DB_PASSWORD}';
    GRANT ALL privileges ON keycloak.* TO 'keycloak'@'%';
    FLUSH PRIVILEGES;
EOF

envsubst < keycloak-Namespace.yaml | kubectl apply -f -

envsubst < keycloak-Certificate.yaml | kubectl apply -f -
envsubst < keycloak-Gateway.yaml | kubectl apply -f -

envsubst < keycloak-Secret.yaml | kubectl apply -f -

envsubst < keycloak-Deployment.yaml | kubectl apply -f -

envsubst < keycloak-Service.yaml | kubectl apply -f -
envsubst < keycloak-VirtualService.yaml | kubectl apply -f -

