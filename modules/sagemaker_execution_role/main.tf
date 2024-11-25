data "aws_iam_policy_document" "sagemaker_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_bucket_model_artifact_policy" {

  statement {
    sid    = "Allows3Access"
    effect = "Allow"
    actions = ["s3:ListBucket",
    "s3:GetObject"]
    resources = ["${var.s3_model_artifact_bucket_arn}",
    "${var.s3_model_artifact_bucket_arn}/*"]
  }
}

data "aws_iam_policy_document" "cloudwatch_logs_policy" {

  statement {
    sid    = "AllowCloudWatchLogs"
    effect = "Allow"
    actions = ["logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:DescribeLogStreams",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
    "cloudwatch:PutMetricData"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "vpc_access_policy" {

  statement {
    sid    = "AllowVPCAccess"
    effect = "Allow"
    actions = ["ec2:DescribeVpcEndpoints",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeVpcs",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterfacePermission",
      "ec2:DeleteNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
    "ec2:CreateNetworkInterface"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ecr_access_policy" {
  statement {
    sid    = "AllowAccesstoECR"
    effect = "Allow"
    actions = ["ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    "ecr:BatchCheckLayerAvailability"]
    resources = [var.sagemaker_image_ecr_repository_arn]
  }
  statement {
    sid       = ""
    effect    = "Allow"
    actions   = ["ecr:GetAuthrizationToken"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "sagemaker_execution_role" {
  name               = var.sagemaker_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role_policy
}

resource "aws_iam_role_policy" "sagemaker_execution_s3_access_policy" {
  name   = "sagemaker-execution-s3-access"
  role   = aws_iam_role.sagemaker_execution_role
  policy = data.aws_iam_policy_document.s3_bucket_model_artifact_policy
}

resource "aws_iam_role_policy" "sagemaker_execution_cloudwatch_access_policy" {
  name   = "agemaker-execution-cloudwatch-logs-access"
  role   = aws_iam_role.sagemaker_execution_role
  policy = data.aws_iam_policy_document.cloudwatch_logs_policy
}

resource "aws_iam_role_policy" "sagemaker_execution_ecr_access_policy" {
  name   = "sagemaker-execution-ecr-access"
  role   = aws_iam_role.sagemaker_execution_role
  policy = data.aws_iam_policy_document.ecr_access_policy
}

resource "aws_iam_role_policy" "sagemaker_execution_vpc_access_policy" {
  name   = "sagemaker-execution-vpc-access"
  role   = aws_iam_role.sagemaker_execution_role
  policy = data.aws_iam_policy_document.vpc_access_policy
}
