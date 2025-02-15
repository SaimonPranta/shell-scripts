#!/bin/bash

# Install nginx

sudo apt-update -y
sudo apt install -y nginx


# Documentation Link of certbot: - https://snapcraft.io/docs/installing-snap-on-ubuntu
sudo apt update
sudo apt install snapd

# Documentation Link of certbot: - https://certbot.eff.org/instructions?ws=nginx&os=snap

sudo apt-get remove -y certbot

sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

sudo certbot --nginx
