#!/bin/bash

if [ ! f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interactions
fi

if [ ! f ".env" ]; then
    echo "Creating .env"
    cp .env.example .env
fi

php-fpm -D
nginx -g "daemon off;"