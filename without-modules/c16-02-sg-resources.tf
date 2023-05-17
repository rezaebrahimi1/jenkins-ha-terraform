resource "aws_security_group" "master" {
  name = "master"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "worker" {
  name = "worker"
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
resource "aws_vpc_security_group_ingress_rule" "master-ssh" {
  security_group_id = aws_security_group.master.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 22
}
resource "aws_vpc_security_group_ingress_rule" "worker-ssh" {
  security_group_id = aws_security_group.worker.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 22
}