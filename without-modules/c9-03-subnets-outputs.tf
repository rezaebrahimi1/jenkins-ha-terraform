output "subnet-public-id" {
  value = aws_subnet.public.*.id
}
output "subnet-private-id" {
  value = aws_subnet.private.*.id
}