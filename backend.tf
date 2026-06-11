terraform {
  backend "s3" {
    bucket       = "terra-pract-state-paresh"
    key          = "terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}
