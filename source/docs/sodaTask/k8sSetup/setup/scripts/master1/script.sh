#!/bin/bash

#basic pre-reqs
sudo ufw disable
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf

#removing swap
sudo swapoff -a
sudo sed -e '/swap/ s/^#*/#/' -i /etc/fstab



#resize root disk 
cat <<EOF | sudo fdisk /dev/sda   
n
p



t
3
8e
w
EOF


sudo partprobe 
sudo pvcreate /dev/sda3 
sudo vgextend vgvagrant /dev/sda3 

sudo lvextend -L 100G /dev/mapper/vgvagrant-root ;  sudo resize2fs /dev/vgvagrant/root

#################33


#set local DNS
echo "DNS=192.168.0.1" | sudo tee -a /etc/systemd/resolved.conf 

# Local Nexus apt repository linking [change credentials and ip address of repo]
# echo 'deb http://admin:admin123@192.168.0.244:8081/repository/ubuntu-updates bionic-updates main' > /etc/apt/sources.list && \
# echo 'deb http://admin:admin123@192.168.0.244:8081/repository/ubuntu bionic main' >> /etc/apt/sources.list


export DEBIAN_FRONTEND=noninteractive
#installing pre-reqs for docker
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg-agent \
     software-properties-common
#docker install
sudo apt-get -y install docker.io
sudo usermod -aG docker vagrant
sudo systemctl enable docker 

#seting docker registry (Uncomment below if using local registry setup)
# sudo cat > /etc/docker/daemon.json <<EOF
# {
# "registry-mirrors": ["http://192.168.0.244:5000"],
#  "live-restore": true,
#  "dns": ["192.168.0.5"]
# }
# EOF
# sudo service docker restart


#installing Rancher 

echo "docker run  --name rancher -d --restart=always -p 192.168.0.210:8000:80 -p 443:443 rancher/rancher" | tee /home/vagrant/runRancherOneTimeInstall
chmod +x /home/vagrant/runRancherOneTimeInstall

# Enable ssh password authentication

sudo  sed -i '/PasswordAuthentication/d' /etc/ssh/sshd_config  
echo "PasswordAuthentication yes" | sudo tee -a /etc/ssh/sshd_config 
sudo systemctl reload sshd