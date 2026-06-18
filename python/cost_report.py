#!/usr/bin/env python3
"""
Parlington Ltd — AWS Cost Reporting Tool
Status: STUB — incomplete implementation
Phase 4: Complete this tool to generate FinOps cost reports

Requirements:
- Pull last 30 days of cost data from Cost Explorer
- Break down by service, account, and cost centre tag
- Identify top 10 cost drivers
- Flag any resources with missing cost centre tags (FinOps policy violation)
- Export to CSV for Marcus Webb (CFO) monthly review
- Alert if spend exceeds £150,000/month threshold
"""

import boto3
import csv
from datetime import datetime, timedelta


def get_cost_and_usage(start_date, end_date):
    """Pull cost data from AWS Cost Explorer."""
    ce = boto3.client('ce', region_name='us-east-1')
    # NOTE: Cost Explorer API is only available in us-east-1
    
    # TODO: Implement cost query
    # Required dimensions: SERVICE, LINKED_ACCOUNT
    # Required tags: CostCentre, Environment
    # Required metrics: UnblendedCost, UsageQuantity
    pass


def identify_untagged_resources():
    """Find resources missing required cost centre tags."""
    # TODO: Implement using AWS Config or Resource Groups Tagging API
    # Parlington FinOps policy: ALL resources must have CostCentre tag
    # Resources without tags should be flagged to team owner
    pass


def generate_monthly_report():
    """Generate monthly cost report for CFO review."""
    # TODO: Complete implementation
    print("Cost report not yet implemented — complete in Phase 4")
    print("Target: £1.9M annual run-rate (£158,333/month)")
    print("Budget alert threshold: £200,000/month")


if __name__ == '__main__':
    generate_monthly_report()
