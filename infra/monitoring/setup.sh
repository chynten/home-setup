#!/bin/bash

read -p "DataDog API Key: " datadog_api_key

export DATADOG_API_KEY=$datadog_api_key

helm repo add stable https://charts.helm.sh/stable
helm repo update
helm install datadog --namespace datadog --create-namespace -f datadog-values.yaml --set datadog.site='datadoghq.eu' --set datadog.apiKey=$DATADOG_API_KEY datadog/datadog 