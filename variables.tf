variable "name" {
  description = "Project name"
  type        = string
}

variable "ec2_ami" {
  description = "EC2 AMI ID"
  type        = string
}

variable "ec2_type" {
  description = "EC2 instance type"
  type        = string
}


variable "ec2_count" {
  type = number
}
