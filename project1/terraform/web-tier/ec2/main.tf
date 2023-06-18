
provider "aws" {
  region = "eu-west-1"
}

resource "aws_network_interface" "foo" {
  subnet_id       = "subnet-079c560c0b21dd45b"
  security_groups = [aws_security_group.ec2_web.id]
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "foo" {
  ami           = "ami-04f7efe62f419d9f5"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}


resource "aws_network_interface" "bar" {
  subnet_id       = "subnet-079c560c0b21dd45b"
  security_groups = [aws_security_group.ec2_web.id]

  tags = {
    Name = "primary_network_interface"
  }
}


resource "aws_instance" "bar" {
  ami           = "ami-04f7efe62f419d9f5"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.bar.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}


resource "aws_security_group" "ec2_web" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0451eaab4d3160c30"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}


##resource "aws_lb" "web-ext" {
##  name               = "web-tier-lb-ext"
##  internal           = false
##  load_balancer_type = "application"
##  security_groups    = [aws_security_group.ec2_web.id]
##  subnets            = []
##
##  enable_deletion_protection = true
##
##
##  tags = {
##    Environment = "production"
##  }
##}
##
##
##resource "aws_lb_listener" "front_end" {
##  load_balancer_arn = aws_lb.web-ext.arn
##  port              = "80"
##  protocol          = "HTTP"
##  ##ssl_policy        = "ELBSecurityPolicy-2016-08"
##  ##certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
##
##  default_action {
##    type             = "forward"
##    target_group_arn = aws_lb_target_group.front_end.arn
##  }
##}
##
##resource "aws_lb_listener_certificate" "example" {
##  listener_arn    = aws_lb_listener.front_end.arn
##  certificate_arn = aws_acm_certificate.example.arn
##}
##
##
##resource "aws_lb_listener_rule" "static" {
##  listener_arn = aws_lb_listener.front_end.arn
##  priority     = 100
##
##  action {
##    type             = "forward"
##    target_group_arn = aws_lb_target_group.static.arn
##  }
##
##  condition {
##    path_pattern {
##      values = ["/static/*"]
##    }
##  }
##
##  condition {
##    host_header {
##      values = ["example.com"]
##    }
##  }
##}
##
##
##
##resource "aws_lb_target_group" "test" {
##  name     = "tf-example-lb-tg"
##  port     = 80
##  protocol = "HTTP"
##  vpc_id   = aws_vpc.main.id
##}
##
##
##resource "aws_lb_target_group_attachment" "test" {
##  target_group_arn = aws_lb_target_group.test.arn
##  target_id        = aws_instance.test.id
##  port             = 80
##}
##
##
##
##