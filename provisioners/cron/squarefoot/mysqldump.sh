#!/usr/bin/env bash

export mysql_password=password
mkdir -p /tmp/mysqldump/
aws s3 cp s3://prod-sg-sfhk-backups/legacy-mysqldump/`date +%F`/backup_data/sf-www.sql.gz /tmp/mysqldump/sf-www.sql.gz --region ap-southeast-1
zcat /tmp/mysqldump/sf-www.sql.gz | mysql -P'3306' -h'rds.production.squarefoot-singapore.ipga.local' -u'root' -p"$mysql_password" sf-www