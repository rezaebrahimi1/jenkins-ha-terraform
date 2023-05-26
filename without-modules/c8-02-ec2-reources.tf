resource "aws_instance" "bastion" {
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id = element(aws_subnet.public.*.id, 0)
  ami = data.aws_ami.ami_raw.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.login.key_name
  user_data = base64encode(data.template_file.ssh_port_modify.rendered)
  provisioner "local-exec" {
    command = "aws ec2 associate-address --instance-id ${self.id} --public-ip ${aws_eip.az2.public_ip} --region us-east-1"
    
  }
  provisioner "file" {
    source      = ".ssh/login_key"
    destination = "/home/ec2-user/login_key"
    connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_eip.az2.public_ip
    private_key = file(".ssh/login_key")
    port        = 3085
    } 
  }
}