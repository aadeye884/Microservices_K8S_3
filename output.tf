output "bastion_host_public_ip" {
  value = aws_instance.ansible.public_ip
}
output "masters-ips" {
  value = aws_instance.masters.*.private_ip
}
output "workers-ips" {
  value = aws_instance.workers.*.private_ip
}
output "clusterlb_pubip" {
  value = aws_instance.clusterlb.public_ip
}
output "k8s_alb-dns" {
  value = aws_lb.k8s-alb.dns_name
}
output "jenkins_lb_dns" {
  value = aws_elb.jenkins-lb.dns_name
}
output "jenkins_ip" {
  value = aws_instance.Jenkins.private_ip
}
output "pmt-dns" {
  value = aws_lb.pmt-alb.dns_name
}
output "graf-dns" {
  value = aws_lb.graf-alb.dns_name
}