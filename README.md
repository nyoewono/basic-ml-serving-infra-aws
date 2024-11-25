# basic-ml-serving-infra-aws

A basic IaC (Terraform) of serving ML models for inference using AWS SageMaker.

## About

This is a collection of Terraform modules on how to create a sagemaker model and serving it using sagemaker endpoint within a virtual private cloud. Here are the scope:

1. SageMaker execution role for the sagemaker model
2. SageMaker model
3. SageMaker endpoint

## Assumption

Here are the assumptions that is made for these modules:

- There is a separate ML pipeline that will train/fine-tune a model and store the model artifact within a s3 bucket.
- A sagemaker model image for serving is stored within an ecr.
- A VPC exist with more than one private subnets and security group

## Workflow

Please look at the test folder to see how the modules interact with each other.

## Things to add

With more time, here are the things that should be added in this repo:

1. SageMaker endpoint autoscaling
2. CloudWatch dashboard and alerts for monitoring
