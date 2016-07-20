#! /bin/bash

echo "Requesting new certificate"

if [ -z  ${CERTBOT_EMAIL} ] || [ -z ${CERTBOT_DOMAIN} ] 
then
        echo "No email supplied not running certbot"
else
        certbot --apache -m ${CERTBOT_EMAIL} -d ${CERTBOT_DOMAIN} --redirect --agree-tos --non-interactive
fi




