#!/usr/bin/env bash
trap 'echo "# $BASH_COMMAND"' DEBUG

sudo apt update

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs
cd /home/vagrant/
cp -r DASH-setup DASH-setup-local
cd DASH-setup-local

npm install
sudo npm install -g --force nodemon
