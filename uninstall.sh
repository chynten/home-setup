sudo docker stop $(sudo docker ps -aq)
sudo docker rm $(sudo docker ps -a)

sudo docker rmi $(sudo docker images -a)

sudo rm -r infra/istio/tmp
sudo /usr/local/bin/k3s-uninstall.sh