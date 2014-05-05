#!/bin/bash

rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-3.0/el6/noarch/varnish-release/varnish-release-3.0-1.el6.noarch.rpm
yum install -y varnish

cd /etc/varnish
mv default.vcl default.vcl.orig
wget https://gist.github.com/jackbravo/7225521/raw/d76b4070b0ef0d700f85eec0ac48ae35ada7431d/default.vcl

### Important!!!
# edit /etc/sysconfig/varnish
# edit /etc/varnish/default.vcl to set IP of drupal server

/sbin/chkconfig --levels 235 varnish on
/sbin/chkconfig --levels 235 varnishlog on
/etc/init.d/varnish start
/etc/init.d/varnishlog start
