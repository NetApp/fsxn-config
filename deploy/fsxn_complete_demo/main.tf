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
  storage_capacity                = var.fs_capacity
  subnet_ids                      = var.subnet_ids
  deployment_type                 = "MULTI_AZ_1"
  throughput_capacity             = var.fs_throughput
  preferred_subnet_id             = var.subnet_ids[0]
  endpoint_ip_address_range       = var.endpoint_ip_address_range
  automatic_backup_retention_days = var.automatic_backup_retention
  fsx_admin_password              = var.fsxadmin_password
  tags = {
    Name      = "skellner_demo"
    Terraform = "True"
    Owner     = "skellner"
  }

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

resource "aws_fsx_ontap_volume" "vol_sknfsdemo" {
  name                       = "vol_sknfsdemo"
  junction_path              = "/vol_sknfsdemo"
  size_in_megabytes          = 1024
  storage_efficiency_enabled = true
  security_style             = "UNIX"
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.svm_demo.id

  tiering_policy {
    name           = "AUTO"
    cooling_period = 31
  }
}

resource "aws_fsx_ontap_volume" "vol_skcifsdemo" {
  name                       = "vol_skcifsdemo"
  junction_path              = "/vol_skcifsdemo"
  size_in_megabytes          = 1024
  storage_efficiency_enabled = true
  security_style             = "NTFS"
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.svm_demo.id

  tiering_policy {
    name           = "AUTO"
    cooling_period = 31
  }
}
