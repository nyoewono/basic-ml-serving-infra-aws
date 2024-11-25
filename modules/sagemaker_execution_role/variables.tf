variable "sagemaker_execution_role_name" {
  type        = string
  description = "The name of the sagemaker execution role for serving inference"
}

variable "s3_model_artifact_bucket_arn" {
  type        = string
  description = "The s3 bucket used to store pre-trained and tuned model"
}

variable "sagemaker_image_ecr_repository_arn" {
  type        = string
  description = "The container repository used to store the docker image for the pre-trained model for serving"
}
