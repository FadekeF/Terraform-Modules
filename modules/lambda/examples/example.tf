module "lambda" {
  source = "git::https://github.com/FadekeF/Terraform-Modules.git//modules/lambda?ref=v1.0.0"

  function_name        = "my-function"
  function_description = "My demo Lambda function"
  runtime              = "nodejs20.x"
  handler              = "index.handler"
  package_type         = "Zip"
  filename             = "${path.module}/lambda.zip"
  memory_size          = 128
  timeout              = 30
  reserved_concurrency = 1

  environment_variables = {
    ENV_VAR_1 = "value1"
    ENV_VAR_2 = "value2"
  }
}
