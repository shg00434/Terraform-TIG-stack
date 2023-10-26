#!/bin/bash

sudo apt update -y
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
sudo wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
sudo echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt update -y
sudo apt install -y grafana
sudo systemctl enable grafana-server --now
sudo systemctl status grafana-server
cat << EOF >> /etc/grafana/grafana.ini

[server]
root_url: http://${localhost}:3000

[auth.generic_oauth]
enabled = true
name = Keycloak-OAuth
allow_sign_up = true
auto_login = false
client_id = grafana
client_secret = 
scopes = openid email profile
empty_scopes = false
email_attribute_name = email:primary
email_attribute_path = admin@grafana.com
login_attribute_path =
name_attribute_path =
id_token_attribute_name =
auth_url = http://${localhost}:8080/realms/Grafana/protocol/openid-connect/auth
token_url = http://${localhost}:8080/realms/Grafana/protocol/openid-connect/token
api_url = http://${localhost}:8080/realms/Grafana/protocol/openid-connect/userinfo
teams_url =
allowed_domains =
team_ids =
allowed_organizations =
role_attribute_path = contains(roles[*], 'admin') && 'Admin' || contains(roles[*], 'editor') && 'Editor' || 'Viewer'
role_attribute_strict = false
groups_attribute_path =
team_ids_attribute_path =
tls_skip_verify_insecure = false
tls_client_cert =
tls_client_key =
tls_client_ca =
use_pkce = false
auth_style =
allow_assign_grafana_admin = false
EOF

sudo sed -i 's/#Port 22/Port 2022/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
