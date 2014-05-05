#!/bin/bash

tee /etc/yum.repos.d/nginx.repo <<EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/x86_64/
gpgcheck=0
enabled=1
EOF

yum install -y nginx
sed -i 's/worker_processes  1/worker_processes  4/g' /etc/nginx/nginx.conf
sed -i 's/keepalive_timeout  65/keepalive_timeout  10/g' /etc/nginx/nginx.conf
/sbin/chkconfig --levels 235 nginx on
/etc/init.d/nginx start

# left out php-imap php-ldap php-odbc 
yum install -y php-fpm php-cli php-mysql php-gd php-pear php-xml php-xmlrpc php-mbstring php-soap php-tidy php-pecl-apc
# 1024M should be more than enough for all drupal files
sed -i 's/apc.shm_size=64M/apc.shm_size=1024M/g' /etc/php.d/apc.ini
# http://wiki.nginx.org/Pitfalls
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini
# set timezone
echo "date.timezone = 'America/Mexico_City'" >> /etc/php.ini
# use socket for php-fpm
sed -i 's/127.0.0.1:9000/\/var\/run\/php5-fpm.sock/g' /etc/php-fpm.d/www.conf

/sbin/chkconfig --levels 235 php-fpm on
/etc/init.d/php-fpm start

cd /root
git clone https://github.com/drush-ops/drush.git
ln -s /root/drush/drush /usr/local/bin/drush

cd /var/www
drush dl drupal
