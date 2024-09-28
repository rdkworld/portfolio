#!/bin/bash

# Define Terraform variables
export TF_VAR_project="de-c1w2"
export TF_VAR_region="us-east-1"
export TF_VAR_vpc_id=$(aws rds describe-db-instances --db-instance-identifier de-c1w2-rds --output text --query "DBInstances[].DBSubnetGroup.VpcId")
export TF_VAR_private_subnet_a_id=$(aws rds describe-db-instances --db-instance-identifier de-c1w2-rds --output text --query "DBInstances[].DBSubnetGroup.Subnets[0].SubnetIdentifier")
export TF_VAR_private_subnet_b_id=$(aws rds describe-db-instances --db-instance-identifier de-c1w2-rds --output text --query "DBInstances[].DBSubnetGroup.Subnets[1].SubnetIdentifier")
export TF_VAR_db_sg_id=$(aws rds describe-db-instances --db-instance-identifier de-c1w2-rds --output text --query "DBInstances[].VpcSecurityGroups[].VpcSecurityGroupId")
export TF_VAR_host=$(aws rds describe-db-instances --db-instance-identifier de-c1w2-rds --output text --query "DBInstances[].Endpoint.Address")
export TF_VAR_port=3306
export TF_VAR_database="classicmodels"
export TF_VAR_username="admin"
export TF_VAR_password="adminpwrd"

# Replace the bucket name in the backend.tf file
script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
sed -i "s/<terraform_state_bucket>/\"de-c1w2-$(aws sts get-caller-identity --query 'Account' --output text)-us-east-1-terraform-state\"/g" "$script_dir/../terraform/backend.tf"