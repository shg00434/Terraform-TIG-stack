resource "aws_subnet" "PUB_subnet" {
  count = length(var.PUB_subnet_cidr)
  vpc_id = aws_vpc.BSH_vpc.id
  cidr_block = var.PUB_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
 
  tags = {
    Name = var.PUB_subnet_name[count.index]
  }
}

resource "aws_subnet" "APP_subnet" {
  count = length(var.APP_subnet_cidr)
  vpc_id = aws_vpc.BSH_vpc.id
  cidr_block = var.APP_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
 
  tags = {
    Name = var.APP_subnet_name[count.index]
  }
}

resource "aws_subnet" "DnG_subnet" {
  count = length(var.DnG_subnet_cidr)
  vpc_id = aws_vpc.BSH_vpc.id
  cidr_block = var.DnG_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
 
  tags = {
    Name = var.DnG_subnet_name[count.index]
  }
}

#IGW
resource "aws_internet_gateway" "BSH_IGW" {
    vpc_id = aws_vpc.BSH_VPC.id
    tags = {
      Name = var.internet_gateway_name
    }
}

#Eip
resource "aws_eip" "BSH_Eip" {
  count = length(var.PUB_subnet_cidr)
  domain = "vpc"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "BSH_EIP"
  }
  
}

#NATG
resource "aws_nat_gateway" "BSH_NATG" {
  count = length(var.PUB_subnet_cidr)
  allocation_id = aws_eip.BSH_Eip[count.index].id
  subnet_id = aws_subnet.PUB_subnet[count.index].id
  tags = {
    Name = var.Nat_gateway_name[count.index]
  }
}