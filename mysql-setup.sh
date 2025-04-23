#!/bin/bash
exec > >(tee /var/log/mysql-setup.log) 2>&1

# Update system
apt update
apt upgrade -y

# Install MySQL server
apt-get install -y mysql-server

# Configure MySQL to allow remote connections
sed -i 's/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Create database and user
mysql -e "CREATE DATABASE app_db;"
mysql -e "CREATE USER 'app_user'@'%' IDENTIFIED BY 'app_user';"
mysql -e "GRANT ALL PRIVILEGES ON app_db.* TO 'app_user'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Restart MySQL
systemctl restart mysql
