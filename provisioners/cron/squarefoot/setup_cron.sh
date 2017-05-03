#!/usr/bin/env bash

sed -i 's/mysql_password=password/mysql_password={password_here}/g' /opt/legacy-cron-scripts/mysqldump_apply.sh

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0 0 18 1/1 * ? * /opt/legacy-cron-scripts/mysqldump_apply.sh > /var/log/legacy-cron.log && echo date >> /var/log/legacy-cron.log" >> mycron
#install new cron file
crontab mycron
rm mycron