#!/bin/bash
set -e

# Execute replacements for the internal ELB urls

if [[ ! -z "$1" ]] && [[ ! -z "$2" ]];
then
        /bin/sed -i "s|<HP_INTERNAL_ELB>|$1|g" /etc/nginx/nginx.conf
        /bin/sed -i "s|<SRPPDP_INTERNAL_ELB>|$2|g" /etc/nginx/nginx.conf
        /bin/sed -i "s|vpc-dns|$3|g" /etc/nginx/nginx.conf      #######   For DNS change
        /bin/sed -i "s|<STACK_NAME>|$4|g" /etc/nginx/nginx.conf
fi

/usr/sbin/nginx -g 'daemon off;'
