#!/usr/bin/env bash

#requirements
#PHP 5.1.6 (cli) (built: Mar 19 2014 03:12:16)
#CentOS release 5.10 (Final)
#Python 2.7.13
#Perl - Latest
# how to add new users to aws http://www.ampedupdesigns.com/blog/show?bid=44
# how to install cfn-init scripts on redhat and centos maybe


cd /var/www/html
sed -i 's/573266-db2.squarefoot.com.hk/rds.production.squarefoot-singapore.ipga.local/g' *
find ./ -type f -exec sed -i -e  's/573266-db2.squarefoot.com.hk/rds.production.squarefoot-singapore.ipga.local/g' {} \;

grep -rnw '/etc/httpd' -e '573266-db2.squarefoot.com.hk'


#yum install php-common php-mbstring php-imap php-pdo php-pear php php-xml php-gd php-devel php-cli php-mysql
#
#php-common-5.1.6-44.el5_10.x86_64
#php-mbstring-5.1.6-44.el5_10.x86_64
#php-imap-5.1.6-44.el5_10.x86_64
#php-pdo-5.1.6-44.el5_10.x86_64
#php-pear-1.4.9-8.el5.noarch
#php-5.1.6-44.el5_10.x86_64
#php-xml-5.1.6-44.el5_10.x86_64
#php-gd-5.1.6-44.el5_10.x86_64
#php-devel-5.1.6-44.el5_10.x86_64
#php-cli-5.1.6-44.el5_10.x86_64
#php-mysql-5.1.6-44.el5_10.x86_64
#
#
#openssl-0.9.8e-40.el5_11.x86_64
#openssl-devel-0.9.8e-40.el5_11.i386
#openssl-0.9.8e-40.el5_11.i686
#openssl-devel-0.9.8e-40.el5_11.x86_64


#php -v

# CentOS-Testing:
# !!!! CAUTION !!!!
# This repository is a proving grounds for packages on their way to CentOSPlus and CentOS Extras.
# They may or may not replace core CentOS packages, and are not guaranteed to function properly.
# These packages build and install, but are waiting for feedback from testers as to
# functionality and stability. Packages in this repository will come and go during the
# development period, so it should not be left enabled or used on production systems without due
## consideration.
#[c5-testing]
#name=CentOS-5 Testing
#baseurl=http://dev.centos.org/centos/$releasever/testing/$basearch/
#enabled=1
#gpgcheck=1
#gpgkey=http://dev.centos.org/centos/RPM-GPG-KEY-CentOS-testing
#includepkgs=php*
