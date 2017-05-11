#!/usr/bin/env bash

#install python 2.7 on centos 6.7

sudo yum groupinstall -y "Development tools"
sudo yum install -y epel-release zlib-devel  bzip2-devel openssl-devel ncurses-devel sqlite-devel wget

make altinstall
cd /usr/src
wget http://python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz
tar xf Python-2.7.13.tar.xz
cd Python-2.7.13
./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
make && make altinstall

#++starts amazon linux here

yum install -y httpd #version is 2.2.15-59.el6.centos

wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-5.1.6-45.el5_11.x86_64.rpm
wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-cli-5.1.6-45.el5_11.x86_64.rpm
wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-common-5.1.6-45.el5_11.x86_64.rpm
wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-gd-5.1.6-45.el5_11.x86_64.rpm
wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-mbstring-5.1.6-45.el5_11.x86_64.rpm
wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-xml-5.1.6-45.el5_11.x86_64.rpm
wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-pdo-5.1.6-45.el5_11.x86_64.rpm
wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-devel-5.1.6-45.el5_11.x86_64.rpm
wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-mysql-5.1.6-45.el5_11.x86_64.rpm
wget http://ftp.uci.edu/centos/5/updates/x86_64/RPMS/php-imap-5.1.6-45.el5_11.x86_64.rpm
wget ftp://rpmfind.net/linux/remi/enterprise/5/remi/x86_64/compat-libcurl3-7.15.5-3.el5.remi.x86_64.rpm
wget https://dl.iuscommunity.org/pub/ius/archive/CentOS/5/x86_64/mysqlclient15-5.0.92-3.ius.centos5.x86_64.rpm
wget ftp://ftp.icm.edu.pl/vol/rzm5/linux-scientificlinux/obsolete/58/i386/SL/php-pear-1.4.9-8.el5.noarch.rpm
wget http://ftp.pbone.net/mirror/www.startcom.org/AS-5.0.1/os/x86_64/StartCom/RPMS/libc-client-2004g-2.2.1.x86_64.rpm


yum install -y libcrypto.so.6 libssl.so.6 openssl098e-0.9.8e libcclient.so.1
rpm -Uvh compat-libcurl3-7.15.5-3.el5.remi.x86_64.rpm

yum install -y libpcap
rpm -Uvh mysqlclient15-5.0.92-3.ius.centos5.x86_64.rpm

yum localinstall -y php-5.1.6-45.el5_11.x86_64.rpm php-devel-5.1.6-45.el5_11.x86_64.rpm php-cli-5.1.6-45.el5_11.x86_64.rpm php-common-5.1.6-45.el5_11.x86_64.rpm php-pdo-5.1.6-45.el5_11.x86_64.rpm

yum localinstall -y libc-client-2004g-2.2.1.x86_64.rpm
yum localinstall -y php-pear-1.4.9-8.el5.noarch.rpm php-imap-5.1.6-45.el5_11.x86_64.rpm php-xml-5.1.6-45.el5_11.x86_64.rpm php-gd-5.1.6-45.el5_11.x86_64.rpm php-mbstring-5.1.6-45.el5_11.x86_64.rpm php-mysql-5.1.6-45.el5_11.x86_64.rpm

#yum install -y mod_perl mod_ssl

