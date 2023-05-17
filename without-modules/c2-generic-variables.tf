variable aws_region {
    description = " The region where your infrustructure is going to be deployed"
    default = "us-east-1"
    type = string
}
variable owner {
    description = "The a of thiese resources"
    default = "Rezeebi"
    type = string
}
variable env {
    description = "Which environment resources are going to be deployed on"
    default = "dev"
    type = string
}
variable "azs" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]  
}
