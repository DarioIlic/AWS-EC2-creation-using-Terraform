#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2

rm -rf /var/www/html/index.html
echo ' "Hello Dhimahi" ' >> /var/www/html/index.html
