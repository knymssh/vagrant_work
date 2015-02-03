#!/usr/bin/env bash
echo "jenkins_setup.sh start"

VAGRANT_HOME_DIR=$1

#---------------------------------------------------------------------
# Jenkins本体をインストール
#---------------------------------------------------------------------
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum -y install jenkins

#---------------------------------------------------------------------
# Jenkins起動
#---------------------------------------------------------------------
service jenkins start
chkconfig jenkins on

#---------------------------------------------------------------------
# プラグインをインストール
#---------------------------------------------------------------------
#wget http://localhost:8080/jnlpJars/jenkins-cli.jar
#java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin checkstyle cloverphp dry htmlpublisher jdepend plot pmd violations xunit
#curl -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' | curl -X POST -H 'Accept: application/json' -d @- http://localhost:8080/updateCenter/byId/default/postBack
#java -jar jenkins-cli.jar -s http://localhost:8080 safe-restart

#cp -f ${VAGRANT_HOME_DIR}/jenkins/build.xml

echo "jenkins_setup.sh end status="$?
