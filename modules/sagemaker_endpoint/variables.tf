variable "sagemaker_endpoint_name" {
  type        = string
  description = "The name of the sagemaker endpoint"
}

variable "sagemaker_instance_type" {
  type        = string
  description = "The type of instance to start."
}

variable "sagemaker_initial_instance_count" {
  type        = number
  description = "Initial number of instances. Set to 1 by default"
  default     = 1
}

variable "sagemaker_model_variants" {
  type = map(object({
    ModelName            = string
    InitialVariantWeight = number
  }))
}
