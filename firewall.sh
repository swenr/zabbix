echo 'net.inet.ip.forwarding=1' >> /etc/sysctl.conf
sysctl net.inet.ip.forwarding=1

pkg_add zabbix-agent

sed -i 's/Server\=127\.0\.0\.1/Server\=192\.168\.6\.11/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive\=127\.0\.0\.1/ServerActive\=192\.168\.6\.11/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/Hostname=/#Hostname=/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/#\ HostnameItem=/HostnameItem=/' /etc/zabbix/zabbix_agentd.conf

rcctl enable zabbix_agentd
rcctl start zabbix_agentd
