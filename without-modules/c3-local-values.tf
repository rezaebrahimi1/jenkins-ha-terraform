locals {
  environment = var.env
  owner = var.owner
  name = "${local.owner}-${local.environment}"
  common_tags = {
    owner = local.owner
    environment = local.environment
  }
}
