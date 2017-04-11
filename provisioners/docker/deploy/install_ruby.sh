#!/bin/sh
# install dependencies
yum -y install tar gcc libxslt-devel libyaml-devel libxml2-devel gdbm-devel libffi-devel zlib-devel openssl-devel libyaml-devel readline-devel curl-devel openssl-devel pcre-devel git memcached-devel valgrind-devel ImageMagick-devel ImageMagick

# build ruby 2.1.5
RUBY=ruby-2.1.5
curl http://ftp.ruby-lang.org/pub/ruby/2.1/$RUBY.tar.gz > $RUBY.tar.gz
tar zxvf $RUBY.tar.gz
cd $RUBY
./configure
make && make install
cd .. && rm -rf $RUBY

gem install rea-assuming --source http://rubygems.delivery.realestate.com.au --no-rdoc --no-ri
