## Intro

This example uses only HCP Terraform and Vault.
We have an HCP Vault Instance configured with a PKI mount and AppRole Auth.
The AppRole SecretID is a HCP Terraform secret variable (we’ll talk about this later).
Vault Agent will pretty much run in a “bootstrap mode” to fetch a certificate for the machine.

At the Vault Config file, the config:

remove_secret_id_file_after_reading = true

Will pretty much destroy the SecretId after Vault auths, so there won't be any persisted secrets in this workflow.
We also are NOT setting a token sink - we could do it and encrypt it, so the Vault Agent could keep doing its thing.

Alternative workflows:

Using directly the Terraform Vault Provider to create/infect the RoleID and Secret ID at the machine.
https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role_secret_id
Or using Ansible or other CM tools (Octopus?) to do it dynamically.



## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.windows-demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.windows-demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.windows-demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.windows-demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.windows-demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route.internet_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.windows-demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.windows-demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.windows-demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [tls_private_key.windows-demo](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.server_2022](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [template_file.userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_TTL"></a> [TTL](#input\_TTL) | Hours after which resource expires, used by reaper. Do not use any unit. -1 is infinite. | `string` | `"240"` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR blocks to create the workstations in. | `string` | `"10.1.1.0/24"` | no |
| <a name="input_created-by"></a> [created-by](#input\_created-by) | Tag used to identify resources created programmatically by Terraform | `string` | `"Terraform"` | no |
| <a name="input_host_access_ip"></a> [host\_access\_ip](#input\_host\_access\_ip) | your IP address to allow ssh to work | `list` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be added to the default tags | `string` | `"AWS-WINDOWS_DEMO"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"windows-demo"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | IAM user responsible for lifecycle of cloud resources used for training | `string` | `""` | no |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | purpose to be added to the default tags | `string` | `"demo"` | no |
| <a name="input_role_id"></a> [role\_id](#input\_role\_id) | vault app role id | `string` | `""` | no |
| <a name="input_role_secret"></a> [role\_secret](#input\_role\_secret) | vault app role secret | `string` | `""` | no |
| <a name="input_vault_addr"></a> [vault\_addr](#input\_vault\_addr) | vault cluster URL | `string` | `""` | no |
| <a name="input_vault_binary_url"></a> [vault\_binary\_url](#input\_vault\_binary\_url) | vault binary URL | `string` | `"https://releases.hashicorp.com/vault/1.19.3/vault_1.19.3_windows_amd64.zip"` | no |
| <a name="input_vault_namespace"></a> [vault\_namespace](#input\_vault\_namespace) | vault cluster namespace | `string` | `"admin"` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | EC2 instance name for Windows Server | `string` | `"windows-demo"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The top-level CIDR block for the VPC. | `string` | `"10.1.0.0/16"` | no |
| <a name="input_windows_associate_public_ip_address"></a> [windows\_associate\_public\_ip\_address](#input\_windows\_associate\_public\_ip\_address) | Associate a public IP address to the EC2 instance | `bool` | `true` | no |
| <a name="input_windows_data_volume_size"></a> [windows\_data\_volume\_size](#input\_windows\_data\_volume\_size) | Volumen size of data volumen of Windows Server | `number` | `"10"` | no |
| <a name="input_windows_data_volume_type"></a> [windows\_data\_volume\_type](#input\_windows\_data\_volume\_type) | Volumen type of data volumen of Windows Server. Can be standard, gp3, gp2, io1, sc1 or st1 | `string` | `"gp2"` | no |
| <a name="input_windows_instance_type"></a> [windows\_instance\_type](#input\_windows\_instance\_type) | EC2 instance type for Windows Server | `string` | `"t3.large"` | no |
| <a name="input_windows_root_volume_size"></a> [windows\_root\_volume\_size](#input\_windows\_root\_volume\_size) | Volumen size of root volumen of Windows Server | `number` | `"30"` | no |
| <a name="input_windows_root_volume_type"></a> [windows\_root\_volume\_type](#input\_windows\_root\_volume\_type) | Volumen type of root volumen of Windows Server. Can be standard, gp3, gp2, io1, sc1 or st1 | `string` | `"gp2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_instance_name"></a> [vm\_instance\_name](#output\_vm\_instance\_name) | n/a |
| <a name="output_vm_instance_private_ip"></a> [vm\_instance\_private\_ip](#output\_vm\_instance\_private\_ip) | n/a |
| <a name="output_vm_instance_public_ip"></a> [vm\_instance\_public\_ip](#output\_vm\_instance\_public\_ip) | n/a |
| <a name="output_vm_instance_username"></a> [vm\_instance\_username](#output\_vm\_instance\_username) | n/a |
| <a name="output_vm_password_data"></a> [vm\_password\_data](#output\_vm\_password\_data) | n/a |
| <a name="output_vm_windows_server_instance_public_dns"></a> [vm\_windows\_server\_instance\_public\_dns](#output\_vm\_windows\_server\_instance\_public\_dns) | n/a |
