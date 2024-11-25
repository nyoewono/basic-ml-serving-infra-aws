resource "aws_sagemaker_model" "model" {
  name               = var.sagemaker_model_name
  execution_role_arn = var.sagemaker_execution_role_arn

  primary_container {
    image          = var.sagemaker_container_image_path
    mode           = "SingleModel" # currently this module will only support single model
    model_data_url = var.sagemaker_model_artifact_s3_uri
  }

  vpc_config {
    security_group_ids = var.vpc_security_group_ids
    subnets            = var.vpc_subnets
  }

  enable_network_isolation = true
}
