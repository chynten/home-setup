#!/bin/bash

. ../../VERSION.sh

read -p "Focalboard Domain: " FOCALBOARD_DOMAIN
read -p "Focalboard DB Password: " FOCALBOARD_PASSWORD

export FOCALBOARD_DOMAIN=$FOCALBOARD_DOMAIN
export FOCALBOARD_PASSWORD=$FOCALBOARD_PASSWORD

kubectl exec --stdin --tty postgres-statefulset-0 -n postgres -- psql -U postgres <<EOF
    CREATE DATABASE focalboard;
    CREATE USER focalboarduser WITH PASSWORD '${FOCALBOARD_PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE focalboard TO focalboarduser;
EOF

envsubst < focalboard-Namespace.yaml | kubectl apply -f -

envsubst < focalboard-Certificate.yaml | kubectl apply -f -
envsubst < focalboard-Gateway.yaml | kubectl apply -f -

envsubst < focalboard-ConfigMap.yaml | kubectl apply -f -

envsubst < focalboard-Deployment.yaml | kubectl apply -f -

envsubst < focalboard-Service.yaml | kubectl apply -f -
envsubst < focalboard-VirtualService.yaml | kubectl apply -f -