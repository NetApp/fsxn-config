variable "aws_region" {
  description = "Region in AWS"
  type = string
}

variable "fs_id" {
  description = "Filesystem id"
  type = string
}

variable "fs_capacity" {
  description = "Capacity in MB for filesystem"
  type = number
}

variable "fs_throughput" {
  description = "Throughput in MB for filesystem"
  type = number
}

variable "subnet_ids" {
  description = "Array of subnet ids"
  type = list(string)
}

variable "svm_name" {
  description = "Name of svm"
  type = string
}

variable "netbios_name" {
  description = "Name of cifs machine account"
  type = string
}

variable "dns_ips" {
  description = "Array of IPs for nameservers"
  type = list(string)
}

variable "domain_name" {
  description = "Name of cifs domain to join"
  type = string
}

variable "ad_username" {
  description = "Active Directory administrator username"
  type        = string
  sensitive   = true
}

variable "ad_password" {
  description = "Active Directory administrator password"
  type        = string
  sensitive   = true
}
