resource "aws_vpc" "windows-demo" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.common_tags

}

resource "aws_internet_gateway" "windows-demo" {
  vpc_id = aws_vpc.windows-demo.id

  tags = local.common_tags
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.windows-demo.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.windows-demo.id

}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "windows-demo" {

  vpc_id                  = aws_vpc.windows-demo.id
  availability_zone       = data.aws_availability_zones.available.names[0]
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = true

  tags = local.common_tags
}


resource "aws_security_group" "windows-demo" {
  name_prefix = var.namespace
  vpc_id      = aws_vpc.windows-demo.id

tags = local.common_tags
  #Allow internal communication between nodes
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = -1
  }

    # SSH access if host_access_ip has CIDR blocks
  dynamic "ingress" {
    for_each = var.host_access_ip
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

        # SSH access if host_access_ip has CIDR blocks
  dynamic "ingress" {
    for_each = var.host_access_ip
    content {
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }
}

resource "tls_private_key" "windows-demo" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "windows-demo" {
  key_name   = var.namespace
  public_key = tls_private_key.windows-demo.public_key_openssh

  tags = local.common_tags
}