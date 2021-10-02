#!/bin/bash
wget https://repo.zabbix.com/zabbix/5.4/debian/pool/main/z/zabbix-release/zabbix-release_5.4-1+debian11_all.deb
dpkg -i zabbix-release_5.4-1+debian11_all.deb
apt update
apt upgrade -y
apt install zabbix-proxy-sqlite3 zabbix-sql-scripts -y

mkdir -p /etc/zabbix/database
touch /etc/zabbix/database/zabbix.db
chown -R zabbix /etc/zabbix/database
zcat /usr/share/doc/zabbix-sql-scripts/sqlite3/schema.sql.gz | sqlite3 /etc/zabbix/database/zabbix.db

sed -i 's/# ProxyMode=0/ProxyMode=1/' /etc/zabbix/zabbix_proxy.conf
sed -i 's/Hostname=/#Hostname=/' /etc/zabbix/zabbix_proxy.conf
sed -i 's/#\ HostnameItem=/HostnameItem=/' /etc/zabbix/zabbix_proxy.conf
sed -i 's/Server\=127\.0\.0\.1/Server\=192\.168\.6\.11/' /etc/zabbix/zabbix_proxy.conf
sed -i 's/DBName=zabbix_proxy/DBName=\/etc\/zabbix\/database\/zabbix\.db/' /etc/zabbix/zabbix_proxy.conf


systemctl enable zabbix-proxy
systemctl start zabbix-proxy

apt install zabbix-agent

sed -i 's/Server\=127\.0\.0\.1/Server\=192\.168\.5\.11/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive\=127\.0\.0\.1/ServerActive\=192\.168\.5\.11/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/Hostname=/#Hostname=/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/#\ HostnameItem=/HostnameItem=/' /etc/zabbix/zabbix_agentd.conf

systemctl restart zabbix-agent
systemctl enable zabbix-agent

echo "up route add -net 192.168.6.0 netmask 255.255.255.0 gw 192.168.5.1" >> /etc/network/interfaces
echo "down route del -net 192.168.6.0 netmask 255.255.255.0 gw 192.168.5.1" >> /etc/network/interfaces

route add -net 192.168.6.0/24 gw 192.168.5.1
