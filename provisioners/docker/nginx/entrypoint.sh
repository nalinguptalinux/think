#!/bin/bash
set -e

# Execute  replacements for the internal ELB urls

if [[ ! -z "$1" ]] && [[ ! -z "$2" ]];
then
        /bin/sed -i "s|<HP_INTERNAL_ELB>|$1|g" /etc/nginx/nginx.conf
        /bin/sed -i "s|<SRPPDP_INTERNAL_ELB>|$2|g" /etc/nginx/nginx.conf
        /bin/sed -i "s|vpc-dns|$3|g" /etc/nginx/nginx.conf      #######  For VPC DNS change #
        /bin/sed -i "s|<VERSION>|$4|g" /etc/nginx/nginx.conf
        /bin/sed -i "s|New_Relic_Key|$5|g" /etc/nginx-nr-agent/nginx-nr-agent.ini
        /bin/sed -i "s|Replace-with-host|Nginx-$6|g" /etc/nginx-nr-agent/nginx-nr-agent.ini
        /usr/sbin/service nginx-nr-agent start
fi

/usr/sbin/nginx -g 'daemon off;'
