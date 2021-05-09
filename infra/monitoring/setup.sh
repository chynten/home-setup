#!/bin/bash

read -p "DataDog API Key: " datadog_api_key

export DATADOG_API_KEY=$datadog_api_key

helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm upgrade datadog --namespace monitoring --create-namespace -f datadog-values.yaml --set datadog.site='datadoghq.eu' --set datadog.apiKey=$DATADOG_API_KEY datadog/datadog 
