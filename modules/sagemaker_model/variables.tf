variable "sagemaker_model_name" {
  description = "The name of the SageMaker model"
  type        = string
}

variable "sagemaker_execution_role_arn" {
  description = "The ARN of the IAM role to be assumed by SageMaker for the model"
  type        = string
}

variable "sagemaker_container_image_path" {
  description = "The full path to the container image to be used by SageMaker for the model"
  type        = string
}

variable "sagemaker_model_artifact_s3_uri" {
  description = "The full S3 path to the model artifact (e.g., s3://bucket-name/path-to-artifact)"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs for the VPC configuration"
  type        = list(string)
}

variable "vpc_subnets" {
  description = "List of subnet IDs for the VPC configuration"
  type        = list(string)
}
