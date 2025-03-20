# Use official PHP image with Apache
FROM php:8.3-apache

# This will be set by the GitHub action to the folder containing this component.
ARG FOLDER=/app/component-name
ARG IDENTIFIER=component-name

# Install required packages
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Import project
COPY . /app

# Set working directory
WORKDIR ${FOLDER}

# Apache configuration 
COPY ${IDENTIFIER}/000-default.conf /etc/apache2/sites-available
COPY ${IDENTIFIER}/entrypoint.sh /entrypoint.sh

# Install dependencies
RUN composer update -o --no-dev  

# Expose Apache port
EXPOSE 80

# Set entrypoint command
ENTRYPOINT ["/entrypoint.sh"]