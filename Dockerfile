FROM php:8.2-apache
WORKDIR /var/www/html

# Mod Rewrite
RUN a2enmod rewrite

# Linux Library
RUN apt-get update -y && apt-get install -y \
    libicu-dev \
    libmariadb-dev \
    unzip zip \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# PHP Extension
RUN docker-php-ext-install gettext intl pdo_mysql gd

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd


#RUN apt-get update -y && apt-get install -y libmcrypt-dev

# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN docker-php-ext-install pdo mbstring

# COPY . /var/wwww/html

# RUN composer install
# RUN docker-php-ext-install gettext intl pdo_mysql gd
# RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
#     && docker-php-ext-install -j$(nproc) gd

# EXPOSE 8000
# CMD php artisan serve --host=0.0.0.0 --port=8000