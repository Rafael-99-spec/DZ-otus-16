# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
MACHINES = {
  :default => {
        :box_name => "centos/7",
  }
}
Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "192.168.11.10"
  config.vm.provider "virtualbox" do |vb|
  #   vb.gui = true
  vb.memory = "512"
  end
  # config.vm.provision "shell", inline: <<-SHELL
  # mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh
  # SHELL
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "pam.yml"
  end
end
