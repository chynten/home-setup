#!/bin/bash

read -p "Node Name (If multiple, then give node name which has local storage):" NODE_NAME
export NODE_NAME=$NODE_NAME

echo "Do you wish to install plex?"
select yn in "Yes" "No"
case $yn in
    Yes )
        cd plex
        sh ./setup.sh
        cd ..
        ;;
    No ) 
        return
        ;;
esac


echo "Do you wish to install Nextcloud?"
select yn in "Yes" "No"
case $yn in
    Yes )
        cd mysql
        sh ./setup.sh
        ;;
    No ) 
        return
        ;;
esac
