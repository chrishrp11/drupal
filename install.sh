#!/bin/bash
# Description: shell script to install drupal 
# Author:Krishna
# Date Created:28/09/2023
# Install required packages and start httpd service/
sudo dnf install wget php php-mysqlnd php-mysqli httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl restart httpd
# Download and extract drupal
cd /var/www/html
sudo wget https://www.drupal.org/download-latest/tar.gz -O drupal.tar.gz
sudo tar -xvzf drupal.tar.gz
sudo rm -rf drupal.tar.gz
sudo mv drupal-10.1.4 drupal
# Change permissions to drupal
sudo chown -R apache:apache /var/www/html/drupal
# Update DocumentRoot in httpd.conf
sudo sed -i 's/DocumentRoot "\/var\/www\/html"/DocumentRoot "\/var\/www\/html\/drupal"/' /etc/httpd/conf/httpd.conf
# Server configuration for Clean URLs on a dedicated server, with httpd.conf
sudo sed -i '156s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
# Restart httpd service
sudo systemctl restart httpd

# Install required the PHP 8.2 packaged by Remi
sudo dnf update
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm
sudo dnf module list php
sudo dnf module install php:remi-8.2
sudo dnf install php-gd
sudo dnf update
sudo systemctl restart httpd







