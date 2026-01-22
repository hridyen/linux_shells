#!/bin/bash

echo "🚀 Starting WordPress LAMP (Apache) Installation..."

# -------------------------------
# System update
# -------------------------------
sudo apt update && sudo apt upgrade -y

# -------------------------------
# Install Apache
# -------------------------------
sudo apt install apache2 -y
sudo service apache2 start

# -------------------------------
# Install PHP 8.3 & extensions
# -------------------------------
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

sudo apt install php8.3 libapache2-mod-php8.3 php8.3-mysql \
php8.3-curl php8.3-gd php8.3-mbstring php8.3-xml php8.3-zip -y

# -------------------------------
# Install MySQL
# -------------------------------
sudo apt install mysql-server -y
sudo service mysql start

# -------------------------------
# Create database & user
# -------------------------------
sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS wordpress
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP USER IF EXISTS 'wpuser'@'localhost';
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'strongpassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# -------------------------------
# Download WordPress
# -------------------------------
cd /tmp
curl -LO https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz

sudo rm -rf /var/www/html/*
sudo cp -r wordpress/* /var/www/html/

sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# -------------------------------
# Create wp-config.php
# -------------------------------
sudo tee /var/www/html/wp-config.php > /dev/null <<EOF
<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wpuser');
define('DB_PASSWORD', 'strongpassword');
define('DB_HOST', 'localhost');

define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');
define('FS_METHOD', 'direct');

\$table_prefix = 'wp_';
define('WP_DEBUG', false);

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}
require_once ABSPATH . 'wp-settings.php';
EOF

sudo chown www-data:www-data /var/www/html/wp-config.php
sudo chmod 640 /var/www/html/wp-config.php

# -------------------------------
# Enable Apache rewrite (important)
# -------------------------------
sudo a2enmod rewrite
sudo service apache2 restart

echo "✅ LAMP INSTALLATION COMPLETE"
echo "🌐 Open: http://localhost/wp-admin/install.php"

