variable vpc_cidr {
    description = "Do you want DNS support in yout VPC?"
    default = "10.0.0.0/16"
    type = string
}
variable enable_dns_support {
    description = "Do you want DNS support in yout VPC?"
    default = true
    type = bool
}
variable enable_dns_hostnames {
    description = "Do you want DNS hostnames in your VPC?"
    default = true
    type = bool
}
