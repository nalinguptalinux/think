FROM ubuntu:trusty

#ARG market
ARG market
ENV MARKET $market

MAINTAINER Devops <devops@iproperty.com>
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y nginx nginx-extras \
 && rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log

####   Only for Newrelic    ###########
RUN wget -O- http://nginx.org/keys/nginx_signing.key | sudo apt-key add -
RUN echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >>  /etc/apt/sources.list.d/nginx.list \
        && echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list
RUN apt-get update \
        && apt-get install -y nginx-nr-agent \
        && rm -rf /var/lib/apt/lists/*
COPY nginx-nr-agent.ini /etc/nginx-nr-agent/nginx-nr-agent.ini
#### END #######

COPY ${MARKET} /etc/nginx/nginx.conf
COPY nginx.cnf /etc/nginx/nginx.conf
COPY htpasswd /etc/nginx/.htpasswd
COPY entrypoint.sh /entrypoint.sh
RUN /usr/sbin/update-rc.d -f nginx disable
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
