#!/bin/bash

# stop on error
set -e

# collect the configurations from the .env file
export server_address=$(cat .env | grep SERVER_ADDRESS= | cut -d'=' -f2)
export frontend_username=$(cat .env | grep FRONTEND_USERNAME= | cut -d'=' -f2)
export frontend_password=$(cat .env | grep FRONTEND_PASSWORD= | cut -d'=' -f2)
export mongo_root_username=$(cat .env | grep MONGO_ROOT_USERNAME= | cut -d'=' -f2)
export mongo_root_password=$(cat .env | grep MONGO_ROOT_PASSWORD= | cut -d'=' -f2)
export mongo_username=$(cat .env | grep MONGO_USERNAME= | cut -d'=' -f2)
export mongo_password=$(cat .env | grep MONGO_PASSWORD= | cut -d'=' -f2)
export mongo_express_username=$(cat .env | grep MONGO_EXPRESS_USERNAME= | cut -d'=' -f2)
export mongo_express_password=$(cat .env | grep MONGO_EXPRESS_PASSWORD= | cut -d'=' -f2)
export rabbitmq_user=$(cat .env | grep RABBITMQ_USER= | cut -d'=' -f2)
export rabbitmq_password=$(cat .env | grep RABBITMQ_PASSWORD= | cut -d'=' -f2)
export mongodb_port=$(cat .env | grep MONGODB_PORT= | cut -d'=' -f2)
export mongo_express_port=$(cat .env | grep MONGO_EXPRESS_PORT= | cut -d'=' -f2)
export rabbitmq_port=$(cat .env | grep RABBITMQ_PORT= | cut -d'=' -f2)
export rabbitmq_management_port=$(cat .env | grep RABBITMQ_MANAGEMENT_PORT= | cut -d'=' -f2)
export log_reader_port=$(cat .env | grep LOG_READER_PORT= | cut -d'=' -f2)
export gui_backend_port=$(cat .env | grep EVC_GUI_BACKEND_PORT= | cut -d'=' -f2)
export gui_frontend_port=$(cat .env | grep EVC_GUI_FRONTEND_PORT= | cut -d'=' -f2)
export starter_port=$(cat .env | grep STARTER_PORT= | cut -d'=' -f2)
export starter_private_token=$(cat .env | grep STARTER_PRIVATE_TOKEN= | cut -d'=' -f2)
export starter_production_mode=$(cat .env | grep STARTER_PRODUCTION_MODE= | cut -d'=' -f2)
export starter_log_level=$(cat .env | grep STARTER_SIMULATION_LOG_LEVEL= | cut -d'=' -f2)
export starter_verbose=$(cat .env | grep STARTER_VERBOSE= | cut -d'=' -f2)


# generate a password file for the HTTP basic authentication
echo "${frontend_password}" | htpasswd -ci secrets/pass_etc.wd ${frontend_username} > /dev/null 2>&1


# set the configurations for the Nginx proxy
cd nginx
export host_server_name=${server_address}
envsubst < servers.conf.template > servers/servers.conf
sed -i "s/£/\$/g" servers/servers.conf


# set the configurations for the SimCES platform
cd ../platform

# set the RabbitMQ configurations
sed -i "s/^default_user =.*/default_user = ${rabbitmq_user}/g" background/config/rabbitmq.conf
sed -i "s/^default_pass =.*/default_pass = ${rabbitmq_pass}/g" background/config/rabbitmq.conf

# set the host name of the server
sed -i "s/^SERVER_ADDRESS=.*/SERVER_ADDRESS=${server_address}/g" background/.env

# set the MongoDB configurations
sed -i "s/^MONGODB_PORT=.*/MONGODB_PORT=${mongodb_port}/g" background/.env
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


# set the configurations for the simulation starter
cd ../Simulation-Starter
cp .env.template .env

# prevent configuration file changes from being tracked by git
git update-index --skip-worktree configuration/mongodb.env
git update-index --skip-worktree configuration/rabbitmq.env

current_folder=$(pwd)
sed -i "s/^HOST_FOLDER=.*/HOST_FOLDER=$(echo "$current_folder" | sed -e 's/\//\\\//g')/g" .env
sed -i "s/^SERVER_PRIVATE_TOKEN=.*/SERVER_PRIVATE_TOKEN=${starter_private_token}/g" .env
sed -i "s/^SERVER_PORT=.*/SERVER_PORT=${starter_port}/g" .env
sed -i "s/^SERVER_BASE_PATH=.*/SERVER_BASE_PATH=\/starter/g" .env
sed -i "s/^PRODUCTION_MODE=.*/PRODUCTION_MODE=${starter_production_mode}/g" .env
sed -i "s/^SIMULATION_LOG_LEVEL=.*/SIMULATION_LOG_LEVEL=${starter_log_level}/g" .env
sed -i "s/^VERBOSE=.*/VERBOSE=${starter_verbose}/g" .env

sed -i "s/^MONGODB_HOST=.*/MONGODB_HOST=${server_address}/g" configuration/mongodb.env
sed -i "s/^MONGODB_PORT=.*/MONGODB_PORT=${mongodb_port}/g" configuration/mongodb.env
sed -i "s/^MONGODB_USERNAME=.*/MONGODB_USERNAME=${mongo_username}/g" configuration/mongodb.env
sed -i "s/^MONGODB_PASSWORD=.*/MONGODB_PASSWORD=${mongo_password}/g" configuration/mongodb.env
sed -i "s/^MONGODB_APPNAME=.*/MONGODB_APPNAME=evcommunities_demo/g" configuration/mongodb.env
sed -i "s/^MONGODB_ADMIN=.*/MONGODB_ADMIN=false/g" configuration/mongodb.env
sed -i "s/^MONGODB_TLS=.*/MONGODB_TLS=true/g" configuration/mongodb.env

sed -i "s/^RABBITMQ_HOST=.*/RABBITMQ_HOST=${server_address}/g" configuration/rabbitmq.env
sed -i "s/^RABBITMQ_PORT=.*/RABBITMQ_PORT=${rabbitmq_port}/g" configuration/rabbitmq.env
sed -i "s/^RABBITMQ_LOGIN=.*/RABBITMQ_LOGIN=${rabbitmq_user}/g" configuration/rabbitmq.env
sed -i "s/^RABBITMQ_PASSWORD=.*/RABBITMQ_PASSWORD=${rabbitmq_password}/g" configuration/rabbitmq.env
sed -i "s/^RABBITMQ_SSL=.*/RABBITMQ_SSL=true/g" configuration/rabbitmq.env
sed -i "s/^RABBITMQ_EXCHANGE=.*/RABBITMQ_EXCHANGE=evcommunities-management/g" configuration/rabbitmq.env
sed -i "s/^RABBITMQ_EXCHANGE_PREFIX=.*/RABBITMQ_EXCHANGE_PREFIX=evcommunities./g" configuration/rabbitmq.env

sed -i "s/^RABBITMQ_EXCHANGE_PREFIX=.*/RABBITMQ_EXCHANGE_PREFIX=evcommunities./g" docker-compose.yml


# set the configurations for the GUI
cd ../GUI
cp .env.template .env

log_reader_path=$(echo "https://${server_address}/logreader" | sed -e 's/\//\\\//g')
backend_path=$(echo "https://${server_address}/demo/backend" | sed -e 's/\//\\\//g')
starter_path=$(echo "https://${server_address}/starter/" | sed -e 's/\//\\\//g')

sed -i "s/^EVC_GUI_BACKEND_PORT=.*/EVC_GUI_BACKEND_PORT=${gui_backend_port}/g" .env
sed -i "s/^EVC_GUI_FRONTEND_PORT=.*/EVC_GUI_FRONTEND_PORT=${gui_frontend_port}/g" .env
sed -i "s/^LOGREADER_API=.*/LOGREADER_API=${log_reader_path}/g" .env
sed -i "s/^NEXT_PUBLIC_EVC_GUI_BACKEND=.*/NEXT_PUBLIC_EVC_GUI_BACKEND=${backend_path}/g" .env
sed -i "s/^SIMULATION_STARTER=.*/SIMULATION_STARTER=${starter_path}/g" .env
sed -i "s/^PRIVATE_TOKEN=.*/PRIVATE_TOKEN=${starter_private_token}/g" .env


echo "The configurations have been updated successfully."
