#!/usr/bin/env bash

# add Docker repository
apt-get update
apt-get install apt-transport-https ca-certificates

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" > /etc/apt/sources.list.d/docker.list
apt-get update

# install recommended packages
apt-get install -y linux-image-extra-"$(uname -r)" linux-image-extra-virtual

# install Docker
apt-get install -y docker-engine=1.12.1-0~wily
