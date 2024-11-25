module "sagemaker_endpoint" {
  source                           = "../modules/sagemaker_endpoint"
  sagemaker_endpoint_name          = "test-endpoint"
  sagemaker_initial_instance_count = 1
  sagemaker_instance_type          = "ml.c6i.xlarge"
  sagemaker_model_variants = {
    "main-model" : {
      "ModelName" : "${module.sagemaker_model_a}" # update to change to a different model
      "InitialVariantWeight" : 1
    }
  }
}
