#!/bin/bash
echo "---> stopping all conatainers"
sudo docker stop $(sudo docker ps -aq)
echo "---> removing all conatainers"
sudo docker rm $(sudo docker ps -aq)
echo "---> removing all conatainer images"
sudo docker rmi $(sudo docker images -aq)

echo "---> removing istio tmp folder"
sudo rm -r infra/istio/tmp
echo "---> uninstalling k3s"
sudo /usr/local/bin/k3s-uninstall.sh