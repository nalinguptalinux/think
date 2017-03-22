FROM ubuntu:trusty

MAINTAINER Ady Romantika <adyromantika.ahmad@iproperty.com>

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY htpasswd /etc/nginx/.htpasswd
COPY entrypoint.sh /entrypoint.sh

RUN /usr/sbin/update-rc.d -f nginx disable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
