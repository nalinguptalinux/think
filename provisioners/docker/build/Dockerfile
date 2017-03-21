FROM centos:centos6

MAINTAINER Hash <harshad.wankhede@rea-group.com>

RUN yum install -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm java-1.8.0-openjdk-devel
RUN yum install -y rpm-build

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0

RUN yum -y install nodejs npm
RUN yum install -y python-pip make gcc python-devel && pip install awscli

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0

COPY install_ruby.sh /root/install_ruby.sh
RUN /root/install_ruby.sh