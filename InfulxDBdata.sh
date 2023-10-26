#!/bin/bash
#=============================================================
#InfluxDB1.x
#=============================================================
wget https://dl.influxdata.com/influxdb/releases/influxdb_1.8.9_amd64.deb
sudo dpkg -i influxdb_1.8.9_amd64.deb
sudo systemctl start influxdb

sudo sed -i 's/#Port 22/Port 2022/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
#=============================================================
#InfluxDB 2.x 
#=============================================================
# influxdata-archive_compat.key GPG fingerprint:
# #     9D53 9D90 D332 8DC7 D6C8 D3B9 D8FF 8E1F 7DF8 B07E

# wget -q https://repos.influxdata.com/influxdata-archive_compat.key
# echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
# echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
# sudo apt-get -y update

# sudo apt install -y influxdb2

# sudo systemctl start influxdb

# sudo systemctl status influxdb

# sudo influxd
# sudo influx setup --username test --password 'password' --org org --bucket buc --retention 1w --force 
# sudo influx org create -n org
# sudo influx user create -n BSH -p password1! -o org
# sudo influx bucket create -n telegraf -o org -r 72h
# INFLUX_TOKEN=$(sudo influx auth create -o org -d All-access --all-access --json | grep -o '"token": "[^"]*' | cut -d'"' -f4)
# sudo sed -i 's/#Port 22/Port 2022/g' /etc/ssh/sshd_config
# sudo systemctl restart sshd