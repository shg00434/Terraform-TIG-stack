#=============================================================
#Routetable
#=============================================================
#PUB RT
resource "aws_default_route_table" "PUB_RT" {
    default_route_table_id = aws_vpc.BSH_VPC.default_route_table_id
    
    tags = {
      Name = var.PUB_RT_name
    }
}

#PUB RT 설정
resource "aws_route_table_association" "PUB_RT_association" {
    count = length(var.PUB_subnet_cidr)
    subnet_id = aws_subnet.PUB_subnet[count.index].id
    route_table_id = aws_default_route_table.PUB_RT.id
}


#PUB IGW 연결
resource "aws_route" "PUB_RT_IGW" {
  route_table_id = aws_default_route_table.PUB_RT.id
  destination_cidr_block = var.anyway_ipv4_cidr
  gateway_id = aws_internet_gateway.BSH_IGW.id
}

#PRI RT
resource "aws_route_table" "BSH_PRI_RT" {
    count = length(var.PUB_subnet_cidr)
    vpc_id = aws_vpc.BSH_VPC.id
    tags = {
      Name = var.PRI_RT_name[count.index]
    }
}

#Private RT 설정
resource "aws_route_table_association" "PRI_RT_APP" {
    count = length(var.APP_subnet_cidr)
    subnet_id = aws_subnet.APP_subnet[count.index].id
    route_table_id = aws_route_table.BSH_PRI_RT[count.index].id
}

resource "aws_route_table_association" "PRI_RT_DnG" {
    count = length(var.DnG_subnet_cidr)
    subnet_id = aws_subnet.DnG_subnet[count.index].id
    route_table_id = aws_route_table.BSH_PRI_RT[count.index].id
}


#NATG 연결
resource "aws_route" "BSH_PRI_RT_NATG" {
  count = length(var.PUB_subnet_cidr)
  route_table_id = aws_route_table.BSH_PRI_RT[count.index].id
  destination_cidr_block = var.anyway_ipv4_cidr
  nat_gateway_id = aws_nat_gateway.BSH_NATG[count.index].id
}
