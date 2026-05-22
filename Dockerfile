FROM php:8.2-apache

# Встановлюємо розширення для роботи з базою та картинками
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Важливий крок: перенаправляємо Apache на папку public
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Копіюємо всі файли проекту
COPY . /var/www/html

# Вмикаємо модуль для роботи маршрутів Laravel (rewrite)
RUN a2enmod rewrite

# Даємо права доступу до файлів
RUN chown -R www-data:www-data /var/www/html

# Вказуємо порт
EXPOSE 80
