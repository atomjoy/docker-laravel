# Web Stage
FROM nginx:1.27-bookworm AS nginx_server_stage

RUN apt-get update -y
RUN apt-get install -y php-cli php-mysql php-mbstring php-xml php-bcmath php-bz2 php-zip php-curl php-gd php-json php-intl

WORKDIR /var/www/html

COPY --chown=www-data:root --chmod=2775 ./laravel-app .

COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

RUN php artisan config:clear
RUN php artisan cache:clear
RUN php artisan migrate
RUN php artisan storage:link

WORKDIR /var/www

COPY --chown=www-data:root --chmod=2775 ./docker/entrypoint.sh ./docker/entrypoint.sh

RUN chmod +x ./docker/entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT [ "/var/www/docker/entrypoint.sh" ]

# Php stage
FROM php:8.2-fpm-bookworm AS php_server_stage

# Libs minimal
# RUN apt-get update -y
# RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev
# RUN docker-php-ext-install pdo pdo_mysql bcmath opcache intl gettext

# Libs
RUN apt-get update -y
RUN apt-get install -y unzip zip nano libpq-dev libcurl4-gnutls-dev libssl-dev
RUN apt-get install -y libicu-dev libmariadb-dev zlib1g-dev libwebp-dev libxpm-dev libjpeg-dev libpng-dev libjpeg62-turbo-dev libfreetype6-dev
# Extensions php
RUN docker-php-ext-install pdo pdo_mysql bcmath opcache intl gettext gd
RUN docker-php-ext-configure gd --enable-gd --with-webp --with-xpm --with-jpeg --with-freetype 
RUN docker-php-ext-install -j$(nproc) gd

# Create User
# RUN usermod -u 1000 www-data

# Create user
# RUN groupadd -r postgres && useradd --no-log-init -r -g postgres postgres

# Env
# ENV PHP_OPCACHE_ENABLE=1
# ENV PHP_OPCACHE_ENABLE_CLI=0
# ENV PHP_OPCACHE_VALIDATE_TIMESTAMP=1
# ENV PHP_OPCACHE_REVALIDATE_FREQ=1

# COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

# WORKDIR /var/www/html