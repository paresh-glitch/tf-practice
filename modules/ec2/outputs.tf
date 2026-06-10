output "ec2_private_ip" {
  value = aws_instance.my_insta[*].private_ip
}

output "ec2_public_dns" {
  value = aws_instance.my_insta[*].public_dns
}

output "ec2_public_ip" {
  value = aws_instance.my_insta[*].public_ip
}
