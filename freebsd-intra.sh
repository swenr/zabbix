pkg install -y zabbix5-agent
cp /usr/local/etc/zabbix5/zabbix_agentd.conf.sample /usr/local/etc/zabbix5/zabbix_agentd.conf

sed -i .org 's/Server\=127\.0\.0\.1/Server\=192\.168\.6\.11/' /usr/local/etc/zabbix5/zabbix_agentd.conf
sed -i .org 's/ServerActive\=127\.0\.0\.1/ServerActive\=192\.168\.6\.11/' /usr/local/etc/zabbix5/zabbix_agentd.conf
sed -i .org 's/Hostname=/#Hostname=/' /usr/local/etc/zabbix5/zabbix_agentd.conf
sed -i .org 's/#\ HostnameItem=/HostnameItem=/' /usr/local/etc/zabbix5/zabbix_agentd.conf



sysrc zabbix_agentd_enable="YES"
service zabbix_agentd start
