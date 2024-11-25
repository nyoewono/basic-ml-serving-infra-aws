module "sagemaker_model_a" {
  source                          = "../modules/sagemaker_model"
  sagemaker_model_name            = "speech-to-text-a"
  sagemaker_execution_role_arn    = module.sagemaker_execution_role.sagemaker_execution_role_arn
  sagemaker_container_image_path  = "account_id/${local.model_image_ecr}:v1"
  sagemaker_model_artifact_s3_uri = "s3://${local.s3_model_artifact_bucket}/key_path_model_a"
  vpc_security_group_ids          = [data.aws_security_group.vpc_endpoints_access.arn]
  vpc_subnets                     = data.aws_subnets.private
}

# example of another module using different base model and different image tag
module "sagemaker_model_b" {
  source                          = "../modules/sagemaker_model"
  sagemaker_model_name            = "speech-to-text-b"
  sagemaker_execution_role_arn    = module.sagemaker_execution_role.sagemaker_execution_role_arn
  sagemaker_container_image_path  = "account_id/${local.model_image_ecr}:v2"
  sagemaker_model_artifact_s3_uri = "s3://${local.s3_model_artifact_bucket}/key_path_model_b"
  vpc_security_group_ids          = [data.aws_security_group.vpc_endpoints_access.arn]
  vpc_subnets                     = data.aws_subnets.private
}
