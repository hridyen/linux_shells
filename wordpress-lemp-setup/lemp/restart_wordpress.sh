#!/bin/bash

echo "🔄 Restarting WordPress LEMP stack..."

echo "⛔ Stopping Nginx..."
sudo service nginx stop

echo "⛔ Stopping PHP-FPM..."
sudo service php8.3-fpm stop

echo "⛔ Stopping MySQL..."
sudo service mysql stop

sleep 2

echo "▶ Starting MySQL..."
sudo service mysql start

echo "▶ Starting PHP-FPM..."
sudo service php8.3-fpm start

echo "▶ Starting Nginx..."
sudo service nginx start

echo "✅ WordPress stack restarted cleanly!"
echo "🌐 Check: http://localhost"

