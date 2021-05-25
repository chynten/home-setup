#!/bin/bash

export KUBECTL_VERSION=v1.21.0 #$(curl -L -s https://dl.k8s.io/release/stable.txt)
export INSTALL_K3S_VERSION=v1.21.0+k3s1

export ISTIO_VERSION=1.10.0-rc.1
export CERT_BOT_VERSION=v1.3.1

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

export PLEX_IMAGE=plexinc/pms-docker
export PLEX_VERSION=1.22.3.4523-d0ce30438

export MYSQL_IMAGE=mysql
export MYSQL_VERSION=8.0.25

export NEXTCLOUD_IMAGE=nextcloud
export NEXTCLOUD_VERSION=21.0.2-apache

export TRANSMISSION_IMAGE=linuxserver/transmission
export TRANSMISSION_VERSION=3.00-r2-ls88

export KEYCLOAK_IMAGE=quay.io/keycloak/keycloak
export KEYCLOAK_VERSION=13.0.0

export CLOUDBEAVER_IMAGE=dbeaver/cloudbeaver
export CLOUDBEAVER_VERSION=21.0.2

export TAUTULLI_IMAGE=tautulli/tautulli
export TAUTULLI_VERSION=v2.7.3

export AVAHI_IMAGE=solidnerd/avahi
export AVAHI_VERSION=0.7

export SAMBA_IMAGE=dperson/samba
export SAMBA_VERSION=amd64

export DNS_IMAGE=adguard/adguardhome
export DNS_VERSION=v0.106.3

export HOMEBRIDGE_IMAGE=oznu/homebridge
export HOMEBRIDGE_VERSION=ubuntu

export WORDPRESS_IMAGE=wordpress
export WORDPRESS_VERSION=5.7-apache

export HUGINN_IMAGE=huginn/huginn
export HUGINN_VERSION=4d17829cf6b15b004ad3f4be196303dca4944810