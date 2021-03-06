#!/bin/bash

export KUBECTL_VERSION=v1.21.0 #$(curl -L -s https://dl.k8s.io/release/stable.txt)
export INSTALL_K3S_VERSION=v1.21.0+k3s1

export ISTIO_VERSION=1.10.0-rc.1
export CERT_BOT_VERSION=v1.3.1

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

export MYSQL_IMAGE=mysql
export MYSQL_VERSION=8.0.26

export POSTGRES_IMAGE=postgres
export POSTGRES_VERSION=13.3

export CLOUDBEAVER_IMAGE=dbeaver/cloudbeaver
export CLOUDBEAVER_VERSION=21.1.0

export KEYCLOAK_IMAGE=jboss/keycloak
export KEYCLOAK_VERSION=14.0.0

export WORDPRESS_IMAGE=wordpress
export WORDPRESS_VERSION=5.8.0-php8.0-apache

export PLEX_IMAGE=plexinc/pms-docker
export PLEX_VERSION=1.23.5.4862-0f739d462

export TAUTULLI_IMAGE=tautulli/tautulli
export TAUTULLI_VERSION=v2.7.5

export NEXTCLOUD_IMAGE=nextcloud
export NEXTCLOUD_VERSION=22.0.0-apache

export TRANSMISSION_IMAGE=linuxserver/transmission
export TRANSMISSION_VERSION=3.00-r2-ls92

export AVAHI_IMAGE=solidnerd/avahi
export AVAHI_VERSION=0.7

export SAMBA_IMAGE=dperson/samba
export SAMBA_VERSION=amd64

export DNS_IMAGE=adguard/adguardhome
export DNS_VERSION=v0.107.0-b.5

export HOMEBRIDGE_IMAGE=oznu/homebridge
export HOMEBRIDGE_VERSION=ubuntu

export HUGINN_IMAGE=huginn/huginn
export HUGINN_VERSION=4d17829cf6b15b004ad3f4be196303dca4944810

export FOCALBOARD_IMAGE=mattermost/focalboard
export FOCALBOARD_VERSION=0.8.1

export WIKIJS_IMAGE=requarks/wiki
export WIKIJS_VERSION=2.5.201