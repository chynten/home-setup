#!/bin/bash

. ../../VERSION.sh

kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/$CERT_BOT_VERSION/cert-manager.crds.yaml
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/$CERT_BOT_VERSION/cert-manager.yaml

read -p "Cloudflair API Token: " CLOUDFLARE_API_TOKEN
read -p "Cloudflair email: " CLOUDFLARE_EMAIL

export CLOUDFLARE_API_TOKEN=$CLOUDFLARE_API_TOKEN
export CLOUDFLARE_EMAIL=$CLOUDFLARE_EMAIL

envsubst < cloudflair-api-token-secret.yaml | kubectl apply -f -
envsubst < cluster-issuer.yaml | kubectl apply -f -