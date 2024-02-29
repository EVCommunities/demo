#!/bin/bash

# stop on error
set -e

# collect the configurations from the .env file
server_address=$(cat .env | grep SERVER_ADDRESS= | cut -d'=' -f2)
mongo_root_username=$(cat .env | grep MONGO_ROOT_USERNAME= | cut -d'=' -f2)
mongo_root_password=$(cat .env | grep MONGO_ROOT_PASSWORD= | cut -d'=' -f2)
mongo_username=$(cat .env | grep MONGO_USERNAME= | cut -d'=' -f2)
mongo_password=$(cat .env | grep MONGO_PASSWORD= | cut -d'=' -f2)
mongo_express_username=$(cat .env | grep MONGO_EXPRESS_USERNAME= | cut -d'=' -f2)
mongo_express_password=$(cat .env | grep MONGO_EXPRESS_PASSWORD= | cut -d'=' -f2)
rabbitmq_user=$(cat .env | grep RABBITMQ_USER= | cut -d'=' -f2)
rabbitmq_password=$(cat .env | grep RABBITMQ_PASSWORD= | cut -d'=' -f2)
mongo_port=$(cat .env | grep MONGODB_PORT= | cut -d'=' -f2)
mongo_express_port=$(cat .env | grep MONGO_EXPRESS_PORT= | cut -d'=' -f2)
rabbitmq_port=$(cat .env | grep RABBITMQ_PORT= | cut -d'=' -f2)
rabbitmq_management_port=$(cat .env | grep RABBITMQ_MANAGEMENT_PORT= | cut -d'=' -f2)
log_reader_port=$(cat .env | grep LOG_READER_PORT= | cut -d'=' -f2)

cd platform

# create a chained certificate file by compining the private key and the certificate
cat background/ssl/privkey.pem background/ssl/cert.pem > background/ssl/evc.pem

# set the RabbitMQ configurations
sed -i "s/^default_user =.*/default_user = ${rabbitmq_user}/g" background/config/rabbitmq.conf
sed -i "s/^default_pass =.*/default_pass = ${rabbitmq_pass}/g" background/config/rabbitmq.conf

# set the host name of the server
sed -i "s/^SERVER_ADDRESS=.*/SERVER_ADDRESS=${server_address}/g" background/.env

# set the MongoDB configurations
sed -i "s/^MONGODB_PORT=.*/MONGODB_PORT=${mongo_port}/g" background/.env
sed -i "s/^MONGO_ROOT_USERNAME=.*/MONGO_ROOT_USERNAME=${mongo_root_username}/g" background/.env
sed -i "s/^MONGO_ROOT_PASSWORD=.*/MONGO_ROOT_PASSWORD=${mongo_root_password}/g" background/.env
sed -i "s/^MONGO_USERNAME=.*/MONGO_USERNAME=${mongo_username}/g" background/.env
sed -i "s/^MONGO_PASSWORD=.*/MONGO_PASSWORD=${mongo_password}/g" background/.env

# set the Mongo Express configurations
sed -i "s/^MONGO_EXPRESS_PORT=.*/MONGO_EXPRESS_PORT=${mongo_express_port}/g" background/.env
sed -i "s/^ME_CONFIG_BASICAUTH_USERNAME=.*/ME_CONFIG_BASICAUTH_USERNAME=${mongo_express_username}/g" background/.env
sed -i "s/^ME_CONFIG_BASICAUTH_PASSWORD=.*/ME_CONFIG_BASICAUTH_PASSWORD=${mongo_express_password}/g" background/.env

# set the RabbitMQ configurations
sed -i "s/^RABBITMQ_PORT=.*/RABBITMQ_PORT=${rabbitmq_port}/g" background/.env
sed -i "s/^RABBITMQ_MANAGEMENT_PORT=.*/RABBITMQ_MANAGEMENT_PORT=${rabbitmq_management_port}/g" background/.env
sed -i "s/^RABBITMQ_USER=.*/RABBITMQ_USER=${rabbitmq_user}/g" background/.env
sed -i "s/^RABBITMQ_PASSWORD=.*/RABBITMQ_PASSWORD=${rabbitmq_password}/g" background/.env

# set the configurations for the logging system
sed -i "s/^LOG_READER_PORT=.*/LOG_READER_PORT=${log_reader_port}/g" background/.env
