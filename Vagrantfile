# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  config.vm.define "vagrant1" do |vagrant1|

    vagrant1.vm.hostname = "vagrant1"
    vagrant1.vm.network "public_network", ip: "192.168.1.202"
    vagrant1.vm.provision "shell", run: "always", inline: <<-SHELL
    mkdir -p ~root/.ssh
    cp ~vagrant/.ssh/auth* ~root/.ssh
    ### Задача 1
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    yum install epel-release -y
    yum install pam_script -y
    echo "auth  required  pam_script.so" >> /etc/pam.d/sshd
    chmod +x /vagrant/pam_script
    cp /vagrant/pam_script /etc/
    systemctl restart sshd
    groupadd admin
    useradd -G admin vasya
    echo 123123123 | passwd vasya --stdin
    useradd petya
    echo 123123123 | passwd petya --stdin
    ### Задача 2
    #ставим пароль руту, чтобы можно было из-под юзера vasya получить root привилегии с помощью su root
    echo 12121212 | passwd root --stdin
    sed -i "10i account         sufficient      pam_succeed_if.so user = vasya use_uid quiet" /etc/pam.d/su
    sed -i 13d /etc/pam.d/su
    sed -i "13i account         required        pam_succeed_if.so user notin root:vagrant:vasya" /etc/pam.d/su
    ip a
    #Задача 2 через cap_sys_admin
    echo "cap_sys_admin vasya" > /etc/security/capability.conf
    sed -i "1i auth     optional     pam_cap.so" /etc/pam.d/su
  SHELL
  end
end
