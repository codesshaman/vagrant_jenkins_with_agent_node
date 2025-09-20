#!/bin/bash

warn=\033[33;01m
no=\033[0m

## Install node exporter for methrics (commit it if your not need methrics)

echo "${warn}[Node Exporter] : download...${no}"
wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz
echo "${warn}[Node Exporter] : successfully downloaded...${no}"

echo "${warn}[Node Exporter] : installation...${no}"
tar xvfz node_exporter-*.linux-amd64.tar.gz
cd node_exporter-*.*-amd64
mv node_exporter /usr/bin/

echo "${warn}[Node Exporter] : creating a user...${no}"
useradd -r -M -s /bin/false node_exporter
chown node_exporter:node_exporter /usr/bin/node_exporter

echo "${warn}[Node Exporter] : creating a system unit...${no}"
{   echo '[Unit]'; \
    echo 'Description=Prometheus Node Exporter'; \
    echo '[Service]'; \
    echo 'User=node_exporter'; \
    echo 'Group=node_exporter'; \
    echo 'Type=simple'; \
    echo 'ExecStart=/usr/bin/node_exporter'; \
    echo '[Install]'; \
    echo 'WantedBy=multi-user.target'; \
} | tee /etc/systemd/system/node_exporter.service;

echo "${warn}[Node Exporter] : reload daemon...${no}"
systemctl daemon-reload
echo "${warn}[Node Exporter] : enable node exporter...${no}"
systemctl enable --now node_exporter
systemctl status node_exporter
echo "${warn}Node exporter has been setup succefully!${no}"

## Install docker

echo "${warn}[Docker] : requirements...${no}"

apt update

apt install -y \
    git \
    curl \
    make \
    docker-compose \
    ca-certificates \
    apt-transport-https

echo "${warn}[Docker] : install gpg key...${no}"

curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "${warn}[Docker] : installing...${no}"

apt update && \
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "${warn}[Docker] : add user to vagrant group...${no}"
sudo usermod -aG docker vagrant

docker --version
docker ps

## Install docker-compose

curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version

## Install mkcert

echo -e "${warn}[Mkcert]${no} ${cyan}install...${no}"
curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest| grep browser_download_url  | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -
mv mkcert-v*-linux-amd64 mkcert
chmod a+x mkcert
mv mkcert /usr/local/bin/

## Install Jenkins

echo "${warn}[Jenkins] : install jdk...${no}"
sudo apt install default-jdk -y
echo "${warn}[Jenkins] : install jdk...${no}"
java --version

echo "${warn}[Jenkins] : get LTS key...${no}"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "${warn}[Jenkins] : add LTS repo...${no}"
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "${warn}[Jenkins] : update repo list...${no}"
sudo apt update

echo "${warn}[Jenkins] : install Jenkins...${no}"
sudo apt install jenkins -y