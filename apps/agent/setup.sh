#!/bin/bash

. ../../VERSION.sh

read -p "Gmail SMTP Password: " SMTP_PASSWORD

export GMAIL_SMTP_PASSWORD=`echo -n $SMTP_PASSWORD | base64 -w 0`

envsubst < huginn-namespace.yaml | kubectl apply -f -

envsubst < huginn-Certificate.yaml | kubectl apply -f -
envsubst < huginn-Gateway.yaml | kubectl apply -f -

envsubst < huginn-secret.yaml | kubectl apply -f -

envsubst < huginn-deployment.yaml | kubectl apply -f -

envsubst < huginn-service.yaml | kubectl apply -f -
envsubst < huginn-VirtualService.yaml | kubectl apply -f -
