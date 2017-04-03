#!/usr/bin/env python

import sys
import re
import os
import boto3
import time

class Deployment():
    """Class to handle deployments"""

    def __init__(self, new_stack):
        region_name = 'ap-southeast-1'
        self.cloudformation_client = boto3.client('cloudformation', region_name=region_name)
        self.route53_client = boto3.client('route53', region_name=region_name)
        self.elb_client = boto3.client('elb', region_name=region_name)
        self.new_stack = new_stack
        self.new_elb = None
        self.recordname = None
        self.build_number = os.environ['BUILD_NUMBER'] or ""


    def get_facts(self):
        """Gather facts from the output of cf describe"""
        response = self.cloudformation_client.describe_stacks(StackName=self.new_stack)
        for output in response['Stacks'][0]['Outputs']:
            if output['OutputKey'] == 'WebElasticLoadBalancer':
                self.new_elb = output['OutputValue']
                print "Our new ELB is " + self.new_elb
            if output['OutputKey'] == 'RecordName':
                self.recordname = output['OutputValue']
                print "Our DNS name is " + self.recordname


    def delete_old_stack(self):
        """Delete the old stack"""
        response = self.cloudformation_client.list_stacks(
            StackStatusFilter=['CREATE_COMPLETE']
        )

        for stack in response['StackSummaries']:
            if not re.match('frontend-.*', stack['StackName']):
                print "Skipping stack: " + stack['StackName']
                continue
            if stack['StackName'] != self.new_stack:
                print "Deleting old stack: " + stack['StackName']
                response = self.cloudformation_client.delete_stack(
                    StackName=stack['StackName']
                )

    def update_dns(self):
        """Update the DNS record"""
        print "Setting DNS name " + self.recordname + " to point to " + self.new_elb
        response = self.route53_client.change_resource_record_sets(
            HostedZoneId=self.get_hosted_zone(),
            ChangeBatch={
                'Comment': 'Updated by Build ' + self.build_number,
                'Changes': [
                    {
                        'Action': 'UPSERT',
                        'ResourceRecordSet': {
                            'Name': self.recordname,
                            'Type': 'CNAME',
                            'TTL': 60,
                            'ResourceRecords': [
                                {
                                    'Value': self.new_elb
                                },
                            ],
                        }
                    }
                ]
            }
        )
        print response


    def get_hosted_zone(self):
        """Look for the hostedzone so we don't have to hardcode it anywhere"""
        match = re.search(r"^[a-zA-Z0-9_]*\.(?P<zone>.*)", self.recordname)
        zone = match.group('zone')
        print "Looking for domain in Route 53: " + zone
        response = self.route53_client.list_hosted_zones_by_name(
            DNSName=zone
        )
        hostedzone = response['HostedZones'][0]['Id']
        print "Found hostedzone " + hostedzone + " for zone " + zone
        return hostedzone


if len(sys.argv) < 2:
    print "Need new stack name as first argument"
    exit(1)

DEPLOYER = Deployment(sys.argv[1])
DEPLOYER.get_facts()
# TODO: Check new stack before switching?
DEPLOYER.update_dns()
print "Sleeping for a while for DNS to fully propagate before destroying the old stack"
time.sleep(60)
DEPLOYER.delete_old_stack()
