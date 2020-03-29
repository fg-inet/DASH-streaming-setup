#!/usr/bin/env bash
# shellcheck disable=SC1068
trap 'echo "# $BASH_COMMAND"' DEBUG

sudo apt update

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install -y google-chrome-stable

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs

cd /home/vagrant/
cp -r DASH-setup DASH-setup-local
cd DASH-setup-local

npm install
sudo npm install -g --force nodemon

sudo apt-get install -y xauth
