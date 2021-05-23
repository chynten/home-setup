#!/bin/bash

export KUBECTL_VERSION=v1.21.0 #$(curl -L -s https://dl.k8s.io/release/stable.txt)
export INSTALL_K3S_VERSION=v1.21.0+k3s1

export ISTIO_VERSION=1.10.0-rc.1
export CERT_BOT_VERSION=v1.3.1

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

export PLEX_IMAGE=ghcr.io/linuxserver/plex
export PLEX_VERSION=version-1.22.3.4392-d7c624def

export MYSQL_IMAGE=mysql
export MYSQL_VERSION=8.0.25

export NEXTCLOUD_IMAGE=nextcloud
export NEXTCLOUD_VERSION=21.0.1-apache

export TRANSMISSION_IMAGE=ghcr.io/linuxserver/transmission
export TRANSMISSION_VERSION=3.00-r2-ls86

export KEYCLOAK_IMAGE=quay.io/keycloak/keycloak
export KEYCLOAK_VERSION=13.0.0

export CLOUDBEAVER_IMAGE=dbeaver/cloudbeaver
export CLOUDBEAVER_VERSION=21.0.0

export TAUTULLI_IMAGE=ghcr.io/linuxserver/tautulli
export TAUTULLI_VERSION=version-v2.7.2

export AVAHI_IMAGE=solidnerd/avahi
export AVAHI_VERSION=0.7

export SAMBA_IMAGE=dperson/samba
export SAMBA_VERSION=amd64