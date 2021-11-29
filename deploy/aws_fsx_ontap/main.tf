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
  region  = "eu-central-1"
}

resource "aws_fsx_ontap_file_system" "skellnertftest" {
  storage_capacity    = 1024
  subnet_ids          = ["subnet-085687ba71b1c528f", "subnet-0c61e5623e89ea615"]
  deployment_type     = "MULTI_AZ_1"
  throughput_capacity = 512
  preferred_subnet_id = "subnet-085687ba71b1c528f"
}

resource "aws_fsx_ontap_storage_virtual_machine" "svm_tftest" {
  file_system_id = aws_fsx_ontap_file_system.skellnertftest.id
  name           = "svmtftest"

  active_directory_configuration {
    netbios_name = "svmtftest"
    self_managed_active_directory_configuration {
      dns_ips     = ["10.0.4.73"]
      domain_name = "fsx.emea.netapp"
      password    = "NetApp123!"
      username    = "Administrator"
    }
  }
}

resource "aws_fsx_ontap_volume" "tfcifstest" {
  name                       = "cifstest"
  junction_path              = "/cifstest"
  size_in_megabytes          = 1024
  storage_efficiency_enabled = true
  security_style             = "NTFS"
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.svm_tftest.id

  tiering_policy {
    name           = "AUTO"
    cooling_period = 31
  }
}
