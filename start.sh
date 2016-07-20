#! /bin/bash

chown -R www-data /var/www/html

echo "Starting Apache"
apache2-foreground

