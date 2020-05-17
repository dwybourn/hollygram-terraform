terraform {
  backend "s3" {
    bucket  = "terraform-state-hollygram.co.uk"
    key     = "terraform"
    encrypt = true
  }
}