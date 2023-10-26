
#=============================================================
#Launch template
#=============================================================
#Keycloak
resource "aws_launch_template" "Keycloak_LT" {
  name = "BSH-Keycloak"
  image_id = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.BSH_key.key_name
  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [aws_security_group.Keycloak_SG.id]
  user_data = "${filebase64("./Keycloakdata.sh")}"
  tags = {
    Name =  var.key_server_name
  }
}

#Application 
resource "aws_launch_template" "Application_LT" {
    name = "BSH-Application"
    image_id = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.BSH_key.key_name
    monitoring {
      enabled = true
    }
    vpc_security_group_ids = [aws_security_group.APP_SG.id]
    user_data = base64encode(templatefile("./Appdata.sh", {
    localhost = aws_alb.BSH_APP_ALB.dns_name
    }))
    tags = {
    Name =  var.app_server_name
    }
}

#InfluxDB
resource "aws_launch_template" "DB_LT" {
  name = "BSH-InfluxDB"
  image_id = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.BSH_key.key_name
  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [aws_security_group.InfluxDB_SG.id]
  user_data = "${filebase64("./InfluxDBdata.sh")}"
  tags = {
    Name =  var.db_server_name
  }
}

#Grafana
resource "aws_launch_template" "Grafana_LT" {
  name          = "BSH-Grafana"
  image_id = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.BSH_key.key_name
  monitoring {
    enabled     = true
  }
  vpc_security_group_ids = [aws_security_group.Grafana_SG.id]
  user_data     = base64encode(templatefile("./Grafanadata.sh", {
  localhost   = aws_alb.BSH_APP_ALB.dns_name
  }))
  tags = {
    Name =  var.grafana_server_name
  }
}