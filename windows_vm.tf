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
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# Rename Machine
Rename-Computer -NewName "${var.vm_name}" -Force;

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;

New-Item -ItemType Directory -Path "c:\vault"
New-Item -Path "c:\vault" -Name "roleid" -ItemType "File" -Value "${var.role_id}"
New-Item -Path "c:\vault" -Name "rolesecret" -ItemType "File" -Value "${var.role_secret}"

Invoke-WebRequest ${var.vault_binary_url} -OutFile c:\vault\vault.zip
Expand-Archive -Path c:\vault\vault.zip -DestinationPath c:\vault

$config_file = @"
vault {
  address = "${var.vault_addr}"
  namespace = "${var.vault_namespace}"
}
auto_auth {
  method {
    type      = "approle"

    config = {
      role_id_file_path = "c:\\vault\\roleid"
      secret_id_file_path = "c:\\vault\\rolesecret"
      remove_secret_id_file_after_reading = true
    }
  }
}

template {
  contents     = "{{- with pkiCert \"pki_int/issue/example-dot-com\" \"common_name=foo.example.com\" -}}{{ .Data.Cert }}{{- end }}"
  destination  = "c:\\vault\\cert.crt"
}

"@

New-Item "C:\vault\agent-config_win.txt"
Add-Content "C:\vault\agent-config_win.txt" $config_file

sc.exe create VaultAgent binPath="C:\vault\vault.exe agent -config=C:\vault\agent-config_win.txt" displayName="VaultAgent" start=auto

$s = Get-Service VaultAgent
Start-Service -InputObject $s -PassThru | Format-List >> c:\vault\VaultAgent.txt

# Restart machine
shutdown -r -t 10;
</powershell>
EOF
}


resource "aws_instance" "windows-demo" {
  ami                         = data.aws_ami.server_2022.id
  instance_type               = var.windows_instance_type
  subnet_id                   = aws_subnet.windows-demo.id
  vpc_security_group_ids      = [aws_security_group.windows-demo.id]
  associate_public_ip_address = var.windows_associate_public_ip_address
  source_dest_check           = false
  key_name                    = aws_key_pair.windows-demo.id
  get_password_data           = true
  user_data                   = data.template_file.userdata.rendered
  
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
