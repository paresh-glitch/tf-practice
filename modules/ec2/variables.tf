variable env {
  #description = Environment name
  type        = string
}

variable ami {
  #description = EC2 AMI ID
  type        = string
}

variable instance_type {
  #description = EC2 instance type
  type        = string
}

variable vpc_id {
  #description = VPC ID
  type        = string
}

variable subnet_id {
  #description = Subnet ID
  type        = string
}

variable ec2_count {
  type = number
}
