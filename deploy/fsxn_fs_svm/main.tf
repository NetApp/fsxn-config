terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.66"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

resource "aws_fsx_ontap_file_system" "skellnerdemo" {
  storage_capacity    = var.fs_capacity
  subnet_ids          = var.subnet_ids
  deployment_type     = "MULTI_AZ_1"
  throughput_capacity = var.fs_throughput
  preferred_subnet_id = var.subnet_ids[0]
}

resource "aws_fsx_ontap_storage_virtual_machine" "svm_demo" {
  file_system_id = aws_fsx_ontap_file_system.skellnerdemo.id
  name           = var.svm_name

  active_directory_configuration {
    netbios_name = var.netbios_name
    self_managed_active_directory_configuration {
      dns_ips     = var.dns_ips
      domain_name = var.domain_name
      password    = var.ad_password
      username    = var.ad_username
    }
  }
}

