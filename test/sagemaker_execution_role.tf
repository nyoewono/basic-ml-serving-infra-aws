module "sagemaker_execution_role" {
  source                             = "../modules/sagemaker_execution_role"
  sagemaker_execution_role_name      = "sagemaker-serving-execution-role"
  s3_model_artifact_bucket_arn       = data.aws_s3_bucket.example.arn
  sagemaker_image_ecr_repository_arn = data.aws_ecr_repository.example.arn
}
