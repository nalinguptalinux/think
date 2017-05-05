#!/usr/bin/env bash

sed -i 's/mysql_password=password/mysql_password=<pass>/g' /opt/legacy-cron-scripts/mysqldump.sh

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0 5 * * * /opt/legacy-cron-scripts/mysqldump.sh && echo `date` > /var/log/legacy-cron.log" >> mycron
#install new cron file
crontab mycron
rm mycron