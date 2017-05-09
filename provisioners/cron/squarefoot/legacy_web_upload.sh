#!/usr/bin/env bash

#echo 'creating archive'
#tar -zcvf legacy-web.tar.gz --exclude='/var/www/html/emagazine' /var/www/html
echo "Syncing to s3..."
aws s3 sync /var/www/html s3://prod-sg-sfhk-backups/legacy-web --exclude 'emagazine/*' --region ap-southeast-1
#rm legacy-web.tar.gz
