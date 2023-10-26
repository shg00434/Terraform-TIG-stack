#!/bin/bash

sudo apt update -y
sudo apt install -y nginx
sudo systemctl enable --now nginx
sudo systemctl start nginx
sudo systemctl restart nginx

wget -q https://repos.influxdata.com/influxdb.key
echo '23a1c8836f0afc5ed24e0486339d7cc8f6790b83886c4c96995b88a061c5bb5d influxdb.key' | sha256sum -c && cat influxdb.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdb.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdb.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
sudo apt update -y
sudo apt install -y telegraf
sudo systemctl start telegraf

cat << EOF >> /etc/telegraf/telegraf.conf
[[outputs.influxdb_v2]]
  urls = ["http://${localhost}:8086"]
  token = "$INFLUX_TOKEN"
  organization = "org"
  bucket = "buc"


EOF

sudo sed -i 's/#Port 22/Port 2022/g' /etc/ssh/sshd_config
sudo systemctl restart sshd