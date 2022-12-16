# Ansible_Server
resource "aws_instance" "ansible" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = "true"
  security_groups             = [aws_security_group.allow_ssh.id]
  key_name                    = aws_key_pair.k8_ssh.key_name
  user_data                   = <<-EOF
    #!bin/bash
    echo "PubkeyAcceptedKeyTypes=+ssh-rsa" >> /etc/ssh/sshd_config.d/10-insecure-rsa-keysig.conf
    systemctl reload sshd
    echo "${tls_private_key.ssh.private_key_pem}" >> /home/ubuntu/.ssh/id_rsa
    chown ubuntu /home/ubuntu/.ssh/id_rsa
    chgrp ubuntu /home/ubuntu/.ssh/id_rsa
    chmod 600   /home/ubuntu/.ssh/id_rsa
    echo "starting ansible install"
    apt-add-repository ppa:ansible/ansible -y
    apt update
    apt install ansible -y
    EOF

  tags = {
    Name = "Ansible"
  }
}

#Master
resource "aws_instance" "masters" {
  count           = var.master_node_count
  ami             = var.ami_id
  instance_type   = var.master_instance_type
  subnet_id       = element(module.vpc.private_subnets, count.index)
  key_name        = aws_key_pair.k8_ssh.key_name
  security_groups = [aws_security_group.CLUSTER_SG.id] #[aws_security_group.k8_nodes.id, aws_security_group.k8_masters.id]
  /* associate_public_ip_address = true */

  tags = {
    Name = format("Master-%02d", count.index + 1)
  }
}

#Worker
resource "aws_instance" "workers" {
  count           = var.worker_node_count
  ami             = var.ami_id
  instance_type   = var.worker_instance_type
  subnet_id       = element(module.vpc.private_subnets, count.index)
  key_name        = aws_key_pair.k8_ssh.key_name
  security_groups = [aws_security_group.CLUSTER_SG.id] #[aws_security_group.k8_nodes.id, aws_security_group.k8_workers.id]
  /* associate_public_ip_address = true */

  tags = {
    Name = format("Worker-%02d", count.index + 1)
  }
}

# Jenkins_Server
resource "aws_instance" "Jenkins" {
  ami           = var.ami_Jenkins_id
  instance_type = "t2.medium"
  subnet_id     = module.vpc.private_subnets[0]
  /* associate_public_ip_address = "true" */
  security_groups = [aws_security_group.Jenkins_SG.id]
  key_name        = aws_key_pair.k8_ssh.key_name
  user_data       = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install wget -y
sudo yum install git -y
sudo yum install maven -y
sudo wget https://get.jenkins.io/redhat/jenkins-2.346-1.1.noarch.rpm
sudo rpm -ivh jenkins-2.346-1.1.noarch.rpm
sudo yum install java-11-openjdk -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins
sudo hostnamectl set-hostname Jenkins
EOF

  tags = local.tags

}
