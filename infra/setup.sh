#!/bin/bash

. ../VERSION.sh
echo "---> Home setup"

if ! [ -x "$(command -v docker)" ]; then
	echo "---> Docker Setup"
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt-get update

	sudo apt-get install -y docker-ce docker-ce-cli containerd.io
fi

if ! [ -x "$(command -v k3s)" ]; then
  echo "---> Setting up Kubernetes"
  curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --docker --disable traefik,local-storage,metrics-server
  export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
fi

if ! [ -x "$(command -v kubectl)" ]; then
	echo "---> Installing kubectl"
	curl -LO "https://dl.k8s.io/release/$K3S_VERSION/bin/linux/amd64/kubectl"
fi

if ! [ -x "$(command -v helm)" ]; then
	echo "---> Installation helm"
	curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
  sudo apt-get install apt-transport-https --yes
  echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  sudo apt-get update
  sudo apt-get install -y helm
fi

until kubectl get nodes
do
  echo "---> Trying again to get nodes..."
done

if ! [ $(kubectl get ns istio-system -o jsonpath --template={.status.phase}) = 'Active' ];
then
	cd ./istio
	sh ./setup.sh
	cd ..
fi

cd ./monitoring
sh ./setup.sh
cd ..

if [ -z $(kubectl get storageclass local-storage-class -o jsonpath --template={.metadata.uid}) ];
then
	cd ./storage
	sh ./setup.sh
	cd ..
fi

if ! [ $(kubectl get ns cert-manager -o jsonpath --template={.status.phase}) = 'Active' ];
then
	cd ./certificate
	sh ./setup.sh
	cd ..
fi