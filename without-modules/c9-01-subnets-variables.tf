variable cidr_block_public {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
    type = list(string)
}
variable cidr_block_private {
    default = ["10.0.3.0/24", "10.0.4.0/24"]
    type = list(string)
}
variable public_subnet_count {
    default = 2
    type = string
}
variable private_subnet_count {
    default = 2
    type = string
}