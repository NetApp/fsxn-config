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

resource "aws_fsx_ontap_storage_virtual_machine" "tfnfstest" {
  file_system_id = "fs-0fbe243f4deff97ac"
  name           = "svmnfstest"

  # Only necessary for cifs volumes
/*   active_directory_configuration {
    netbios_name = "svmtftest"
    self_managed_active_directory_configuration {
      dns_ips     = ["10.0.4.73"]
      domain_name = "fsx.emea.netapp"
      password    = "NetApp123!"
      username    = "Administrator"
    }
  }
 */
}
