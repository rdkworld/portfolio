terraform {
  backend "s3" {
    bucket         = <terraform_state_bucket>
    key            = "de-c4w4/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}