#!/bin/bash

# Make sure nvm is installed
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
fi

# Source the nvm script to use it
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# The rest of your script...
cd /var/website/backend
rm -r micple-backend
#git clone https://github.com/SaimonPranta/somachartv-express.js.git micple-backend
git clone https://github.com/SaimonPranta/somachartv-express.js.git micple-backend

cd micple-backend

mkdir -p /var/website/backend/somachar/secrets
if [ -f /var/website/backend/secrets/googleCrawlerSecrets.js ]; then
  cp /var/website/backend/secrets/googleCrawlerSecrets.js /var/website/backend/somachar/secrets/googleCrawlerSecrets.js
else
  echo "Secret file not found. Exiting."
  exit 1
fi


echo "Before npm install nvm"
nvm install 21.0.0  # Install Node version 21.0.0 if not installed
nvm use 21.0.0

npm install -f

pm2 delete "web-backend"
pm2 start "npm run build" --name "web-backend"

nvm use 14.17.3
