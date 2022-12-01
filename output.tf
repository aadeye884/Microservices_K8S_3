output "bastion_host_public_ip" {
  value = aws_instance.ansible.public_ip
}
output "masters-ips" {
  value = aws_instance.masters.*.public_ip
}
output "workers-ips" {
  value = aws_instance.workers.*.public_ip
}
output "clusterlb_pubip" {
  value = aws_instance.clusterlb.*.public_ip
}
