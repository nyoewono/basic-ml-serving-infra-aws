locals {
  sagemaker_model_variants_str = join(", \n", [for variant, definition in var.sagemaker_model_variants : replace(<<EOF
    "${variant}": {
        "ModelName": "${definition.ModelName}",
        "InitialVariantWeight": "${definition.InitialVariantWeight}"
    }
    EOF
    , "\r\n", "\n")
  ])
}

# SageMaker does not expose an API to update endpoint configuration. Hence, when endpoint config 
# is recreated with the same name, Terraform will not update the existing endpoint. As a workaround,
# we can add a random suffix to the endpoint config name whenever there is a change from the following
# values within the keepers block. In this way, the endpoint config will have a new name, and the
# endpoint will be updated.
resource "random_id" "force_endpoint_update" {
  keepers = {
    variants                         = local.sagemaker_model_variants_str
    sagemaker_instance_type          = var.sagemaker_instance_type
    sagemaker_initial_instance_count = var.sagemaker_initial_instance_count
  }
  byte_length = 8
}

resource "aws_sagemaker_endpoint_configuration" "main" {
  name = "${var.sagemaker_endpoint_name}-config-${random_id.force_endpoint_update}"

  dynamic "production_variants" {
    for_each = var.sagemaker_model_variants

    content {
      variant_name           = production_variants.key
      model_name             = production_variants.value.ModelName
      initial_variant_weight = production_vairants.value.InitialVariantWeight
      initial_instance_count = var.sagemaker_initial_instance_count
      instance_type          = var.sagemaker_instance_type
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_sagemaker_endpoint" "main" {
  name                 = var.sagemaker_endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.main.name
}
