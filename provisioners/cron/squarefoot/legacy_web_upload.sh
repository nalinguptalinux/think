#!/usr/bin/env bash

echo 'creating archive'
tar -zcvf legacy-web.tar.gz /var/www/html
echo "Syncing to s3..."
aws s3 cp legacy-web.tar.gz s3://prod-sg-sfhk-backups/legacy-web.tar.gz --region ap-southeast-1
rm legacy-web.tar.gz
