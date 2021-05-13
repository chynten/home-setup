#!/bin/bash

read -p "DataDog API Key: " datadog_api_key
read -p "Datadog mysql database password: " DATADOG_MYSQL_PASSWORD

export DATADOG_API_KEY=$datadog_api_key
export DATADOG_MYSQL_PASSWORD=$DATADOG_MYSQL_PASSWORD

helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update
kubectl create namespace monitoring
kubectl label namespace monitoring istio-injection=enabled
helm upgrade datadog --install --namespace monitoring -f datadog-values.yaml --set datadog.site='datadoghq.eu' --set datadog.apiKey=$DATADOG_API_KEY datadog/datadog 

kubectl label namespaces monitoring version=$(kubectl get daemonset datadog -n monitoring -o go-template=$'{{index .metadata.labels "helm.sh/chart"}}')
kubectl label namespaces monitoring component='monitoring'
kubectl label namespaces monitoring hostNetwork='no'
kubectl label namespaces monitoring internal-service='yes'
kubectl label namespaces monitoring managed-by='chynten'
kubectl label namespaces monitoring created-by='chynten'