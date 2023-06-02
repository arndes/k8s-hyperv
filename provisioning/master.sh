#!/bin/bash

echo "Prepare ansible ..."

cd /home/vagrant/ansible

sudo apt update > /dev/null 2>&1
sudo apt install python3-venv sshpass -y > /dev/null 2>&1

python3 -m venv venv > /dev/null
source venv/bin/activate > /dev/null 
pip install --upgrade -r requirements.txt > /dev/null
echo "Run ansible ..."

ansible-playbook playbook.yaml