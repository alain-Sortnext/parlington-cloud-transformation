# terraform/iam/main.tf
# Parlington Ltd — IAM Module
# Status: INCOMPLETE — missing outputs, some policies are overly permissive
# Phase 4: You must audit, fix, and complete this module

# ⚠️  WARNING: The policy below is intentionally overly permissive
# This represents what was found in the existing AWS account
# You must replace this with least-privilege policies in Phase 4

resource "aws_iam_role" "ec2_instance_role" {
  name = "parlington-ec2-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# BUG: This policy grants S3 full access — should be scoped to specific buckets
resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "parlington-ec2-s3-policy"
  role = aws_iam_role.ec2_instance_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        # ⚠️  SECURITY ISSUE: s3:* on * violates least-privilege principle
        # FCA and ISO 27001 require least-privilege access
        Action   = ["s3:*"]
        Resource = ["*"]
      }
    ]
  })
}

# TODO: EKS node group role — needed for Phase 5
# TODO: IRSA roles for service accounts — needed for Phase 5
# TODO: Break-glass admin role with MFA enforcement
# TODO: CI/CD deployment role with limited permissions
# MISSING: outputs block

