resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-terra-key-ec2"
  public_key = file("${path.root}/terra-key-ec2.pub")
  tags = {
    Environment = var.env
  }
}

resource "aws_security_group" "my_sg" {
  name        = "${var.env}-my_sg"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id        # ✅ from variable

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.env}-sg"
    Environment = var.env
  }
}

resource "aws_instance" "my_insta" {
  key_name               = aws_key_pair.my_key.key_name
  subnet_id              = var.subnet_id       # ✅ from variable
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  ami                    = var.ami             # ✅ correct var name
  instance_type          = var.instance_type  # ✅ correct var name
  count = var.ec2_count
  root_block_device {
    volume_size = var.env == terraform.workspace ? 10 : 20
    volume_type = "gp3"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get upgrade -y
  EOF

  tags = {
    Name        = "${var.env}-ec2"
    Environment = var.env
  }
}
