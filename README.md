# Demo

These instructions assume that the demo will be deployed to a server that is using Let's Encrypt certificates for HTTPS traffic.

- Run install platform script to set up the files for the simulation platform: `./install_platform.sh`
- Create Let's Encrypt certificate
    - Certbot can be used to create the Let's Encrypt certificates relatively easily: [https://letsencrypt.org/getting-started/](https://letsencrypt.org/getting-started/)
    - Copy the created `fullchain.pem` and `privkey.pem` files into folder `platform/background/ssl`
- Create a configuration file from the template and set up all the variables: `cp .env.template .env`
- Run the update configurations script to propagate all the settings to the files in the platform folder: `./update_configurations.sh`
- Start the simulation platform using the helper script: `./start_platform.sh`
- Start the EV Communities simulation starter and the GUI for the demo: TODO
