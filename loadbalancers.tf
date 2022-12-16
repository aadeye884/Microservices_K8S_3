#Jenkins loadbalancer
resource "aws_elb" "jenkins-lb" {
  name            = "jenkins-lb"
  subnets         = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]
  security_groups = [aws_security_group.jenkins_lbSG.id]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 30
  }

  instances                   = [aws_instance.Jenkins.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "jenkins-lb"
  }
}

#K8s loadbalancer
# Load Balancer Target Group
resource "aws_lb_target_group" "targetgroup" {
  name     = "targetgroup"
  vpc_id   = module.vpc.vpc_id
  port     = 30001
  protocol = "HTTP"
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 5
  }
}

# Worker1 Target group attachment
resource "aws_lb_target_group_attachment" "targetgroupatt1" {
  target_group_arn = aws_lb_target_group.targetgroup.arn
  target_id        = "${element(split(",", join(",", aws_instance.workers.*.id)), count.index)}"
  port             = 30001
  count            = 3
}

# Load Balancer Listener
resource "aws_lb_listener" "alblistener" {
  load_balancer_arn = aws_lb.k8s-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetgroup.arn
  }
}

# Application Load Balancer
resource "aws_lb" "k8s-alb" {
  name               = "k8s-alb"
  security_groups    = [aws_security_group.CLUSTER_SG.id]
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]
  load_balancer_type = "application"
}


# Prometheus Load Balancer 
# Worker1 Target group attachment
resource "aws_lb_target_group_attachment" "targetgroupatt4" {
  target_group_arn = aws_lb_target_group.pmt-targetgroup.arn
  target_id        = "${element(split(",", join(",", aws_instance.workers.*.id)), count.index)}"
  port             = 31090
  count            = 3
}

# Application Load Balancer
resource "aws_lb" "pmt-alb" {
  name               = "pmt-alb"
  security_groups    = [aws_security_group.CLUSTER_SG.id]
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]
  load_balancer_type = "application"
}

# Pmt Load Balancer Listener
resource "aws_lb_listener" "pmt-alblistener" {
  load_balancer_arn = aws_lb.pmt-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pmt-targetgroup.arn
  }
}

# Pmt Target Group
resource "aws_lb_target_group" "pmt-targetgroup" {
  name     = "pmt-targetgroup"
  vpc_id   = module.vpc.vpc_id
  port     = 31090
  protocol = "HTTP"
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 5
  }
}

# Grafana Load Balancer 
# Worker1 Target group attachment
resource "aws_lb_target_group_attachment" "targetgroupatt7" {
  target_group_arn = aws_lb_target_group.graf-targetgroup.arn
  target_id        = "${element(split(",", join(",", aws_instance.workers.*.id)), count.index)}"
  port             = 31300
  count            = 3
}

# Application Load Balancer
resource "aws_lb" "graf-alb" {
  name               = "graf-alb"
  security_groups    = [aws_security_group.CLUSTER_SG.id]
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]
  load_balancer_type = "application"
}

# Graf Load Balancer Listener
resource "aws_lb_listener" "graf-alblistener" {
  load_balancer_arn = aws_lb.graf-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.graf-targetgroup.arn
  }
}

# graf Target Group
resource "aws_lb_target_group" "graf-targetgroup" {
  name     = "graf-targetgroup"
  vpc_id   = module.vpc.vpc_id
  port     = 31300
  protocol = "HTTP"
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 5
  }
}

