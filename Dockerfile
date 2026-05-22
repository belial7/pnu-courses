FROM php:8.2-apache
COPY . /var/www/html
RUN docker-php-ext-install pdo pdo_mysql
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html/storage
EXPOSE 80
