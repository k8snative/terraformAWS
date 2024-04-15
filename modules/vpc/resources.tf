resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.vpc_name}-InternetGateway"
  }
}



resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet1_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-PublicSubnet1"
  }

}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet2_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-PublicSubnet2"
  }
}

resource "aws_subnet" "public_subnet3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet3_cidr
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-PublicSubnet3"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet1_cidr
  availability_zone       = "us-east-1a"
  tags = {
    Name = "${var.vpc_name}-PrivateSubnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet2_cidr
  availability_zone       = "us-east-1b"
  tags = {
    Name = "${var.vpc_name}-PrivateSubnet2"
  }
}

resource "aws_subnet" "private_subnet3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet3_cidr
  availability_zone       = "us-east-1c"
  tags = {
    Name = "${var.vpc_name}-PrivateSubnet3"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.vpc_name}-PublicRoutetable"
  }
}

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.internet_gateway.id
  
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet3_association" {
  subnet_id      = aws_subnet.public_subnet3.id
  route_table_id = aws_route_table.public_route_table.id
}

######################

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet1.id
  tags = {
    Name = "${var.vpc_name}-NatGateway"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.vpc_name}-EIP"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.vpc_name}-PrivateRouteTable"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet3_association" {
  subnet_id      = aws_subnet.private_subnet3.id
  route_table_id = aws_route_table.private_route_table.id
}

#################### outputs.tf
output "vpc_id" {
  description = "The ID of the VPC created"
  value       = aws_vpc.my_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets created"
  value       = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id, aws_subnet.public_subnet3.id]
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets created"
  value       = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id, aws_subnet.private_subnet3.id]
}