#!/usr/bin/env bash

if [ $# -ne 4 ]; then
  echo "実行するには4個の引数が必要です。" 1>&2
  exit 1
fi

#CAKEPHP_DIR=$(cd $(dirname $0); pwd)
CAKEPHP_APP_NAME=$1
DATABASE_NAME=$2
DATABASE_USER=$3
DATABASE_PASSWORD=$4

#---------------------------------------------------------------------
# アプリケーションひな形生成
#---------------------------------------------------------------------
# bake実行
Vendor/bin/cake bake project ${CAKEPHP_APP_NAME}

# パス修正

## webroot/index.php
sed -i "s|^define('CAKE_CORE_INCLUDE_PATH',.*|define('CAKE_CORE_INCLUDE_PATH', ROOT . '/Vendor/cakephp/cakephp/lib');|g" ${CAKEPHP_APP_NAME}/webroot/index.php

## webroot/test.php
sed -i "s|^define('CAKE_CORE_INCLUDE_PATH',.*|define('CAKE_CORE_INCLUDE_PATH', ROOT . '/Vendor/cakephp/cakephp/lib');|g" ${CAKEPHP_APP_NAME}/webroot/test.php

## Config/bootstrap.php 
cat <<EOF >> ${CAKEPHP_APP_NAME}/Config/bootstrap.php

App::build(array(
  'Vendor' => array(ROOT . DS . 'Vendor' . DS),
  'Plugin' => array(ROOT . DS . 'Plugin' . DS)
));

// composerのautoloadを読み込み
require ROOT . DS . 'Vendor' . DS . 'autoload.php';
// CakePHPのオートローダーをいったん削除し、composerより先に評価されるように先頭に追加する
// https://github.com/composer/composer/commit/c80cb76b9b5082ecc3e5b53b1050f76bb27b127b を参照
spl_autoload_unregister(array('App', 'load'));
spl_autoload_register(array('App', 'load'), true, true);

// プラグインロード追加
CakePlugin::loadAll();
//CakePlugin::load('DebugKit');
EOF

## Console/cake.php
sed -i "s|^ini_set('include_path',.*|ini_set('include_path', $root . PATH_SEPARATOR . $root . $ds . 'Vendor' . $ds . 'cakephp' . $ds . 'cakephp' . $ds . 'lib' . PATH_SEPARATOR . ini_get('include_path'));|g" ${CAKEPHP_APP_NAME}/Console/cake.php

# Permission変更
chmod -R 0777 ${CAKEPHP_APP_NAME}/tmp
chmod -R 0777 ${CAKEPHP_APP_NAME}/Console

#---------------------------------------------------------------------
# データベース設定
#---------------------------------------------------------------------

## Config/database.php
cp -f ${CAKEPHP_APP_NAME}/Config/database.php.default ${CAKEPHP_APP_NAME}/Config/database.php 
sed -i "s/'login' => 'user'/'login' => '${DATABASE_USER}'/g" ${CAKEPHP_APP_NAME}/Config/database.php
sed -i "s/'password' => 'password'/'password' => '${DATABASE_PASSWORD}'/g" ${CAKEPHP_APP_NAME}/Config/database.php
sed -i "s/'database' => 'database_name'/'database' => '${DATABASE_NAME}'/g" ${CAKEPHP_APP_NAME}/Config/database.php
sed -i "s|//'encoding' => 'utf8',|'encoding' => 'utf8',|g" ${CAKEPHP_APP_NAME}/Config/database.php
