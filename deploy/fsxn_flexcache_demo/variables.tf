variable "aws_region" {
  description = "Region in AWS"
  type        = string
}

variable "fs_capacity" {
  description = "Capacity in MB for filesystem"
  type        = number
}

variable "fs_throughput" {
  description = "Throughput in MB for filesystem"
  type        = number
}

variable "automatic_backup_retention" {
  description = "Automatic backup retention for filesystem in days"
  type        = number
}

variable "fsxadmin_password" {
  description = "ONTAP administrative password fsxadmin user"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "Array of subnet ids"
  type        = list(string)
}

variable "fs_name" {
  description = "Name of filesystem"
  type        = string
}

variable "dns_ips" {
  description = "Array of IPs for nameservers"
  type        = list(string)
}

variable "domain_name" {
  description = "Name of cifs domain to join"
  type        = string
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
