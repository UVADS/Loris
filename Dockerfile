# syntax=docker/dockerfile:1
FROM php:7.4-apache

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd zip mysqli pdo_mysql
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apt-get update
RUN apt-get -y install nodejs npm sudo
COPY . /var/www/loris/
