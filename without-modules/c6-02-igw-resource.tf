resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.jenkins.id
  tags = merge( {Name: "igw-${local.environment}"} , local.common_tags)
}