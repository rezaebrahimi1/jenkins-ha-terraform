resource "aws_nat_gateway" "gw-az1" {
  allocation_id = aws_eip.az1.allocation_id
  subnet_id     = element(aws_subnet.public.*.id, 1)
  depends_on = [aws_internet_gateway.igw]
  tags = local.common_tags
}