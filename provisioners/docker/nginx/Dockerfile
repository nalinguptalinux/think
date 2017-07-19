FROM ubuntu:16.10
MAINTAINER Devops <devops@iproperty.com>

ARG market
RUN apt-get update \
    &&  apt-get install  -y nginx nginx-extras
COPY $market /etc/nginx/nginx.conf
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

####   Only for Newrelic    ###########
RUN apt-get  install -y wget curl vim  sudo apt-utils
RUN wget -O- http://nginx.org/keys/nginx_signing.key | sudo apt-key add -
RUN echo "deb http://nginx.org/packages/ubuntu/ yakkety nginx" >>  /etc/apt/sources.list.d/nginx.list \
        && echo "deb-src http://nginx.org/packages/ubuntu/ yakkety nginx" >> /etc/apt/sources.list.d/nginx.list
RUN apt-get update \
        && apt-get install  -y nginx-nr-agent \
        && rm -rf /var/lib/apt/lists/*
COPY nginx-nr-agent.ini /etc/nginx-nr-agent/nginx-nr-agent.ini

#### END Task #######
COPY htpasswd /etc/nginx/.htpasswd
COPY entrypoint.sh /entrypoint.sh
RUN /usr/sbin/update-rc.d -f nginx disable
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
