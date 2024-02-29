# Demo

These instructions assume that the demo will be deployed to a server that is using Let's Encrypt certificates for HTTPS traffic.

1. Clone the repository and its submodules: `git clone --recursive git@github.com:EVCommunities/demo.git`
2. Inside the cloned repository run install platform script to set up the files for the simulation platform: `./install_platform.sh`
3. Create Let's Encrypt certificate
    - Certbot can be used to create the Let's Encrypt certificates relatively easily: [https://letsencrypt.org/getting-started/](https://letsencrypt.org/getting-started/)
    - Copy the created `cert.pem` and `privkey.pem` files into folder `platform/background/ssl`
        - The created certificate files should be located at folder `/etc/letsencrypt/live/<SERVER_ADDRESS>` where `<SERVER_ADDRESS>` is the host name of the server, for example, `myserver.com`.
4. Create a configuration file from the template and set up all the variables: `cp .env.template .env`
5. Run the update configurations script to propagate all the settings to the files in the platform folder: `./update_configurations.sh`
6. Start the simulation platform, the EV Communities simulation starter, and the demo GUI with a helper script: `./start_demo.sh`
7. Start the Nginx proxy for the demo: TODO
