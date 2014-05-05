#!/bin/bash

yum install -y mysql-server
/sbin/chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start
mysql_secure_installation
