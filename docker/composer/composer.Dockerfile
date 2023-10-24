# Dockerfile
FROM php:7.4.1-fpm
# Install Composer
COPY --from=composer:1.10.15 /usr/bin/composer /usr/bin/composer

