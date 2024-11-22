# terraform-aws-windows-vm
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

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
| [aws_ami.2022_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [template_file.userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_TTL"></a> [TTL](#input\_TTL) | Hours after which resource expires, used by reaper. Do not use any unit. -1 is infinite. | `string` | `"240"` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR blocks to create the workstations in. | `string` | `"10.1.1.0/24"` | no |
| <a name="input_created-by"></a> [created-by](#input\_created-by) | Tag used to identify resources created programmatically by Terraform | `string` | `"Terraform"` | no |
| <a name="input_host_access_ip"></a> [host\_access\_ip](#input\_host\_access\_ip) | your IP address to allow ssh to work | `list` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be added to the default tags | `any` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"windows-demo"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | IAM user responsible for lifecycle of cloud resources used for training | `any` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The contents of the SSH public key to use for connecting to the cluster. | `any` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | purpose to be added to the default tags | `any` | n/a | yes |
| <a name="input_se-region"></a> [se-region](#input\_se-region) | Mandatory tags for the SE organization | `any` | n/a | yes |
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
| <a name="output_vm_windows_server_instance_name"></a> [vm\_windows\_server\_instance\_name](#output\_vm\_windows\_server\_instance\_name) | n/a |
| <a name="output_vm_windows_server_instance_private_ip"></a> [vm\_windows\_server\_instance\_private\_ip](#output\_vm\_windows\_server\_instance\_private\_ip) | n/a |
| <a name="output_vm_windows_server_instance_public_dns"></a> [vm\_windows\_server\_instance\_public\_dns](#output\_vm\_windows\_server\_instance\_public\_dns) | n/a |
| <a name="output_vm_windows_server_instance_public_ip"></a> [vm\_windows\_server\_instance\_public\_ip](#output\_vm\_windows\_server\_instance\_public\_ip) | n/a |
<!-- END_TF_DOCS -->