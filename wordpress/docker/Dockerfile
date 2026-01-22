FROM php:8.3-fpm

# Install required PHP extensions for WordPress
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable recommended PHP extensions
RUN docker-php-ext-enable mysqli pdo_mysql
