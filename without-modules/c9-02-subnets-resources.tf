resource "aws_subnet" "public" {
  count = var.public_subnet_count
  vpc_id     = "${aws_vpc.jenkins.id}"
  cidr_block = element(var.cidr_block_public, count.index)
  availability_zone = element(var.azs,count.index)
  tags = merge({Name: "public-az-${count.index + 1}-${local.environment}"}, local.common_tags)
}
resource "aws_subnet" "private" {
  count = var.private_subnet_count
  vpc_id     = "${aws_vpc.jenkins.id}"
  cidr_block = element(var.cidr_block_private, count.index)
  availability_zone = element(var.azs,count.index)
  tags = merge({Name: "private-az-${count.index + 1}-${local.environment}"}, local.common_tags)
}