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

read -p "Do you wish to install nextcloud (y/n)?" yn

case $yn in
    y )
        cd mysql
        sh ./setup.sh
        ;;
esac
