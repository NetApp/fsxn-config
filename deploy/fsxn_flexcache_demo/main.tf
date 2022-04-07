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

resource "aws_fsx_ontap_file_system" "skellnerdemo01" {
  storage_capacity                = var.fs_capacity
  subnet_ids                      = var.subnet_ids
  deployment_type                 = "MULTI_AZ_1"
  throughput_capacity             = var.fs_throughput
  preferred_subnet_id             = var.subnet_ids[0]
  automatic_backup_retention_days = var.automatic_backup_retention
  fsx_admin_password              = var.fsxadmin_password
  tags = {
    Name      = "${var.fs_name}01"
    Terraform = "True"
    Owner     = "skellner"
  }

}

resource "aws_fsx_ontap_storage_virtual_machine" "svm_demo01" {
  file_system_id = aws_fsx_ontap_file_system.skellnerdemo01.id
  name           = "svm_${var.fs_name}01"

  active_directory_configuration {
    netbios_name = "${var.fs_name}01"
    self_managed_active_directory_configuration {
      dns_ips     = var.dns_ips
      domain_name = var.domain_name
      password    = var.ad_password
      username    = var.ad_username
    }
  }
}

resource "aws_fsx_ontap_volume" "vol_skdemo01" {
  name                       = "vol_${var.fs_name}01"
  junction_path              = "/vol_${var.fs_name}01"
  size_in_megabytes          = 1024
  storage_efficiency_enabled = true
  security_style             = "NTFS"
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.svm_demo01.id

  tiering_policy {
    name           = "AUTO"
    cooling_period = 31
  }
}
resource "aws_fsx_ontap_file_system" "skellnerdemo02" {
  storage_capacity                = var.fs_capacity
  subnet_ids                      = var.subnet_ids
  deployment_type                 = "MULTI_AZ_1"
  throughput_capacity             = var.fs_throughput
  preferred_subnet_id             = var.subnet_ids[0]
  automatic_backup_retention_days = var.automatic_backup_retention
  fsx_admin_password              = var.fsxadmin_password
  tags = {
    Name      = "${var.fs_name}02"
    Terraform = "True"
    Owner     = "skellner"
  }

}

resource "aws_fsx_ontap_storage_virtual_machine" "svm_demo02" {
  file_system_id = aws_fsx_ontap_file_system.skellnerdemo02.id
  name           = "svm_${var.fs_name}02"

}

resource "aws_fsx_ontap_volume" "vol_skdemo02" {
  name                       = "vol_${var.fs_name}02"
  junction_path              = "/vol_${var.fs_name}02"
  size_in_megabytes          = 1024
  storage_efficiency_enabled = true
  security_style             = "UNIX"
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.svm_demo02.id

  tiering_policy {
    name           = "AUTO"
    cooling_period = 31
  }
}
