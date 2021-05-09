#!/bin/bash

. ../../VERSION.sh

kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/$CERT_BOT_VERSION/cert-manager.crds.yaml
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/$CERT_BOT_VERSION/cert-manager.yaml

read -p "Cloudflair API Key: " CLOUDFLARE_API_KEY
read -p "Cloudflair API Token: " CLOUDFLARE_API_TOKEN
read -p "Cloudflair email: " CLOUDFLARE_EMAIL

export CLOUDFLARE_API_KEY=`echo -n $CLOUDFLARE_API_KEY | base64 -w 0`
export CLOUDFLARE_API_TOKEN=`echo -n $CLOUDFLARE_API_TOKEN | base64 -w 0`
export CLOUDFLARE_EMAIL=$CLOUDFLARE_EMAIL

envsubst < cloudflair-api-key-secret.yaml | kubectl apply -f -
envsubst < cloudflair-api-token-secret.yaml | kubectl apply -f -
envsubst < cluster-issuer.yaml | kubectl apply -f -