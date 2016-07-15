#!/usr/bin/env bash

# install Docker and dependencies
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-wily testing" > /etc/apt/sources.list.d/docker.list

apt-get update

apt-get install -y linux-image-extra-"$(uname -r)"
apt-get install -y docker-engine=1.12.0~rc3-0~wily
