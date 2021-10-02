# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|


  config.vm.define "pfSense" do |config|
    config.vm.box = "swenr/pfSense"
#    config.vm.box = "pfsense3"
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.ssh.shell = "/bin/sh"
    config.vm.hostname = "pfSense"
    config.vm.network "private_network", ip: "192.168.6.1/24", name: "vboxnet6"
    config.vm.network "private_network", ip: "192.168.5.1/24", name: "vboxnet5"
#    config.vm.provision "shell", path: "firewall.sh"
  end

  config.vm.define "zabbix-proxy" do |config|
    config.vm.box = "swenr/debian"
    config.vm.hostname = "zabbix-proxy"
    config.vm.network "private_network", ip: "192.168.5.11/24", name: "vboxnet5"
    config.vm.provision "shell", path: "zabbix-proxy.sh"
  end
  
  config.vm.define "zabbix-server" do |config|
    config.vm.box = "swenr/debian"
    config.vm.hostname = "zabbix-server"
    config.vm.network "private_network", ip: "192.168.6.11/24", name: "vboxnet6"
    config.vm.provision "shell", path: "zabbix-server.sh"
  end
 
  config.vm.define "linux-dmz" do |config|
    config.vm.box = "swenr/debian"
    config.vm.hostname = "linux-dmz"
    config.vm.network "private_network", ip: "192.168.5.12/24", name: "vboxnet5"
    config.vm.provision "shell", path: "linux-dmz.sh"
  end

  config.vm.define "linux-intra" do |config|
    config.vm.box = "swenr/debian"
    config.vm.hostname = "linux-inter"
    config.vm.network "private_network", ip: "192.168.6.12/24", name: "vboxnet6"
    config.vm.provision "shell", path: "linux-intra.sh"
  end
  
  config.vm.define "freebsd-intra" do |config|
    config.vm.box = "generic/freebsd13"
    config.vm.hostname = "freebsd-intra"
    config.vm.network "private_network", ip: "192.168.6.13/24", name: "vboxnet6"
    config.vm.provision "shell", path: "freebsd-intra.sh"
  end

  config.vm.define "openbsd-intra" do |config|
    config.vm.box = "generic/openbsd6"
    config.vm.hostname = "openbsd-intra"
    config.vm.network "private_network", ip: "192.168.6.14/24", name: "vboxnet6"
    config.vm.provision "shell", path: "openbsd-intra.sh"
  end

end
