terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_fsx_ontap_file_system" "skellnertftest" {
  storage_capacity    = 1024
  subnet_ids          = ["subnet-085687ba71b1c528f", "subnet-0c61e5623e89ea615"]
  deployment_type     = "MULTI_AZ_1"
  throughput_capacity = 512
  preferred_subnet_id = "subnet-085687ba71b1c528f"
}