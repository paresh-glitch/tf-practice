output "ec2_public_ip" {
  value = module.infra.ec2_public_ip      # from module output
}

output "ec2_public_dns" {
  value = module.infra.ec2_public_dns      # from module output
}

output "ec2_private_ip" {
  value = module.infra.ec2_private_ip      # from module output
}
