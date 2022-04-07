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

resource "aws_fsx_ontap_storage_virtual_machine" "tfnfstest" {
  file_system_id = var.fs_id
  name           = var.svm_name

  # Only necessary for cifs volumes
/*   active_directory_configuration {
    netbios_name = var.netbios_name
    self_managed_active_directory_configuration {
      dns_ips     = var.dns_ips
      domain_name = var.domain_name
      password    = var.ad_password
      username    = var.ad_username
    }
  }
 */
}
