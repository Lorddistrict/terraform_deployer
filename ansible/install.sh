#!/bin/bash

set -e
set -u

echo "UPDATING"
sudo apt update && sleep 5;

echo "START INSTALLING : PYTHON3-PIP"
apt install python3-pip -y
sleep 3;

echo "START INSTALLING : ANSIBLE"
python3 -m pip install --user ansible
sleep 3;

echo "UPDATE PATH"
export PATH="$PATH:/root/.local/bin"
echo "$PATH"
sleep 3;

echo "START INSTALLING : DOCKER & DOCKER-COMPOSE SDK"
pip install docker
pip install docker-compose
sleep 3;

echo "START INSTALLING : ANSIBLE COLLECTION : DOCKER"
ansible-galaxy collection install community.docker
sleep 3;

echo "RUNNING : PLAYBOOK"
ansible-playbook -vvv /home/debian/playbook.yaml
