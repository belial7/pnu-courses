FROM php:8.2-apache

# Встановлюємо необхідні розширення
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Налаштовуємо Apache для роботи з Laravel (вказуємо папку public)
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Копіюємо код
COPY . /var/www/html

# Вмикаємо Apache rewrite (для роботи маршрутів Laravel)
RUN a2enmod rewrite

# Даємо права доступу
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
