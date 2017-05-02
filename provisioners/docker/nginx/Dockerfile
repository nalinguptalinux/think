FROM ubuntu:trusty

MAINTAINER Devops <devops@iproperty.com>

RUN apt-get update
RUN apt-get install wget curl  -y
RUN apt-get install -y nginx nginx-extras

COPY nginx.conf /etc/nginx/nginx.conf
COPY htpasswd /etc/nginx/.htpasswd
COPY entrypoint.sh /entrypoint.sh

RUN /usr/sbin/update-rc.d -f nginx disable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
