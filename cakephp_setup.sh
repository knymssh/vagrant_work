#!/usr/bin/env bash
echo "Installing CakePHP"

CAKEPHP_DIR=$1
cd ${CAKEPHP_DIR}

# Gitをインストール
yum -y install git

#---------------------------------------------------------------------
# composer.pharをダウンロード
#---------------------------------------------------------------------
curl -sS https://getcomposer.org/installer | php
#sudo mv composer.phar /usr/local/bin/composer

#---------------------------------------------------------------------
# インストール実行
#---------------------------------------------------------------------
php composer.phar install --no-dev
#php composer.phar install --dev

#---------------------------------------------------------------------
# アプリケーション取得
#---------------------------------------------------------------------
#git clone https://github.com/YYYYYY/XXXXX.git
