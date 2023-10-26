#=============================================================
#ALB
#=============================================================

resource "aws_alb" "BSH_APP_ALB" {
    name = "BSH-APP-ALB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.Keycloak_SG,aws_security_group.APP_SG, aws_security_group.InfluxDB_SG, aws_security_group.Grafana_SG]
    subnets = [aws_subnet.PUB_subnet[0].id, aws_subnet.PUB_subnet[1].id]
}

resource "aws_alb_listener" "Key_Lis" {
    load_balancer_arn = aws_alb.BSH_APP_ALB.arn
    port = 8080
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_alb_target_group.Key_TG.arn
      type = "forward"
    }
}

resource "aws_alb_listener" "APP_Lis" {
    load_balancer_arn = aws_alb.BSH_APP_ALB.arn
    port = 80
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_alb_target_group.APP_TG.arn
      type = "forward"
    }
}

resource "aws_alb_listener" "DB_Lis" {
    load_balancer_arn = aws_alb.BSH_APP_ALB.arn
    port = 8086
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_alb_target_group.DB_TG.arn
      type = "forward"
    }
}

resource "aws_alb_listener" "Grafana_Lis" {
    load_balancer_arn = aws_alb.BSH_APP_ALB.arn
    port = 3000
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_alb_target_group.Grafana_TG.arn
      type = "forward"
    }
}


resource "aws_alb_target_group" "Key_TG" {
    name = "Key-TG"
    port = 8080
    protocol = "HTTP"
    vpc_id = aws_vpc.BSH_VPC.id   
    stickiness {
      enabled = "true"
      type = "lb_cookie"
      cookie_duration = 300
    }
}

resource "aws_alb_target_group" "APP_TG" {
    name = "Application-TG"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.BSH_VPC.id   
    stickiness {
      enabled = "true"
      type = "lb_cookie"
      cookie_duration = 300
    }
}

resource "aws_alb_target_group" "DB_TG" {
    name = "DB-TG"
    port = 8086
    protocol = "HTTP"
    vpc_id = aws_vpc.BSH_VPC.id    
    stickiness {
      enabled = "true"
      type = "lb_cookie"
      cookie_duration = 300
    }
}

resource "aws_alb_target_group" "Grafana_TG" {
    name = "Grafana-TG"
    port = 3000
    protocol = "HTTP"
    vpc_id = aws_vpc.BSH_VPC.id
    stickiness {
      enabled = "true"
      type = "lb_cookie"
      cookie_duration = 300
    }
}