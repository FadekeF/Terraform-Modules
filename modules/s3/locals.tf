locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.id

  tags = {
    Name                 = var.name
    Brand                = var.brand
    service              = var.project
    environment          = var.environment
    terraform_workspace  = terraform.workspace
    terraform_module     = "lambda"
    terraform_managed_by = "terraform"
    github_repository    = var.github_repository
  }
}
