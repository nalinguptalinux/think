#!/usr/bin/env bash

export mysql_password=password
mkdir -p /tmp/mysqldump/
aws s3 cp s3://prod-sg-sfhk-backups/legacy-mysqldump/`date +%F`/backup_data/sf-www.sql.gz /tmp/mysqldump/sf-www.sql.gz --region ap-southeast-1
zcat /tmp/mysqldump/sf-www.sql.gz | mysql -P'3306' -h'squarefoot-rds-mysql-b.ciln4pjvy5g8.ap-southeast-1.rds.amazonaws.com' -u'root' -p'$mysql_password' sf-www