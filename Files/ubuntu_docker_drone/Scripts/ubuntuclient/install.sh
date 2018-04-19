#!/bin/bash

echo "Use simple debug messages to understand where the issues could be"
echo "installing!!!"
echo "Avoid long outputs! so redirect the output to a file that you can later check, for instance:"
sudo apt-get update
sudo apt-get update > /tmp/install.log
echo "apt update worked!"
sudo apt-get install -y cowsay >> /tmp/install.log
echo "Check the env before running special commands!"
env

#Instal docker
sudo apt-get install -y docker.io
#Another way of installing docker, use if apt-get not working
#. /etc/environment
#printf "nameserver 10.42.135.2\n" >/etc/resolve.conf
#sh <(curl -fsSL get.docker.com)

#Deploy docker container
sudo docker run -p 4000:80 -d lesterthomas/videoserver:1.1

#If deploying to ericsson move this before
sudo su -
cd ..
mkdir /etc/systemd/system/docker.service.d
echo '[Service] '> /etc/systemd/system/docker.service.d/http-proxy.conf
echo 'Environment="HTTP_PROXY=http://10.42.137.126:8080"' >> /etc/systemd/system/docker.service.d/http-proxy.conf
echo 'Environment="FTP_PROXY=http://10.42.137.126:8080"' >> /etc/systemd/system/docker.service.d/http-proxy.conf
echo 'Environment="HTTPS_PROXY=http://10.42.137.126:8080"' >> /etc/systemd/system/docker.service.d/http-proxy.conf
echo 'Environment="NO_PROXY=169.254.169.254,10.,172."' >> /etc/systemd/system/docker.service.d/http-proxy.conf

echo "this one for instance..."
/usr/games/cowsay -f tux "install successfull"
