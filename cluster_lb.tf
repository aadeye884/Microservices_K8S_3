resource "aws_instance" "clusterlb" {
  ami                         = var.ami_id
  instance_type               = var.clusterlb_instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  key_name                    = aws_key_pair.k8_ssh.key_name
  security_groups             = [aws_security_group.CLUSTER_SG.id] #[aws_security_group.k8_nodes.id, aws_security_group.k8_masters.id]
  associate_public_ip_address = true
  # depends_on                  = [aws_instance.masters]
  user_data = <<-EOF
#!/bin/bash
sudo -i
apt-get update -y
apt-get upgrade -y
apt install --no-install-recommends software-properties-common
add-apt-repository ppa:vbertnat/haproxy-2.4 -y
apt install haproxy=2.4.\* -y
cat <<EOT>> /etc/haproxy/haproxy.cfg
frontend fe-apiserver
   bind 0.0.0.0:6443
   mode tcp
   option tcplog
   default_backend be-apiserver
backend be-apiserver
   mode tcp
   option tcplog
   option tcp-check
   balance roundrobin

   server Master1 ${aws_instance.masters[0].private_ip}:6443 check
   server Master2 ${aws_instance.masters[1].private_ip}:6443 check
   server Master3 ${aws_instance.masters[2].private_ip}:6443 check
EOT
systemctl restart haproxy
snap install kubectl --classic
hostnamectl set-hostname clusterlb
EOF
  tags = {
    Name = "clusterlb"
  }
}