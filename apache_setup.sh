#!/usr/bin/env bash
echo "apache_setup.sh start"

VAGRANT_HOME_DIR=$1

#---------------------------------------------------------------------
# Apache(2.4)インストール
#---------------------------------------------------------------------
echo "Installing Apache"
yum -y install httpd24

#---------------------------------------------------------------------
# Apache設定変更
#---------------------------------------------------------------------
echo "Updating Apache config"
cp -p /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.org
#echo "ServerName localhost" > /etc/httpd/conf/httpd.conf

#---------------------------------------------------------------------
# Apacheサーバ起動
#---------------------------------------------------------------------
echo "Starting Apache"
service httpd start
chkconfig httpd on

echo "apache_setup.sh end status="$?