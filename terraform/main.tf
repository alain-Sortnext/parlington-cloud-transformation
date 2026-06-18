# terraform/main.tf
# Parlington Ltd — Root Terraform Configuration
# Status: INCOMPLETE — backend not configured, modules not wired up
# Phase 4: You must complete this configuration

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  # TODO: Configure remote state backend
  # For Parlington this should be S3 + DynamoDB for state locking
  # Uncomment and complete when S3 bucket is created in Phase 4
  #
  # backend "s3" {
  #   bucket         = "parlington-terraform-state-ACCOUNT_ID"
  #   key            = "global/terraform.tfstate"
  #   region         = "eu-west-2"
  #   encrypt        = true
  #   dynamodb_table = "parlington-terraform-locks"
  #   kms_key_id     = "alias/parlington-terraform-state"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "parlington-cloud-transformation"
      ManagedBy   = "terraform"
      Environment = var.environment
      # MISSING: CostCentre — required for FinOps cost allocation
      # MISSING: DataClassification — required by FCA policy
    }
  }
}

variable "aws_region" {
  default = "eu-west-2"
}

variable "environment" {
  default = "dev"
}

# TODO: Call VPC module
# TODO: Call IAM module
# TODO: Call EKS module (Phase 5)
# TODO: Call RDS module (Phase 7)
