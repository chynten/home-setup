#!/bin/bash

read -p "Node Name (If multiple, then give node name which has local storage):" NODE_NAME
export NODE_NAME=$NODE_NAME

read -p "Do you wish to install plex (y/n)?" yn

case $yn in
    y )
        cd plex
        sh ./setup.sh
        cd ..
        ;;
esac

read -p "Do you wish to install tautulli (y/n)?" yn

case $yn in
    y )
        cd tautulli
        sh ./setup.sh
        cd ..
        ;;
esac

echo "Installing MySQL..."
cd mysql
sh ./setup.sh
cd ..
cd db-client
sh ./setup.sh
cd ..

read -p "Do you wish to install nextcloud (y/n)?" yn

case $yn in
    y )
        if ! [ $(kubectl get ns mysql -o jsonpath --template={.status.phase}) = 'Active' ];
        then
            cd mysql
            sh ./setup.sh
            cd ..
            cd db-client
            sh ./setup.sh
            cd ..
        fi
        cd files
        sh ./setup.sh
        cd ..
        ;;
esac

read -p "Do you wish to install transmission (y/n)?" yn
case $yn in
    y )
        cd transmission
        sh ./setup.sh
        cd ..
        ;;
esac

read -p "Do you wish to install keycloak (y/n)?" yn
case $yn in
    y )
        cd sso
        sh ./setup.sh
        cd ..
        ;;
esac

read -p "Do you wish to install timemachine (y/n)?" yn
case $yn in
    y )
        cd timemachine
        sh ./setup.sh
        cd ..
        ;;
esac

read -p "Do you wish to install wordpress (y/n)?" yn
case $yn in
    y )
        cd blog
        sh ./setup.sh
        cd ..
        ;;
esac

read -p "Do you wish to install Huginn (y/n)?" yn
case $yn in
    y )
        cd agent
        sh ./setup.sh
        cd ..
        ;;
esac

read -p "Do you wish to install homebridge (y/n)?" yn
case $yn in
    y )
        cd homebridge
        sh ./setup.sh
        cd ..
        ;;
esac

read -p "Do you wish to install AdGuard Home (y/n)?" yn
case $yn in
    y )
        cd dns
        sh ./setup.sh
        cd ..
        ;;
esac