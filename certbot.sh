#! /bin/bash

echo "Requesting new certificate"

if [ -z  ${CERTBOT_EMAIL} ] || [ -z ${CERTBOT_DOMAIN} ] 
then
        echo "ERROR: No email or domain supplied! Stopping request!"
	echo "Please add the environmental variables CERTBOT_EMAIL and CERTBOT_DOMAIN to the docker run command"
else
	echo "Requesting certificate using Certbot"
        certbot --apache -m ${CERTBOT_EMAIL} -d ${CERTBOT_DOMAIN} --redirect --agree-tos --non-interactive
	echo "Request made, please try to access your server through HTTPS"

	echo "Creating CRON"
	mv /certbot.cron /etc/cron.daily/certbot
	echo "Moved CRON to cron.daily" 
fi




