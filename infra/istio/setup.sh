#!/bin/bash

. ../../VERSION.sh

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

if ! [ -x "$(command -v tmp/istioctl)" ]; then
  echo "---> Downloading istio binaries..."
  wget -q https://github.com/istio/istio/releases/download/$ISTIO_VERSION/istioctl-$ISTIO_VERSION-linux-amd64.tar.gz -P tmp
  tar -xf tmp/istioctl-$ISTIO_VERSION-linux-amd64.tar.gz -C tmp/
fi
echo "---> setting up istio"
tmp/istioctl install -y -f infra/istio/operator.yaml

export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')

echo "---> Access it on: ${INGRESS_HOST} over http on ${INGRESS_PORT}, and https on ${SECURE_INGRESS_PORT}"