locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Name      = var.name
    owner     = var.owner
    terraform = true
    purpose   = var.purpose
    ttl       = var.TTL
  }
}

variable "purpose" {
  description = <<EOH
purpose to be added to the default tags
EOH
default     = "demo"
}

variable "name" {
  description = <<EOH
Name to be added to the default tags
EOH
default     = "AWS-WINDOWS_DEMO"
}


variable "host_access_ip" {
  description = "your IP address to allow ssh to work"
  default     = []
}

variable "owner" {
  description = "IAM user responsible for lifecycle of cloud resources used for training"
  default     = ""
}

variable "created-by" {
  description = "Tag used to identify resources created programmatically by Terraform"
  default     = "Terraform"
}

variable "TTL" {
  description = "Hours after which resource expires, used by reaper. Do not use any unit. -1 is infinite."
  default     = "240"
}

variable "vpc_cidr_block" {
  description = "The top-level CIDR block for the VPC."
  default     = "10.1.0.0/16"
}

variable "cidr_block" {
  description = "The CIDR blocks to create the workstations in."
  default     = "10.1.1.0/24"
}


variable "windows_instance_type" {
  type        = string
  description = "EC2 instance type for Windows Server"
  default     = "t3.large"
}

variable "windows_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = true
}

variable "windows_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Windows Server"
  default     = "30"
}

variable "windows_data_volume_size" {
  type        = number
  description = "Volumen size of data volumen of Windows Server"
  default     = "10"
}

variable "windows_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Windows Server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp2"
}

variable "windows_data_volume_type" {
  type        = string
  description = "Volumen type of data volumen of Windows Server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp2"
}

variable "vm_name" {
  type        = string
  description = "EC2 instance name for Windows Server"
  default     = "windows-demo"
}

variable "namespace" {

  default     = "windows-demo"
}

variable "vault_binary_url" {
  description = "vault binary URL"
  default     = "https://releases.hashicorp.com/vault/1.19.3/vault_1.19.3_windows_amd64.zip"
}

variable "vault_addr" {
  description = "vault cluster URL"
  default     = ""
}

variable "vault_namespace" {
  description = "vault cluster namespace"
  default     = "admin"
}

variable "role_id" {
  description = "vault app role id"
  default     = ""
}

variable "role_secret" {
  description = "vault app role secret"
  default     = ""
}
