#!/bin/bash

read -p "DataDog API Key: " datadog_api_key
read -p "Datadog mysql database password: " DATADOG_MYSQL_PASSWORD

export DATADOG_API_KEY=$datadog_api_key
export DATADOG_MYSQL_PASSWORD=$DATADOG_MYSQL_PASSWORD

helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update
kubectl create namespace datadog
kubectl label namespace datadog istio-injection=enabled
envsubst < datadog-values.yaml | helm upgrade datadog --install --namespace datadog --set datadog.site='datadoghq.eu' --set datadog.apiKey=$DATADOG_API_KEY datadog/datadog -f -

kubectl label namespaces datadog version=$(kubectl get daemonset datadog -n datadog -o go-template=$'{{index .metadata.labels "helm.sh/chart"}}')
kubectl label namespaces datadog component='monitoring'
kubectl label namespaces datadog hostNetwork='no'
kubectl label namespaces datadog internal-service='yes'
kubectl label namespaces datadog managed-by='chynten'
kubectl label namespaces datadog created-by='chynten'