locals {
  s3_model_artifact_bucket = "123456-model-artifact-bucket"
  model_image_ecr          = "example_ecr"
}

data "aws_caller_identity" "current" {}

# example of getting a vpc details
data "aws_vpc" "tenant" {
  tags = {
    Name = "tenant_vpc"
  }
}

# example of getting a security group
data "aws_security_group" "vpc_endpoints_access" {
  vpc_id = data.aws_vpc.tenant.id
  name   = "vpc-endpoints-access"
}

# example of getting all private subnet
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.tenant.id]
  }
  filter {
    name   = "tag:Name"
    values = ["private_subnet_*"]
  }
}

data "aws_s3_bucket" "example" {
  bucket = local.s3_model_artifact_bucket
}

data "aws_ecr_repository" "example" {
  name = local.model_image_ecr
}
