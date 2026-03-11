locals {
  account_id = data.aws_caller_identity.current.account_id
  #     resolved_workspace_name     = coalesce(var.workspace_name, terraform.workspace)
  #     standardized_workspace_name = join(var.name_separator, [var.organization, var.project, var.environment])
  #     standardized_name = lower(
  #         join(var.name_separator, compact([var.organization, var.project, var.environment, "apigw-lambda"])))
  # resource_name = coalesce(var.name_override, local.standardized_name)
  # create_explicit_deployment = var.create_deployment && !var.auto_deploy
  tags = {
    # Name                 = var.name
    Brand                = var.brand
    service              = var.project
    environment          = var.environment
    terraform_workspace  = terraform.workspace
    terraform_module     = "lambda"
    terraform_managed_by = "terraform"
    github_repository    = var.github_repository
  }
}
