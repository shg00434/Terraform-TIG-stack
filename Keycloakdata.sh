#!/bin/bash
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk
sudo wget https://github.com/keycloak/keycloak/releases/download/21.1.2/keycloak-21.1.2.tar.gz
sudo tar -zxvf keycloak-21.1.2.tar.gz

 
export KEYCLOAK_ADMIN=admin
export KEYCLOAK_ADMIN_PASSWORD=123

sudo sed -i 's/#Port 22/Port 2022/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
 
sudo -E ./keycloak-21.1.2/bin/kc.sh start-dev &

# #!/bin/bash

# sudo apt-get update && sudo apt-get upgrade -y

# sudo apt install -y openjdk-11-jdk

# wget https://github.com/keycloak/keycloak/releases/download/21.1.2/keycloak-21.1.2.tar.gz
# sudo tar -xvf /home/ubuntu/keycloak-21.1.2.tar.gz

# cat << EOF >> ~/.bashrc

# export KEYCLOAK_ADMIN=admin
# export KEYCLOAK_ADMIN_PASSWORD=password

# EOF

# sudo source ~/.bashrc
# sudo -E ./keycloak-21.1.2/bin/kc.sh start-dev &

sudo sed -i 's/#Port 22/Port 2022/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
