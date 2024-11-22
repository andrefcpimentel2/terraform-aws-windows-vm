output "vm_windows_server_instance_name" {
  value = var.vm_name
}

output "vm_windows_server_instance_public_dns" {
  value = aws_instance.windows-demo.public_dns
}

output "vm_windows_server_instance_public_ip" {
  value = aws_eip.windows-eip.public_ip
}

output "vm_windows_server_instance_private_ip" {
  value = aws_instance.windows-demo.private_ip
}