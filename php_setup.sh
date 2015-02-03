#!/usr/bin/env bash
echo "php_setup.sh start"

VAGRANT_HOME_DIR=$1

#---------------------------------------------------------------------
# PHP(5.4)インストール
#---------------------------------------------------------------------
echo "Installing PHP"
yum -y install php54 php54-mbstring php54-gd php54-pdo php54-mysql php54-mcrypt


#---------------------------------------------------------------------
# PHP設定変更
#---------------------------------------------------------------------
echo "Updating PHP config"
cp -p /etc/php.ini /etc/php.ini.org
sed -i 's|^.*date.timezone.*|date.timezone = Asia/Tokyo|g' /etc/php.ini

sed -i 's/^memory_limit.*/memory_limit = 256M/g' /etc/php.ini

sed -i 's/^;error_log = php_errors.log/error_log = php_errors.log/g' /etc/php.ini

sed -i 's/^;mbstring.language.*/mbstring.language = Japanese/g' /etc/php.ini
sed -i 's/^;mbstring.internal_encoding.*/mbstring.internal_encoding = UTF-8/g' /etc/php.ini
sed -i 's/^;mbstring.http_input.*/mbstring.http_input = auto/g' /etc/php.ini
sed -i 's/^;mbstring.detect_order.*/mbstring.detect_order = auto/g' /etc/php.ini

echo "php_setup.sh end status="$?