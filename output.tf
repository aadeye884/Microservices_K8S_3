output "masters-ips" {
  value = aws_instance.masters.*.public_ip
}
output "workers-ips" {
  value = aws_instance.workers.*.public_ip
}
output "bastion_host_public_ip" {
  value = aws_instance.ansible.public_ip
}