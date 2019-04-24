FROM php@sha256:0f42025cb6ecad02144d27a1e51bdf830c4bf7de3d6ab724240207f85cc9d827
# Needs to use this specific commit hash because of a bug that got introduced later. This corresponds to php 5.6-apache:jessie
RUN apt-get update && apt-get install -y imagemagick wget git zip mysql-client libpng12-dev
RUN pecl install xdebug-2.5.5
RUN docker-php-ext-install -j$(nproc) mysqli exif pdo_mysql gd && docker-php-ext-enable xdebug
COPY .docker/php.ini /usr/local/etc/php/
RUN sed -i '1 a xdebug.remote_autostart=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
sed -i '1 a xdebug.remote_connect_back=0 ' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
sed -i '1 a xdebug.remote_host=172.18.0.1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
sed -i '1 a xdebug.remote_log=/tmp/xdebug.log' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN a2enmod rewrite \
    && sed -i 's!/#ServerName www.example.com:80!#ServerName localhost:80!g' /etc/apache2/sites-available/000-default.conf \
    && echo "AllowEncodedSlashes On" >> /etc/apache2/apache2.conf

WORKDIR /var/www/html
