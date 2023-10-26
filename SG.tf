resource "aws_default_security_group" "default_sg" {
  vpc_id = aws_vpc.BSH_VPC.id
 
  ingress {
    protocol = "tcp"
    from_port = 0
    to_port = 65535
    cidr_blocks = [ var.vpc_cidr ]
  }
 
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
 
  tags = {
    Name = "default_sg"
    Description = "default security group"
  }
}
 
# bastion sg
resource "aws_security_group" "bastion_sg" {
  name = "bastion-sg"
  description = "bastion instance sg"
  vpc_id = aws_vpc.BSH_VPC.id
 
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
}
 
# Keycloak SG
resource "aws_security_group" "Keycloak_SG" {
  name = "Keycloak-SG"
  description = "Keycloak SG"
  vpc_id = aws_vpc.BSH_VPC.id
 
  ingress {
    from_port = 2022
    to_port = 2022
    protocol = "tcp"
    security_groups = [ aws_security_group.bastion_sg.id ]
  }
 
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.vpc_cidr ]
  }
 
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
}

# APP SG
resource "aws_security_group" "APP_SG" {
  name = "APP-SG"
  description = "APP SG"
  vpc_id = aws_vpc.BSH_VPC.id
 
  ingress {
    from_port = 2022
    to_port = 2022
    protocol = "tcp"
    security_groups = [ aws_security_group.bastion_sg.id ]
  }
 
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.vpc_cidr ]
  }
 
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
}

# InfluxDB SG
resource "aws_security_group" "InfluxDB_SG" {
  name = "InfluxDB-sg"
  description = "InfluxDB sg"
  vpc_id = aws_vpc.BSH_VPC.id
 
  ingress {
    from_port = 2022
    to_port = 2022
    protocol = "tcp"
    security_groups = [ aws_security_group.bastion_sg.id ]
  }
 
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.vpc_cidr ]
  }

  ingress {
    from_port = 8086
    to_port = 8086
    protocol = "tcp"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
}

# Grafana SG
resource "aws_security_group" "Grafana_SG" {
  name = "Grafana-SG"
  description = "Grafana SG"
  vpc_id = aws_vpc.BSH_VPC.id
 
  ingress {
    from_port = 2022
    to_port = 2022
    protocol = "tcp"
    security_groups = [ aws_security_group.bastion_sg.id ]
  }
 
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.vpc_cidr ]
  }
 
   ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.anyway_ipv4_cidr ]
  }
}