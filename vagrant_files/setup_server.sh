#!/usr/bin/env bash
trap 'echo "# $BASH_COMMAND"' DEBUG

sudo DEBIAN_FRONTEND=noninteractive apt-get update

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq nodejs

cd /home/vagrant/
cp -r DASH-setup DASH-setup-local

mkdir -p /home/vagrant/DASH-setup/logs/
rm -r /home/vagrant/DASH-setup-local/logs
ln -s /home/vagrant/DASH-setup/logs/ /home/vagrant/DASH-setup-local/logs

chown -R vagrant:vagrant DASH-setup-local

cd DASH-setup-local
npm install