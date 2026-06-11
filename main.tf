module "infra" {
  source = "./modules/ec2"
  env           = terraform.workspace
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnets[0]   
  ec2_count = var.ec2_count
}
