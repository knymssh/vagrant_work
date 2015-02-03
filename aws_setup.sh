#!/usr/bin/env bash
echo "aws_setup.sh start"

VAGRANT_HOME_DIR=$1

#---------------------------------------------------------------------
# EC2基本設定
#---------------------------------------------------------------------
# タイムゾーン変更
cp -p /usr/share/zoneinfo/Japan /etc/localtime

# AWSのVolumeのリサイズ（デフォルトだと8GBのため）
#sudo resize2fs /dev/sda1

# IPテーブルセットアップ

# 基本ボリシーの設定
## 入力（受信）パケットの通過を許可
#iptables -P INPUT ACCEPT
## フォワードするパケットの通過を許可
#iptables -P FORWARD ACCEPT
## 出力（送信）パケットの通過を許可
#iptables -P OUTPUT ACCEPT

# iptableの初期化
#iptables -F

# iptableの再起動
#service iptables save
#service iptables restart

#---------------------------------------------------------------------
# 各種ソフトウェアをセットアップ
#---------------------------------------------------------------------
echo "Installing software"
# yum更新
yum -y update

# PHPセットアップ
./php_setup.sh ${VAGRANT_HOME_DIR}

# Apacheセットアップ
DOC_ROOT_PATH=/var/www/html
./apache_setup.sh ${VAGRANT_HOME_DIR}

# MySQLセットアップ
./mysql_setup.sh ${VAGRANT_HOME_DIR}

# CakePHPセットアップ
cp -rf ${VAGRANT_HOME_DIR}/public ${DOC_ROOT_PATH}

./cakephp_setup.sh ${DOC_ROOT_PATH}/public/
chown -R ec2-user: ${DOC_ROOT_PATH}/public/

# Apache設定変更
touch /etc/httpd/conf.d/vhosts.conf
chown vagrant: /etc/httpd/conf.d/vhosts.conf
cat <<EOF > /etc/httpd/conf.d/vhosts.conf
NameVirtualHost *:80
<VirtualHost *:80>
    DocumentRoot "/var/www/html/public"
    ServerName localhost
    <Directory "/var/www/html/public">
        AllowOverride All
    </Directory>
</VirtualHost>
EOF

#---------------------------------------------------------------------
# Apache再起動
#---------------------------------------------------------------------
echo "Restarting Apache"
service httpd restart

# Jenkinsセットアップ
#./jenkins_setup.sh ${VAGRANT_HOME_DIR}

echo "aws_setup.sh end status="$?