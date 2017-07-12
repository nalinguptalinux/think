#!/bin/bash

## Setup the hosts file and hostname.
function configure_hosts {
    recordName="${record_name}"
    instance_ip=$(curl -q http://169.254.169.254/latest/meta-data/local-ipv4)
    domain=$(awk '/^search/ { print $2 }' /etc/resolv.conf)
    ipend=`echo $instance_ip | sed 's/\\./\\-/g'`
    echo "$instance_ip $recordName.$domain  $recordName">> /etc/hosts
    hostname $recordName
    echo $recordName > /etc/hostname
}

configure_hosts
yum update -y