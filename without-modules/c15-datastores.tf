data "aws_ami" "ami_raw" {
  most_recent      = true
  owners = [var.ami_owner]
  filter {
    name   = "name"
    values = [var.ami_name]
  }
}