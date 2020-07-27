#!/bin/sh
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
echo "toor" | passwd root --stdin 
echo allowed | passwd allowed --stdin
echo unable | passwd unable --stdin
usermod -G admin allowed
echo "auth  required  pam_script.so" >> /etc/pam.d/sshd
chmod +x /vagrant/pam_script
cp /vagrant/pam_script /etc/
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd
sed -i "10i account         sufficient      pam_succeed_if.so user = allowed use_uid quiet" /etc/pam.d/su
sed -i 13d /etc/pam.d/su
sed -i "13i account         required        pam_succeed_if.so user notin root:vagrant:allowed" /etc/pam.d/su
timedatectl set-ntp off
timedatectl set-time "2020-07-25 00:05:00"
systemctl restart sshd
