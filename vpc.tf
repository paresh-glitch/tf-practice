resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "${var.name}-vpc"
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "pub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "priv" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private_sub"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "pub_rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pub_nat.id

  }
}

# Public subnet → public route table
resource "aws_route_table_association" "pub_assoc" {
  subnet_id      = aws_subnet.pub.id
  route_table_id = aws_route_table.public_rt.id
}

# Private subnet → private route table
resource "aws_route_table_association" "priv_assoc" {
  subnet_id      = aws_subnet.priv.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}


resource "aws_nat_gateway" "pub_nat" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.pub.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

