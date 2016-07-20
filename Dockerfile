FROM php:apache

RUN echo "deb http://ftp.debian.org/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list 

ENV CERTBOT_DOMAIN=""
ENV CERTBOT_EMAIL=""

RUN apt-get update
#Get certbot (letsencrypt client) from Jessie Backports

RUN apt-get install -t jessie-backports -y \
	certbot 

RUN apt-get install -y \
	python-certbot-apache \
	wget \
	bzip2 \
	zip zlib1g-dev \
	php5-gd libpng-dev \
	php5-mysql php5-pgsql libpq-dev


RUN docker-php-ext-install zip gd mysqli pgsql pdo_mysql

WORKDIR /var/www/html



RUN wget -q https://github.com/nextcloud/server/releases/download/v9.0.52/nextcloud-9.0.52.tar.bz2
RUN tar -jxvf nextcloud-9.0.52.tar.bz2 --strip-components=1
RUN rm nextcloud-9.0.52.tar.bz2


EXPOSE 80 443

COPY certbot.sh /certbot.sh
RUN chmod u+x /certbot.sh

COPY start.sh /start.sh
RUN chmod u+x /start.sh


CMD ["/start.sh"]
