module "s3_example" {
  source = "git::https://github.com/FadekeF/Terraform-Modules.git//modules/s3?ref=v1.0.0"

  name        = "example-s3-bucket"
  brand       = "BLC-UK"
  project     = "example-project"
  environment = "dev"
}
