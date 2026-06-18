# terraform/vpc/main.tf
# Parlington Ltd — VPC Module
# Status: INCOMPLETE — missing outputs, subnet calculation has a bug
# Phase 4: You must fix and complete this module

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  # BUG: default value uses wrong CIDR for Parlington's network plan
  # Parlington network plan specifies 10.0.0.0/16 for production
  default = "172.16.0.0/16"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

# TODO: availability_zones should be variable, not hardcoded
locals {
  azs = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  # NOTE: These CIDR calculations are incomplete — Phase 4 candidate must fix
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  # MISSING: data subnets for RDS/Aurora
  # MISSING: transit gateway attachment subnet
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "parlington-${var.environment}-vpc"
    Environment = var.environment
    ManagedBy   = "terraform"
    # MISSING: CostCentre tag — required by FinOps framework
    # MISSING: DataClassification tag — required by FCA policy
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "parlington-${var.environment}-igw"
  }
}

resource "aws_subnet" "public" {
  count             = length(local.azs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.public_subnets[count.index]
  availability_zone = local.azs[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "parlington-${var.environment}-public-${local.azs[count.index]}"
    Tier = "public"
  }
}

resource "aws_subnet" "private" {
  count             = length(local.azs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnets[count.index]
  availability_zone = local.azs[count.index]

  tags = {
    Name = "parlington-${var.environment}-private-${local.azs[count.index]}"
    Tier = "private"
    # MISSING: EKS cluster tags for auto-discovery
    # "kubernetes.io/cluster/parlington-eks" = "shared"
    # "kubernetes.io/role/internal-elb" = "1"
  }
}

# TODO: NAT Gateway — single NAT for cost, but this is not HA
# For production Parlington requires NAT per AZ — fix in Phase 4
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "parlington-${var.environment}-nat"
  }
}

# MISSING: Route tables — candidate must add in Phase 4
# MISSING: VPC Flow Logs — required by FCA audit policy
# MISSING: outputs block — module has no outputs defined

