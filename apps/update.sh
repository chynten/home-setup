#!/bin/bash

. ../../VERSION.sh

envsubst < mysql/mysql-StatefulSet.yaml | kubectl apply -f -

envsubst < db-client/loudBeaver-Deployment.yaml | kubectl apply -f -

envsubst < dns/adguard-deployment.yaml | kubectl apply -f -

envsubst < files/nextcloud-Deployment.yaml | kubectl apply -f -

envsubst < plex/plex-Deployment.yaml | kubectl apply -f -

envsubst < sso/keycloak-Deployment.yaml | kubectl apply -f -

envsubst < tautulli/tautulli-deployment.yaml | kubectl apply -f -

envsubst < timemachine/timemachine-deployment.yaml | kubectl apply -f -

envsubst < transmission/trans-deployment.yaml | kubectl apply -f -