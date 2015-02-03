#!/usr/bin/env bash
echo "mysql_setup.sh start"

VAGRANT_HOME_DIR=$1

#---------------------------------------------------------------------
# MySQLインストール
#---------------------------------------------------------------------
echo "Installing MySQL"
version = 55
if $version -eq 56
then
  # 5.6インストール
  yum -y remove mysql55*
  yum -y install http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
fi

yum -y install mysql mysql-server

#---------------------------------------------------------------------
# MySQL設定変更
#---------------------------------------------------------------------
echo "Updating MySQL config"
cp /etc/my.cnf /etc/my.cnf.org

#---------------------------------------------------------------------
# MySQLサーバ起動
#---------------------------------------------------------------------
echo "Starting MySQL"
service mysqld start
chkconfig mysqld on

#---------------------------------------------------------------------
# データベース生成
#---------------------------------------------------------------------
echo "Set up database"
# データベース生成
#mysqladmin -u root create testdb
echo "CREATE DATABASE IF NOT EXISTS testdb" | mysql

#---------------------------------------------------------------------
# ユーザ設定
#---------------------------------------------------------------------
# ユーザ生成
echo "CREATE USER 'test'@'localhost' IDENTIFIED BY 'test'" | mysql
# ユーザ権限設定
echo "GRANT ALL PRIVILEGES ON testdb.* TO 'test'@'localhost' IDENTIFIED BY 'test'" | mysql

# rootのパスワード設定
mysqladmin -u root password root

echo "mysql_setup.sh end status="$?