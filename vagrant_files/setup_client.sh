#!/usr/bin/env bash
# shellcheck disable=SC1068
trap 'echo "# $BASH_COMMAND"' DEBUG

sudo DEBIAN_FRONTEND=noninteractive apt-get update

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq google-chrome-stable

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq nodejs

cd /home/vagrant/
cp -r DASH-setup DASH-setup-local
chown -R vagrant:vagrant DASH-setup-local

cd DASH-setup-local

npm install