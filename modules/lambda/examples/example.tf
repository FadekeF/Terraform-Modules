module "lambda" {
  source = "git::https://github.com/FadekeF/Terraform-Modules.git//modules/lambda?ref=v1.0.0"

  functions = {
    example_function = {
      name                 = "example_lambda_function"
      package_type         = "Zip"
      runtime              = "nodejs20.x"
      handler              = "index.handler"
      layers               = []
      memory_size          = 128
      timeout              = 30
      reserved_concurrency = 1
    }
  }
}
