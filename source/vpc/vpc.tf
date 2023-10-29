resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.vpc_tenancy
  provider         = aws.practice_region

  tags = {
    Name = var.vpc_name
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet
  availability_zone = var.az1

  tags = {
    Name = var.public_subnet
  }
}


resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet2
  availability_zone = var.az2

  tags = {
    Name = var.public_subnet2
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet
  availability_zone = var.az1

  tags = {
    Name = var.private_subnet
  }
}


resource "aws_internet_gateway" "practice_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.gateway_name
  }
}



resource "aws_eip" "practice_eip" {

}


resource "aws_nat_gateway" "practice_ngw" {
  allocation_id = aws_eip.practice_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = var.nat-gateway-name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.practice_gateway]
}


resource "aws_route_table" "practice_pub_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.ngw_cidr
    gateway_id = aws_internet_gateway.practice_gateway.id
  }
  tags = {
    Name = var.practice_pub_rt_name
  }
}


resource "aws_route_table" "practice_private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = var.ngw_cidr
    nat_gateway_id = aws_nat_gateway.practice_ngw.id
  }

  tags = {
    Name = var.practice_private_rt_name
  }
}


resource "aws_route_table_association" "practice_rta_pub" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.practice_pub_rt.id
}


resource "aws_route_table_association" "practice_rta_pr" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.practice_private_rt.id
}



resource "aws_lb" "practice_lb" {
  name                       = var.lb-name
  internal                   = false
  load_balancer_type         = var.lb_type
  security_groups            = [aws_security_group.lb_sg.id]
  subnets                    = [aws_subnet.public_subnet.id, aws_subnet.public_subnet2.id]
  enable_deletion_protection = false

  tags = {
    Name = var.lb-name
  }
}



resource "aws_security_group" "lb_sg" {
  name        = var.lb_sg_name
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = var.web
    to_port     = var.web
    protocol    = var.lb_protocol
    cidr_blocks = var.default_route

  }

  egress {
    from_port        = var.web
    to_port          = var.web
    protocol         = var.lb_protocol
    cidr_blocks      = var.lb_out
    ipv6_cidr_blocks = [var.ngw_cidr_v6]
  }

  tags = {
    Name = var.lb_sg_name
  }
}


resource "aws_security_group" "instance_sg" {
  name        = var.instance_sg_name
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "TLS from VPC"
    from_port       = var.web
    to_port         = var.web
    protocol        = var.lb_protocol
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port   = var.web
    to_port     = var.web
    protocol    = var.lb_protocol
    cidr_blocks = var.default_route
  }

  tags = {
    Name = var.instance_sg_name
  }
}


resource "aws_lb_target_group" "web-group" {
  name     = var.web-group
  port     = var.web
  protocol = var.lb_listener_protocol
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = var.web-group
  }
}



resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.practice_lb.arn
  port              = var.web
  protocol          = var.lb_listener_protocol
  #   ssl_policy        = "ELBSecurityPolicy-2016-08"
  #   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = var.lb_action
    target_group_arn = aws_lb_target_group.web-group.arn
  }
}


resource "aws_lb_target_group_attachment" "project_lb_tg_attachment" {
  target_group_arn = aws_lb_target_group.web-group.arn
  target_id        = var.target_id
  port             = var.web
}

