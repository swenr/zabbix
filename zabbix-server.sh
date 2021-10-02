#!/bin/bash
wget https://repo.zabbix.com/zabbix/5.4/debian/pool/main/z/zabbix-release/zabbix-release_5.4-1+debian11_all.deb
dpkg -i zabbix-release_5.4-1+debian11_all.deb
apt update
apt upgrade -y
apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-nginx-conf zabbix-sql-scripts zabbix-agent postgresql -y
sudo -u postgres psql -c "create user zabbix with login password 'zabbix';"  
sudo -u postgres createdb -O zabbix -E Unicode -T template0 zabbix
zcat /usr/share/doc/zabbix-sql-scripts/postgresql/create.sql.gz | sudo -u zabbix psql zabbix 
echo "DBPassword=zabbix" >> /etc/zabbix/zabbix_server.conf 
touch /etc/zabbix/web/zabbix.conf.php
chown www-data /etc/zabbix/web/zabbix.conf.php
sed -i 's/#//g' /etc/zabbix/nginx.conf
sed -i 's/example.com/192.168.6.11/' /etc/zabbix/nginx.conf
systemctl restart zabbix-server zabbix-agent nginx php7.4-fpm postgresql
systemctl enable zabbix-server zabbix-agent nginx php7.4-fpm postgresql
echo "up route add -net 192.168.5.0 netmask 255.255.255.0 gw 192.168.6.1" >> /etc/network/interfaces
echo "down route del -net 192.168.5.0 netmask 255.255.255.0 gw 192.168.6.1" >> /etc/network/interfaces

route add -net 192.168.5.0/24 gw 192.168.6.1
