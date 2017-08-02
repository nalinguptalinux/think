#!/bin/bash
set -e

# Execute  replacements for the internal ELB urls

if [[ ! -z "$1" ]] && [[ ! -z "$2" ]];
then
        /bin/sed -i "s|<HP_INTERNAL_ELB>|$1|g" /etc/nginx/nginx.conf                            #######  HP ELB  change #
        /bin/sed -i "s|<SRPPDP_INTERNAL_ELB>|$2|g" /etc/nginx/nginx.conf                        #######  SRP Elb  change #
        /bin/sed -i "s|vpc-dns|$3|g" /etc/nginx/nginx.conf                                      #######  For VPC DNS change #
        /bin/sed -i "s|<VERSION>|$4|g" /etc/nginx-nr-agent/nginx-nr-agent.ini                   #######  New-relic-version-append #
        /bin/sed -i "s|Front-end|Front-end-$4|g" /etc/nginx/nginx.conf                          #######  Header update #
        /bin/sed -i "s|New_Relic_Key|$5|g" /etc/nginx-nr-agent/nginx-nr-agent.ini               #######  New-relic Key #
        /bin/sed -i "s|Replace-with-host|Nginx-$7-$6|g" /etc/nginx-nr-agent/nginx-nr-agent.ini  #######  New-relic-Hostname-Project-Deployment-ID #
        /usr/sbin/service nginx-nr-agent start                                                  #######  Service start #
        /bin/echo $? >> /root/last-status.txt                                                   #######  Last Status #
fi

# Basic Auth Config
if [ "True" = "$8" ] ; then
    echo "Basic Auth is enabled"
else
        /bin/sed -i "s|auth_basic|#auth_basic|g" /etc/nginx/nginx.conf                          #######  Basic Auth remove #
        /bin/echo "Basic Auth is disabled"
fi

/usr/sbin/nginx -g 'daemon off;'
