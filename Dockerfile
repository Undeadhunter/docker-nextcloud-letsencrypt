FROM php:apache

ENV CERTBOT_DOMAIN=""
ENV CERTBOT_EMAIL=""

#ARG NEXTCLOUD_VERSION="11.0.2"
#ARG NEXTCLOUD_BAL=nextcloud-${NEXTCLOUD_VERSION}.tar.bz2

RUN echo "deb http://ftp.debian.org/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list

RUN apt-get update

# Get certbot (Let's Encrypt client) from Jessie Backports

RUN apt-get install -t jessie-backports -y \
	certbot 

# Install all required requirements for Nextcloud

RUN apt-get install -y \
	python-certbot-apache \
	wget \
	bzip2 \
	zip zlib1g-dev \
	php5-gd libpng-dev \
	php5-mysql php5-pgsql libpq-dev

# Enable all the modules

RUN docker-php-ext-install zip gd mysqli pgsql pdo_mysql

WORKDIR /var/www/html

# Uninstall the build packages
RUN apt-get remove --purge -y zlib1g-dev libpng-dev libpq-dev && rm -rf /var/lib/apt/lists/*

RUN wget "https://download.nextcloud.com/server/releases/latest.tar.bz2"
RUN tar -jxvf latest.tar.bz2 --strip-components=1
RUN rm latest.tar.bz2


COPY certbot.sh /certbot.sh
COPY certbot.cron /certbot.cron
RUN chmod u+x /certbot.sh
RUN chmod u+x /certbot.cron

COPY start.sh /start.sh
RUN chmod u+x /start.sh

EXPOSE 80 443

VOLUME /var/www/html/data 
VOLUME /var/www/html/config

CMD ["/start.sh"]
