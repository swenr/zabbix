#!/bin/bash
wget https://repo.zabbix.com/zabbix/5.4/debian/pool/main/z/zabbix-release/zabbix-release_5.4-1+debian11_all.deb
dpkg -i zabbix-release_5.4-1+debian11_all.deb
apt update
apt upgrade -y
apt install zabbix-agent 

sed -i 's/Server\=127\.0\.0\.1/Server\=192\.168\.6\.11/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive\=127\.0\.0\.1/ServerActive\=192\.168\.6\.11/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/Hostname=/#Hostname=/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/#\ HostnameItem=/HostnameItem=/' /etc/zabbix/zabbix_agentd.conf

systemctl restart zabbix-agent
systemctl enable zabbix-agent 

