# Demo

These instructions assume that the demo will be deployed to a server that is using Let's Encrypt certificates for HTTPS traffic.
Also, Ubuntu or compatible operating system is assumed.

Note, no testing on actual server has been done of these instructions as of yet!

## Installation

1. Install the required utilities for the installation:

    ```bash
    sudo apt update
    sudo apt install curl wget openssl docker apache2-utils envsubst
    ```

2. Clone the repository and its submodules: `git clone --recursive git@github.com:EVCommunities/demo.git`
3. Create Let's Encrypt certificate
    - Certbot can be used to create the Let's Encrypt certificates relatively easily: [https://letsencrypt.org/getting-started/](https://letsencrypt.org/getting-started/)
    - Copy the created `cert.pem`, `fullchain.pem`, and `privkey.pem` files into folder `secrets`
        - The created certificate files should be located at folder `/etc/letsencrypt/live/<SERVER_ADDRESS>` where `<SERVER_ADDRESS>` is the host name of the server, for example, `myserver.com`.
4. Generate a DH parameter file to the `secrets` folder in order to use the certificates with Nginx proxy server: `openssl dhparam -out secrets/dhparam.pem 4096`
5. Create a configuration file from the template and set up all the variables: `cp .env.template .env`
    - Everything that is empty in the template, should be set up.
    - Settings that have default values can be changes as needed.
6. Run the installation script to set up the files for the simulation platform: `./install_platform.sh`
7. Run the update configurations script to propagate all the settings from `.env` to other configuration files: `./update_configurations.sh`
8. Start the demo (the simulation platform, the EV Communities simulation starter, the demo GUI, and the Nginx proxy server) with a helper script: `./start_demo.sh`
9. The demo will be available at the address: `https://<SERVER_ADDRESS>`

## Updating the configurations

1. Update the settings in `.env` file or update the secrets in the `secrets` folder.
2. Stop the demo: `./stop_demo.sh`
3. Propagate the updated configurations: `./update_configurations.sh`
4. Restart the demo: `./start_demo.sh`

## Stop the demo

- Run the stop demo script: `./stop_demo.sh`
