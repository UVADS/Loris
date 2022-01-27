# syntax=docker/dockerfile:1
FROM php:7.4-apache

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd zip mysqli pdo_mysql
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apt-get update
RUN apt-get -y install nodejs npm sudo
COPY . /var/www/loris/

WORKDIR /var/www/loris/tools/
RUN mkdir -p logs; \
    chmod 770 logs; \
    chgrp www-data logs

WORKDIR /var/www/loris/project/
RUN mkdir -p data libraries instruments templates tables_sql modules

WORKDIR /var/www/loris/tools/
RUN mkdir -p ../smarty/templates_c; \
    chmod 770 ../smarty/templates_c; \
    chown www-data.www-data ../smarty/templates_c; \
    chgrp www-data ../project; \
    chmod 770 ../project

RUN sed -e "s#%LORISROOT%#/var/www/loris/#g" \
                    -e "s#%PROJECTNAME%#loris#g" \
      	            -e "s#%LOGDIRECTORY%#/var/www/loris/tools/logs#g" \
                    < ../docs/config/apache2-site | sudo tee /etc/apache2/sites-available/loris.conf > /dev/null

RUN ln -s /etc/apache2/sites-available/loris.conf /etc/apache2/sites-enabled/loris.conf
RUN a2dissite 000-default; \
    a2ensite loris.conf; \
    a2enmod rewrite; \
    a2enmod headers