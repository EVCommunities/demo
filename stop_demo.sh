#!/bin/bash

# stop on error
set -e

cd GUI
docker compose down --remove-orphans

cd ../Simulation-Starter
docker compose down --remove-orphans

cd ../platform
docker compose -f background/docker-compose-background.yml down --remove-orphans
