FROM centos:centos7

MAINTAINER Hash <harshad.wankhede@rea-group.com>
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y make gcc wget python-pip python-devel

RUN curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
RUN yum -y install nodejs

RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
RUN yum install -y yarn

COPY install_ruby.sh /root/install_ruby.sh
RUN /root/install_ruby.sh

RUN pip install awscli boto ansible
