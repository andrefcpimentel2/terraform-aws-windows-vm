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

Invoke-WebRequest ${var.vault_binary_url} -OutFile c:\vault\vault.zip
Expand-Archive -Path c:\vault\vault.zip -DestinationPath c:\vault

@"
pid_file = "./pidfile"

vault {
  address = "https://${var.vault_addr}:8200"
}
auto_auth {
  method {
    type      = "approle"

    config = {
      role_id_file_path = "${var.role_id}"
      secret_id_file_path = "${var.role_secret}"
      remove_secret_id_file_after_reading = false
    }
  }

  sink {
    type = "file"
    wrap_ttl = "30m"
    config = {
      path = "sink_file_wrapped_1.txt"
    }
  }

template_config {
  static_secret_render_interval = "5m"
  exit_on_retry_failure         = true
  max_connections_per_host      = 10
}

env_template "CERT" {
  contents             = "{{- with pkiCert "pki_int/issue/example-dot-com" "ttl=24h" "common_name=foo.example.com" -}}{{ .Cert }}{{ .CA }}{{ if .Key }}{{ .Key  | writeToFile "C:\\Program Files\Vault\\Data\\certificate.key" "" "" "" }}{{ end }}"
  error_on_missing_key = true
}


template {
source = "C:\Vault\agent\wincert.tpl"
destination = "C:\Vault\Data\certificate.crt"
command = "Set-Location -Path cert:\CurrentUser\\My ; Import-Certificate -Filepath 'C:\Vault\Data\certificate.crt"
}
"@ | tee "C:\vault\agent-config.hcl" 

sc.exe create VaultAgent binPath="C:\vault\vault.exe agent -config=C:\vault\agent-config.hcl" displayName="Vault Agent" start=auto


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
