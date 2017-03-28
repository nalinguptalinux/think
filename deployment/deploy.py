#!/usr/bin/env python

import boto3
import json
import sys
import re

class Deployment():
    """Class to handle deployments"""

    def __init__(self, new_stack):
        region_name='ap-southeast-1'
        self.cloudformation_client = boto3.client('cloudformation', region_name=region_name)
        self.route53_client = boto3.client('route53', region_name=region_name)
        self.elb_client = boto3.client('elb', region_name=region_name)
        self.new_stack = new_stack
        self.new_elb = None
        self.recordname = None


    def get_facts(self):
        response = self.cloudformation_client.describe_stacks(StackName=self.new_stack)
        for output in response['Stacks'][0]['Outputs']:
            if output['OutputKey'] == 'WebElasticLoadBalancer':
                self.new_elb = output['OutputValue'][7:]
                print "Our new ELB is " + self.new_elb
            if output['OutputKey'] == 'RecordName':
                self.fqdn = output['OutputValue']
                print "Our FQDN is " + self.recordname


    def delete_old_stack(self):
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

    def updateDns(self):
        response = self.route53_client.change_resource_record_sets(
            # TODO - remove hardcoded values
            HostedZoneId='/hostedzone/Z1RO50GRKOE8CL',
            ChangeBatch={
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

if not sys.argv[1]:
    print "Need new stack name as first argument"
    exit(1)

DEPLOYER = Deployment(sys.argv[1])
DEPLOYER.get_facts()
# TODO: Check new stack before switching?
DEPLOYER.updateDns()
DEPLOYER.delete_old_stack()
