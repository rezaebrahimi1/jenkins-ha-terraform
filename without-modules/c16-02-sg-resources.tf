resource "aws_security_group" "master" {
  name = "master"
  vpc_id = aws_vpc.jenkins.id
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "worker" {
  name = "worker"
  vpc_id = aws_vpc.jenkins.id
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "bastion" {
  name = "bastion"
  vpc_id = aws_vpc.jenkins.id
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_vpc_security_group_ingress_rule" "master-web" {
  security_group_id = aws_security_group.master.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 8080
}
resource "aws_vpc_security_group_egress_rule" "master-egress" {
  security_group_id = aws_security_group.master.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 65535
}
resource "aws_vpc_security_group_ingress_rule" "master-ssh" {
  security_group_id = aws_security_group.master.id
  referenced_security_group_id = aws_security_group.bastion.id
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 22
}
resource "aws_vpc_security_group_ingress_rule" "worker-ssh" {
  security_group_id = aws_security_group.worker.id
  referenced_security_group_id = aws_security_group.bastion.id
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 22
}
resource "aws_vpc_security_group_egress_rule" "worker-egress" {
  security_group_id = aws_security_group.worker.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 65535
}
resource "aws_vpc_security_group_ingress_rule" "bastion-ssh" {
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 3085
}
resource "aws_vpc_security_group_egress_rule" "bastion-eqress" {
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 65535
  }