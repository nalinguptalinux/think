FROM ubuntu:trusty

MAINTAINER Devops <devops@iproperty.com>

RUN apt-get update
RUN apt-get install -y nginx nginx-extras \
 && rm -rf /var/lib/apt/lists/*


# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf
COPY htpasswd /etc/nginx/.htpasswd
COPY entrypoint.sh /entrypoint.sh

RUN /usr/sbin/update-rc.d -f nginx disable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
