#!/bin/bash

# stop on error
set -e

# download the SimCES platform files from the GitHub repository
mkdir -p platform
cd platform
wget https://raw.githubusercontent.com/simcesplatform/Platform-Manager/master/fetch_platform_files.sh
echo "y" | source fetch_platform_files.sh github

# copy the demo specific settings to the platform directory
cp -r ../demo_platform/* .

# ensure the execution permissions for the utility scripts
chmod a+x background/utility_scripts/*.sh

# remove unnecessary configuration files
rm -rf background/env

# fetch root certificate from Let's Encrypt
mkdir -p background/ssl
curl https://letsencrypt.org/certs/lets-encrypt-r3.pem > background/ssl/ca.pem


echo "The platform files have been downloaded and configured for the EV Communities demo"
