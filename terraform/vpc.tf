#VPC - possible to add route_table_id under VPC config in place of route Association
data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = "lovell-tf-vpc"
  }
}


#Subnets - possible to use for loop to reduce no. of copies of subnet code

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "lovell-tf-public-subnet-us-east-1a"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "lovell-tf-public-subnet-us-east-1b"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "lovell-tf-public-subnet-us-east-1c"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "lovell-tf-private-subnet-us-east-1a"
  }
}

resource "aws_subnet" "subnet5" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "lovell-tf-private-subnet-us-east-1b"
  }
}

resource "aws_subnet" "subnet6" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "lovell-tf-private-subnet-us-east-1c"
  }
}



#VPC endpoint -- if no VPC endpoint, traffic will first route from RT (within VPC) to public internet (outside VPC) then route to S3 bucket (within VPC). With VPC endpoint, traffic routes from RT to S3 bucket within VPC. So if VPC is public, may not even need VPC endpoint.

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.us-east-1.s3"
  #route_table_ids = [aws_route_table.public_rtb.id, aws_route_table.private_rtb1.id, aws_route_table.private_rtb2.id]

  tags = {
    Name = "lovell-tf-vpce-s3"
  }
}




#Route Tables

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"    # Allows you to connect to other EC2s in the different AZs but within same VPC
  }

  tags = {
    Name = "lovell-tf-public-rtb"
  }
}

resource "aws_route_table" "private_rtb1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "lovell-tf-private-rtb-az1"
  }
}

resource "aws_route_table" "private_rtb2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "lovell-tf-private-rtb-az2"
  }
}

resource "aws_route_table" "private_rtb3" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "lovell-tf-private-rtb-az3"
  }
}


#Route Table Associations

resource "aws_route_table_association" "route_table_public1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_rtb.id  #for public, can go up to internet
}

resource "aws_route_table_association" "route_table_public2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "route_table_public3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "route_table_private1" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.private_rtb1.id 
}

resource "aws_route_table_association" "route_table_private2" {
  subnet_id      = aws_subnet.subnet5.id
  route_table_id = aws_route_table.private_rtb2.id
}

resource "aws_route_table_association" "route_table_private3" {
  subnet_id      = aws_subnet.subnet6.id
  route_table_id = aws_route_table.private_rtb3.id
}



#Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "lovell-tf-igw"
  }
}



# # Uses an existing VPC, filtered by vpc_name in variables.tf
# data "aws_vpc" "selected_vpc" {
#   filter {
#     name   = "tag:Name"
#     values = [var.vpc_name]
#   }
# }

# # Uses an existing subnet on aws console, filtered by subnet_name in variables.tf
# data "aws_subnet" "selected_subnet" {
#   filter {
#     name   = "tag:Name"
#     values = [var.public_subnet_name1]
#   }
# }