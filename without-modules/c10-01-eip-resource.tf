resource "aws_eip" "az1" {
  vpc      = true
  depends_on = [aws_internet_gateway.igw]
  tags = merge( {Name: "az1-${local.environment}"} , local.common_tags)
}
resource "aws_eip" "az2" {
  vpc      = true
  depends_on = [aws_internet_gateway.igw]
  tags = merge( {Name: "az2-${local.environment}"} , local.common_tags)
}