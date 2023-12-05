## sending bounced emails on slack and DynamoDB

This repository contains Terraform modules for setting up AWS SES, SNS, Lambda, and DynamoDB resources. These modules work together to handle SES bounces, send notifications to Slack, and store bounce details in DynamoDB.

## SES Module
The SES module sets up the Simple Email Service for sending and receiving emails.

## Lambda Module
The Lambda module creates the necessary Lambda function to handle SES bounce notifications.

## SNS Module
The SNS module configures the Simple Notification Service topic to be triggered by SES events.

## DynamoDB Module
The DynamoDB module creates the table to store bounce email details.

## Usage
+ Ensure you have the necessary AWS credentials and Terraform installed on your system.
+ Run the following commands in the directory containing your Terraform files:
```hcl
terraform init
terraform apply -var-file=config.tfvars
