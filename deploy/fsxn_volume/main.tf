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

resource "aws_fsx_ontap_volume" "tfnfstest" {
  name                       = "nfstest"
  junction_path              = "/nfstest"
  size_in_megabytes          = 1024
  storage_efficiency_enabled = true
  security_style             = "UNIX"
  storage_virtual_machine_id = "svm-00639a604f5cb20bc"

  tiering_policy {
    name           = "AUTO"
    cooling_period = 31
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
