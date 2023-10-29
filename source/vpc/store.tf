resource "aws_ssm_parameter" "vpc" {
  name  = format("/%s/%s", "project", "vpc")
  type  = "String"
  value = aws_vpc.main.id
}


resource "aws_ssm_parameter" "public_subnet" {
  name  = format("/%s/%s", "project", "public_subnet")
  type  = "String"
  value = aws_subnet.public_subnet.id
}


resource "aws_ssm_parameter" "public_subnet2" {
  name  = format("/%s/%s", "project", "public_subnet2")
  type  = "String"
  value = aws_subnet.public_subnet2.id
}


resource "aws_ssm_parameter" "private_subnet" {
  name  = format("/%s/%s", "project", "private_subnet")
  type  = "String"
  value = aws_subnet.private_subnet.id
}

