<?php
/**
 * WordPress base configuration file
 *
 * Docker + LEMP (Nginx + PHP-FPM + MySQL)
 * This file is used inside Docker containers
 */

/** =========================
 * DATABASE CONFIGURATION
 * ========================= */

define('DB_NAME', 'wordpress');          // Database name
define('DB_USER', 'wpuser');              // MySQL user
define('DB_PASSWORD', 'strongpassword');  // MySQL password
define('DB_HOST', 'mysql');               // Docker service name (NOT localhost)
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

/** =========================
 * FILE SYSTEM METHOD
 * ========================= */

define('FS_METHOD', 'direct');

/** =========================
 * AUTHENTICATION KEYS & SALTS
 * =========================
 * (for exam you can say: security purpose)
 */

define('AUTH_KEY',         'put-your-unique-key-here');
define('SECURE_AUTH_KEY',  'put-your-unique-key-here');
define('LOGGED_IN_KEY',    'put-your-unique-key-here');
define('NONCE_KEY',        'put-your-unique-key-here');
define('AUTH_SALT',        'put-your-unique-key-here');
define('SECURE_AUTH_SALT', 'put-your-unique-key-here');
define('LOGGED_IN_SALT',   'put-your-unique-key-here');
define('NONCE_SALT',       'put-your-unique-key-here');

/** =========================
 * DATABASE TABLE PREFIX
 * ========================= */

$table_prefix = 'wp_';

/** =========================
 * DEBUG MODE
 * ========================= */

define('WP_DEBUG', false);

/** =========================
 * ABSOLUTE PATH
 * ========================= */

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

/** =========================
 * WORDPRESS SETUP
 * ========================= */

require_once ABSPATH . 'wp-settings.php';

