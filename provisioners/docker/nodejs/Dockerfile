FROM centos:centos7

MAINTAINER Liu Liang <liu.liang@rea-group.com>
RUN yum install -y wget
RUN curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
RUN yum -y install nodejs

RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
RUN yum install -y yarn
