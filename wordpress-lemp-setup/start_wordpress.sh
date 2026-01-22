#!/bin/bash

echo "🚀 Starting WordPress LEMP stack..."

echo "▶ Starting MySQL..."
sudo service mysql start

echo "▶ Starting PHP-FPM..."
sudo service php8.3-fpm start

echo "▶ Starting Nginx..."
sudo service nginx start

echo "✅ All services started successfully!"
echo "🌐 Open: http://localhost"

