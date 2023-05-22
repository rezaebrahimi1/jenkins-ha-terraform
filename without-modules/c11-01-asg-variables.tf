variable "master_ami_type" {
    type = string
    default = "c4.large"
}
variable "worker_ami_type" {
    type = string
    default = "c4.large"
}
variable "ami_name" {
  description = "The name of the amzn2 ami. Used for searching for AMI id."
  type        = string
  default     = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
}

variable "ami_owner" {
  description = "The owner of the amzn2 ami."
  type        = string
  default     = "amazon"
}

