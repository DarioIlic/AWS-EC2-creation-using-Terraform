#! /bin/bash
sudo apt-get update
sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip -y

sudo systemctl start apache2
sudo systemctl enable apache2

yes '' | rm -rf /var/www/html/*
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz

cat <<EOF > /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
    DocumentRoot /var/www/html/wordpress
    <Directory /var/www/html/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /var/www/html/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
EOF

sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo service apache2 reload

mysql -e "CREATE DATABASE wordpress;"
mysql -e "CREATE USER wordpress@localhost IDENTIFIED BY 'DB Password';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

sed -i 's/database_name_here/wordpress/' /var/www/html/wordpress/wp-config.php
sed -i 's/username_here/wordpress/' /var/www/html/wordpress/wp-config.php
sed -i 's/password_here/DB Password/' /var/www/html/wordpress/wp-config.php

chown -R www-data:www-data /var/www/html
