#!/usr/bin/env bash
echo "aws_bootstrap.sh start"

# タイムゾーン変更
sudo cp -p /usr/share/zoneinfo/Japan /etc/localtime

# AWSのVolumeのリサイズ（デフォルトだと8GBのため）
#sudo resize2fs /dev/sda1

# yum更新
sudo yum -y update

# Apache(2.4)インストール
echo "Installing Apache"
sudo yum -y install httpd24

# PHP(5.4)インストール
echo "Installing PHP"
sudo yum -y install php54 php54-mbstring php54-gd php54-pdo php54-mysql php54-mcrypt

# MySQL(5.6)インストール
echo "Installing MySQL"
sudo yum -y remove mysql55*


sudo yum -y install http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
sudo yum -y install mysql
#sudo yum -y install mysql-server

# Apache設定変更
echo "Updating Apache config"
cp -p /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.org
# <Directory "/var/www/html">
#     AllowOverride All
# </Directory>

#touch /etc/httpd/conf.d/vhosts.conf
#chown vagrant: /etc/httpd/conf.d/vhosts.conf
#NameVirtualHost *:80
#<VirtualHost *:80>
#  DocumentRoot /var/www/html/public
#</VirtualHost>

# PHP設定変更
echo "Updating PHP config"
cp -p /etc/php.ini /etc/php.ini.org
sed -i 's|^.*date.timezone.*|date.timezone = Asia/Tokyo|' /etc/php.ini

# MySQL設定変更
echo "Updating MySQL config"
#cp /etc/my.cnf /etc/my.cnf.org

# CakePHPセットアップ
echo "Installing CakePHP"
sudo mkdir /var/www/html/public
sudo chown -R vagrant: /var/www/html/public

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

#cp -p /home/ec2-user/vagrant/public/composer.json /var/www/html/public/

#composer install --no-dev
#composer install --dev
#/var/www/html/Vendor/cake bake project cake-sample

#sudo chmod -R 0777 /var/www/html/cake-sample/tmp
#sudo chmod -R 0777 /var/www/html/cake-sample/Console

#database.php

# データベース設定

# Apache起動
echo "Starting Apache"
sudo service httpd start
sudo chkconfig httpd on

# MySQL起動
#echo "Starting MySQL"
#sudo service mysqld start
#sudo chkconfig mysqld on

echo "aws_bootstrap.sh end status="$?
