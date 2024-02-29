#!/bin/bash

# stop on error
set -e

# start the SimCES platform
cd platform
source platform_core_setup.sh
source platform_domain_setup.sh

# start the simulation starter
cd ../Simulation-Starter
echo "Starting the simulation starter for the EV Communities demo"
docker compose up --detach

# start the GUI
cd ../GUI
docker compose up --build --detach
