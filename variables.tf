locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Name      = var.name
    owner     = var.owner
    se-region = var.se-region
    terraform = true
    purpose   = var.purpose
    ttl       = var.TTL
  }
}

variable "se-region" {
  description = "Mandatory tags for the SE organization"
}


variable "purpose" {
  description = <<EOH
purpose to be added to the default tags
EOH
}

variable "name" {
  description = <<EOH
Name to be added to the default tags
EOH
}


variable "host_access_ip" {
  description = "your IP address to allow ssh to work"
  default     = []
}

variable "owner" {
  description = "IAM user responsible for lifecycle of cloud resources used for training"
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

variable "public_key" {
  description = "The contents of the SSH public key to use for connecting to the cluster."
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