resource "aws_route_table" "public" {
  vpc_id = aws_vpc.jenkins.id
  tags = merge( {Name: "public-${local.environment}"} ,local.common_tags)
}
resource "aws_route_table" "private-az1" {
  vpc_id = aws_vpc.jenkins.id
  tags = merge( {Name: "private-az1-${local.environment}"} ,local.common_tags)
}
resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}
resource "aws_route" "private-az1" {
  route_table_id = aws_route_table.private-az1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.gw-az1.id
}
resource "aws_route_table_association" "public" {
  count = var.public_subnet_count
  route_table_id = aws_route_table.public.id
  subnet_id = element(aws_subnet.public.*.id, count.index)
}
resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private-az1.id
  subnet_id = element(aws_subnet.private.*.id,1)
}