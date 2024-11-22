# Get Windows Server 2022 AMI
data "aws_ami" "server_2022" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}

# Bootstrapping PowerShell Script
data "template_file" "userdata" {
  template = <<EOF
<powershell>
# Rename Machine
Rename-Computer -NewName "${var.vm_name}" -Force;

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;

# Restart machine
shutdown -r -t 10;
</powershell>
EOF
}


resource "aws_instance" "windows-demo" {
  ami                         = data.aws_ami.windows-2019.id
  instance_type               = var.windows_instance_type
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.aws-windows-sg.id]
  associate_public_ip_address = var.windows_associate_public_ip_address
  source_dest_check           = false
  key_name                    = aws_key_pair.windows-demo.id
  user_data                   = data.template_file.windows-userdata.rendered
  
  # root disk
  root_block_device {
    volume_size           = var.windows_root_volume_size
    volume_type           = var.windows_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  # extra disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = var.windows_data_volume_size
    volume_type           = var.windows_data_volume_type
    encrypted             = true
    delete_on_termination = true
  }
  
   tags = local.common_tags
}

resource "aws_eip" "windows-demo" {
  domain       = "vpc"
  tags = local.common_tags
}

# Associate Elastic IP to Windows Server
resource "aws_eip_association" "windows-demo" {
  instance_id   = aws_instance.windows-demo.id
  allocation_id = aws_eip.windows-demo.id
}
