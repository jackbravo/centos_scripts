#!/bin/bash

cd ~/build
wget http://apache.webxcreen.org/lucene/solr/4.5.1/solr-4.5.1.tgz
tar -zxf solr-4.5.1.tgz
mkdir -p /opt/solr/drupal/
mv solr-4.5.1/example/solr /opt/solr/drupal/solr
mv solr-4.5.1/dist/solr-4.5.1.war /opt/solr/drupal/solr/solr.war
mv solr-4.5.1/example/lib/ext/* /usr/share/tomcat6/lib/
mv solr-4.5.1/example/resources/log4j.properties /usr/share/tomcat6/lib/
sed -i 's/=logs/=\/var\/log\/tomcat6/g' /usr/share/java/tomcat6/log4j.properties
#sed -i 's/data.dir:/data.dir:\/opt\/solr\/drupal\/solr\/data/g' /opt/solr/drupal/solr/collection1/conf/solrconfig.xml
mkdir /opt/solr/drupal/solr/collection1/data
chown tomcat:tomcat /opt/solr/drupal/solr/collection1/data

git clone --branch 7.x-1.x http://git.drupal.org/project/search_api_solr.git
cp search_api_solr/solr-conf/4.x/* /opt/solr/drupal/solr/collection1/conf/

tee /etc/tomcat6/Catalina/localhost/solr-drupal.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<Context docBase="/opt/solr/drupal/solr/solr.war" debug="0" crossContext="true">
  <Environment name="solr/home" type="java.lang.String" value="/opt/solr/drupal/solr" override="true"/>
</Context>
EOF

yum install -y tomcat6

/sbin/chkconfig --levels 235 tomcat6 on
/etc/init.d/tomcat6 start
