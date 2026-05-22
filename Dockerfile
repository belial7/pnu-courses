FROM php:8.2-apache

# Встановлюємо необхідні розширення
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Копіюємо код
COPY . /var/www/html

# Вмикаємо Apache rewrite
RUN a2enmod rewrite

# Створюємо папки, якщо їх немає, і даємо права на все відразу
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html

# Налаштовуємо DocumentRoot для Laravel
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

EXPOSE 80
