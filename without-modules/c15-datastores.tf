data "aws_ami" "ami_raw" {
  most_recent      = true
  owners = [var.ami_owner]
  filter {
    name   = "name"
    values = [var.ami_name]
  }
}
data "template_file" "ssh_port_modify" {
  template = file("scripts/ssh_port_modify.ssh")
  vars = {
    ssh_port = var.bastion_ssh_port
  }
}