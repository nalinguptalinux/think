#!/bin/sh -ex
env

# install dependencies
sudo yum -y install gcc ruby-devel logrotate rubygems20 aws-cli libxslt-devel libyaml-devel libxml2-devel gdbm-devel libffi-devel zlib-devel openssl-devel readline-devel curl-devel pcre-devel git memcached-devel valgrind-devel ImageMagick-devel ImageMagick
sudo yum install --enablerepo epel -y daemonize

function install_from_s3 {
echo $@
    aws s3 cp s3://${1}/${2}/${3} /tmp/${3} --region ${4} --debug
    echo "Downloaded: /tmp/${3}"
    sudo yum install -y /tmp/${3}
    echo "Installed: /tmp/${3}"
}

#Java Setup
sudo yum erase -y java-1.7.0-openjdk tmpwatch
install_from_s3 ${ResourceBucket} 'java' ${JavaOpenJDKHeadless} ${Region}
install_from_s3 ${ResourceBucket} 'java' ${JavaOpenJDK} ${Region}

#Newrelic Setup
install_from_s3 ${ResourceBucket} 'newrelic' ${NewRelicRPM} ${Region}
sudo /usr/sbin/nrsysmond-config --set license_key=${NewRelicLicenseKey}
sudo /sbin/chkconfig --add newrelic-sysmond
sudo /sbin/chkconfig newrelic-sysmond on

#Sumologic Setup
aws s3 cp s3://${ResourceBucket}/sumologic/${SumoLogicInstaller} /tmp/${SumoLogicInstaller} --region ${Region}
sudo chmod +x /tmp/${SumoLogicInstaller}
sudo mkdir -p /opt/sumologic/
sudo chmod -R 777 /opt/sumologic
echo '{"api.version": "v1","sources": []}' > /opt/sumologic/sources.json
sudo /tmp/${SumoLogicInstaller}  -q -VskipRegistration=true -Vephemeral=true -Vsources=/opt/sumologic/sources.json -Vsumo.accessid=${SumoLogicAccessId} -Vsumo.accesskey=${SumoLogicAccessKey}


# Install Ruby
RUBY=ruby-2.1.5
aws s3 cp s3://${ResourceBucket}/ruby/${Ruby} /tmp/${Ruby} --region ${Region}
tar zxvf /tmp/${Ruby} -C /tmp/ && cd /tmp/ruby* && sudo ./configure && sudo make && sudo make install
install_from_s3 ${ResourceBucket} 'ruby' ${RubyGems} ${Region}
sudo gem install bundler io-console --no-ri --no-rdoc

#Setup NTP for time correction
sudo service ntpd restart
sudo chkconfig ntpd on
sudo chkconfig --list ntpd
sudo ntpstat || echo 'Time not in sync yet, hopefully at next boot of this ami'

#For gem ffi just in case
sudo ln -s /usr/lib64/libffi.so.6.0.1 /usr/lib64/libffi.so.5

#Cleanup and Exit
sudo yum clean all
sudo rm -f /home/ec2-user/.ssh/authorized_keys
sudo rm -f /root/.ssh/authorized_keys
sudo rm -rf /tmp/*
echo 'installation complete'
