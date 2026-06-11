module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${terraform.workspace}-my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  single_nat_gateway  = true

  tags = {
    Terraform = "true"
    Environment = terraform.workspace
  }
}
