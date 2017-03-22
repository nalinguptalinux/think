#!/bin/sh -ex

cat << EOF > /tmp/run-as-root
#!/bin/sh -ex
env
# install dependencies
yum -y install gcc ruby-devel rubygems20 aws-cli libxslt-devel libyaml-devel libxml2-devel gdbm-devel libffi-devel zlib-devel openssl-devel readline-devel curl-devel pcre-devel git memcached-devel valgrind-devel ImageMagick-devel ImageMagick

function install_from_s3 {
echo $@
    aws s3 cp s3://\${1}/\${2}/\${3} /tmp/\${3} --region \${4} --debug
    echo "Downloaded: /tmp/\${3}"
    yum install -y /tmp/\${3}
    echo "Installed: /tmp/\${3}"
}

#Java Setup
yum erase -y java-1.7.0-openjdk tmpwatch
install_from_s3 ${ResourceBucket} 'java' ${JavaOpenJDKHeadless} ${Region}
install_from_s3 ${ResourceBucket} 'java' ${JavaOpenJDK} ${Region}

#Newrelic Setup
install_from_s3 ${ResourceBucket} 'newrelic' ${NewRelicRPM} ${Region}
/usr/sbin/nrsysmond-config --set license_key=${NewRelicLicenseKey}
/sbin/chkconfig --add newrelic-sysmond
/sbin/chkconfig newrelic-sysmond on

#Sumologic Setup
aws s3 cp s3://${ResourceBucket}/sumologic/${SumoLogicInstaller} /tmp/${SumoLogicInstaller} --region ${Region}
/bin/chmod +x /tmp/${SumoLogicInstaller}
mkdir -p /opt/sumologic/
echo '{"api.version": "v1","sources": []}' > /opt/sumologic/sources.json
/tmp/${SumoLogicInstaller}  -q -VskipRegistration=true -Vephemeral=true -Vsources=/opt/sumologic/sources.json -Vsumo.accessid=${SumoLogicAccessId} -Vsumo.accesskey=${SumoLogicAccessKey}


# Install Ruby
RUBY=ruby-2.1.5
aws s3 cp s3://${ResourceBucket}/ruby/${Ruby} /tmp/${Ruby} --region ${Region}
tar zxvf /tmp/${Ruby} -C /tmp/ && cd /tmp/ruby* && ./configure && make && make install
install_from_s3 ${ResourceBucket} 'ruby' ${RubyGems} ${Region} && gem install bundler io-console --no-ri --no-rdoc

#Install Chrony
yum install --enablerepo epel -y daemonize
yum install -y monit chrony
chkconfig chronyd on
service chronyd start
cd /usr/lib64/ && ln -s libffi.so.6.0.1 libffi.so.5 && cd -

#Cleanup and Exit
yum clean all
rm -rf /tmp/*
rm -f /home/ec2-user/.ssh/authorized_keys
rm -f /root/.ssh/authorized_keys
echo 'installation complete'
EOF
cat /tmp/run-as-root
sudo /bin/sh -ex /tmp/run-as-root