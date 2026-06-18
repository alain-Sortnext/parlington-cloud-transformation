#!/usr/bin/env python3
"""
Parlington Ltd — AWS Inventory Tool
Status: BROKEN — has an unhandled exception and incomplete output
Phase 4: Fix the bugs and extend to cover all required services

Bug 1: Unhandled exception when EC2 describe_instances returns no reservations
Bug 2: Missing error handling for API rate limiting
Bug 3: Output only covers EC2 — must also cover RDS, EKS, Lambda, S3
Bug 4: No pagination — only returns first 1000 results
"""

import boto3
import json
from datetime import datetime


def get_ec2_inventory(region='eu-west-2'):
    """Get EC2 instance inventory for a region."""
    ec2 = boto3.client('ec2', region_name=region)
    
    # BUG: No pagination — only gets first page of results
    # For 120 servers this will miss instances beyond page 1
    response = ec2.describe_instances()
    
    instances = []
    for reservation in response['Reservations']:
        # BUG: If Reservations is empty this works fine, but if 'Instances'
        # key is missing from a reservation, this will raise KeyError
        for instance in reservation['Instances']:
            name = ''
            # BUG: Will throw exception if instance has no tags at all
            # Must handle: instance.get('Tags', [])
            for tag in instance['Tags']:
                if tag['Key'] == 'Name':
                    name = tag['Value']
            
            instances.append({
                'InstanceId': instance['InstanceId'],
                'Name': name,
                'InstanceType': instance['InstanceType'],
                'State': instance['State']['Name'],
                'PrivateIpAddress': instance.get('PrivateIpAddress', 'N/A'),
                # MISSING: LaunchTime — needed for server age calculation
                # MISSING: Tags — needed for cost allocation
                # MISSING: Platform (Windows/Linux) — needed for migration planning
            })
    
    return instances


def get_rds_inventory(region='eu-west-2'):
    """Get RDS instance inventory."""
    # TODO: Implement this function in Phase 4
    # Required fields: DBInstanceIdentifier, Engine, EngineVersion,
    #                  DBInstanceClass, MultiAZ, StorageEncrypted,
    #                  DeletionProtection, BackupRetentionPeriod
    pass


def get_eks_clusters(region='eu-west-2'):
    """Get EKS cluster inventory."""
    # TODO: Implement this function in Phase 4
    pass


def generate_report(output_file='inventory_report.json'):
    """Generate complete inventory report."""
    print("Starting Parlington AWS Inventory...")
    
    report = {
        'generated_at': datetime.now().isoformat(),
        'region': 'eu-west-2',
        # BUG: account_id hardcoded — should use STS get_caller_identity
        'account_id': '123456789012',
        'inventory': {
            'ec2_instances': get_ec2_inventory(),
            # TODO: Add rds_instances, eks_clusters, lambda_functions, s3_buckets
        }
    }
    
    with open(output_file, 'w') as f:
        json.dump(report, f, indent=2, default=str)
    
    # BUG: Summary statistics are wrong — counts before None checks
    print(f"EC2 Instances: {len(report['inventory']['ec2_instances'])}")
    print(f"Report saved to: {output_file}")
    
    return report


if __name__ == '__main__':
    generate_report()
