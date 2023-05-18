resource "aws_key_pair" "login" {
  key_name_prefix = "login"
  public_key = file(".ssh/login_key.pub")
}