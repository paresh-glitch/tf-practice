module "infra" {
  source = "./modules/ec2"
  env           = terraform.workspace
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  vpc_id        = aws_vpc.main.id       # ✅ from vpc.tf
  subnet_id     = aws_subnet.pub.id     # ✅ from vpc.tf
  ec2_count = var.ec2_count
}
