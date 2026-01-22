#!/bin/bash

echo "🚀 Starting FULL WordPress LEMP Installation..."

# -------------------------------
# Update system
# -------------------------------
sudo apt update && sudo apt upgrade -y

# -------------------------------
# Install Nginx
# -------------------------------
sudo apt install nginx -y
sudo service nginx start

# -------------------------------
# Install PHP 8.3 & extensions
# -------------------------------
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

sudo apt install php8.3 php8.3-fpm php8.3-mysql php8.3-curl \
php8.3-gd php8.3-mbstring php8.3-xml php8.3-zip -y

sudo service php8.3-fpm start

# -------------------------------
# Install MySQL
# -------------------------------
sudo apt install mysql-server -y
sudo service mysql start

# -------------------------------
# Create WordPress database & user
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

sudo mkdir -p /var/www/wordpress
sudo cp -r wordpress/* /var/www/wordpress

sudo chown -R www-data:www-data /var/www/wordpress
sudo chmod -R 755 /var/www/wordpress

# -------------------------------
# Create wp-config.php
# -------------------------------
sudo tee /var/www/wordpress/wp-config.php > /dev/null <<EOF
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

sudo chown www-data:www-data /var/www/wordpress/wp-config.php
sudo chmod 640 /var/www/wordpress/wp-config.php

# -------------------------------
# Nginx server block
# -------------------------------
sudo tee /etc/nginx/sites-available/wordpress > /dev/null <<EOF
server {
    listen 80;
    server_name localhost;

    root /var/www/wordpress;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

sudo nginx -t
sudo service nginx reload

echo "✅ INSTALLATION COMPLETE"
echo "🌐 Open: http://localhost/wp-admin/install.php"

