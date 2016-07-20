# Docker-nextcloud-letsencrypt

This is a docker container that includes the letsencrypt certbot client.

## Usage

1. Install Docker
2. Install docker image and run it

    ```
    docker pull undeadhunter/nextcloud-letsencrypt
    docker run -it --name nc --hostname hostname -p 80:80 -p 443:443 undeadhunter/nextcloud-letsencrypt
    ```

3. In your browser go to the IP address of your server (eg [http://serverip](http://serverip))
4. Follow the nextcloud setup

## Enabling letsencrypt

1. Install docker image with env variables `CERTBOT_DOMAIN="hostname"` and `CERTBOT_EMAIL="email"` make sure the hostname corresponds with the hostname of the docker
 
    ```
    docker run -it --name nc --hostname hostname -e CERTBOT_DOMAIN="hostname" -e CERTBOT_EMAIL="email" -p 80:80 -p 443:443 undeadhunter/nextcloud-letsencrypt
    ```

1. Run the certbot script, it will use the env variables and pull your certificate

    ```
    docker exec -it nc /certbot.sh
    ```

1. Wait 1 minute
1. Your host should now be accessible on  [https://serverip](https://serverip)

By default all requests to HTTP will be automatically forwarded to HTTPS 

## Exposing Volumes

As always you can expose volumes like any other docker image 

The following volumes might be usefull to expose

```
/var/www/html/data 
/var/www/html/config
```

These folders contain the users files and the general config files needed to configure nextcloud. 


