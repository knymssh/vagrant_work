#!/usr/bin/env bash
echo "aws_bootstrap.sh start"

VAGRANT_HOME_DIR=/vagrant
cd ${VAGRANT_HOME_DIR}
sudo ./aws_setup.sh ${VAGRANT_HOME_DIR}

echo "aws_bootstrap.sh end status="$?
