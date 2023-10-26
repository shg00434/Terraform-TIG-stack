##############################################################################
#                               vpc variable                                 #
##############################################################################
 
vpc_cidr = "10.0.0.0/16"
PUB_subnet_cidr = ["10.0.0.0/24", "10.0.1.0/24"]
APP_subnet_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
DnG_subnet_cidr = ["10.0.4.0/24", "10.0.5.0/24"]

vpc_name = "terraform_vpc"
PRI_RT_name = ["PRI_RT-1", "PRI_RT-2"]
 
##############################################################################
#                               ec2 variable                                 #
##############################################################################
 
ami = "ami-0c9c942bd7bf113a2"
instance_type = "t2.micro"
key_server_name = "Keycloak"
app_server_name = "APP"
db_server_name = "InfluxDB"
grafana_server_name = "Grafana"
