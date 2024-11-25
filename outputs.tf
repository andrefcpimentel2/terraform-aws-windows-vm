output "vm_instance_name" {
  value = var.vm_name
}

output "vm_windows_server_instance_public_dns" {
  value = aws_instance.windows-demo.public_dns
}

output "vm_instance_public_ip" {
  value = aws_eip.windows-demo.public_ip
}

output "vm_instance_private_ip" {
  value = aws_instance.windows-demo.private_ip
}


output "vm_password_data" {
  value = "${rsadecrypt(aws_instance.windows-demo.password_data, nonsensitive(tls_private_key.windows-demo.private_key_pem))}"
}