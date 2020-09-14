Worker Node 1 scripts
+++++++++++++++++++++

    - Following are the scripts included:

        1. VagarantFile
        2. script.sh


VagrantFile
-----------

    .. code-block:: bash

        # -*- mode: ruby -*-
        # vi: set ft=ruby :

        # All Vagrant configuration is done below. The "2" in Vagrant.configure
        # configures the configuration version (we support older styles for
        # backwards compatibility). Please don't change it unless you know what
        # you're doing.
        Vagrant.configure("2") do |config|
        # The most common configuration options are documented and commented below.
        # For a complete reference, please see the online documentation at
        # https://docs.vagrantup.com.

        # Every Vagrant development environment requires a box. You can search for
        # boxes at https://vagrantcloud.com/search.
        config.vm.box = "bento/ubuntu-20.04"
        config.vm.host_name = "node1.ceph.osive.lab"
        #config.vm.network "public_network"
        config.vm.network "public_network", ip: "192.168.0.231"
        default_router = "192.168.0.1"
        config.vm.provision :shell, :inline => "ip route delete default 2>&1 >/dev/null || true; ip route add default via #{default_router}"
        #config.vm.provision "shell",

        # increase first root disk 
        
        config.disksize.size = '200GB'

        # Adding Persistant Storage volume to vbox VM
        config.persistent_storage.diskdevice = '/dev/sdb'  
        config.persistent_storage.enabled = true
        config.persistent_storage.location = "./ceph-disk.vdi"
        config.persistent_storage.size = 100000
        config.persistent_storage.use_lvm = false
        config.persistent_storage.partition = false
        #
        config.vm.provider "virtualbox" do |vb|
        #   # Display the VirtualBox GUI when booting the machine
        #   vb.gui = true
        #
        #   # Customize the amount of memory on the VM:
            
            vb.memory = "4096"
            vb.cpus = "4"
            vb.name = "ceph-node1"
            vb.customize ["modifyvm", :id, "--audio", "none"]

        end
        #

        # SHELL
        config.vm.provision :shell, :path=>"script.sh"
            
        end.

script.sh
---------

    .. code-block:: bash

        #!/bin/bash

        #basic pre-reqs
        sudo ufw disable
        echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
        echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
        echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
        echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
        sudo sed -i '/GRUB_CMDLINE_LINUX=/d'  /etc/default/grub
        echo  GRUB_CMDLINE_LINUX=\"net.ifnames=0 biosdevname=0 crashkernel=auto  ipv6.disable=1\" | sudo tee -a /etc/default/grub
        sudo update-grub2

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
        echo "DNS=192.168.0.5" | sudo tee -a /etc/systemd/resolved.conf 

        #add the custom "/etc/hosts" file 

        cat <<EOF > /etc/hosts 
        192.168.0.55 kara.osive.lab
        192.168.0.60 goku.osive.lab
        192.168.0.210 master.k8s.osive.lab
        192.168.0.211 node1.k8s.osive.lab
        192.168.0.212 node2.k8s.osive.lab
        192.168.0.213 node3.k8s.osive.lab

        192.168.0.230 master.ceph.osive.lab
        192.168.0.231 node1.ceph.osive.lab
        192.168.0.232 node2.ceph.osive.lab
        192.168.0.233 node3.ceph.osive.lab
        192.168.0.234 node4.ceph.osive.lab

        192.168.0.246 one.esxi.osive.lab

        127.0.0.1	localhost 
        127.0.1.1	vagrant.vm	vagrant
        EOF

        #local download download of packages 
                mkdir 2del 
                cd 2del 
        wget -c http://192.168.0.244:11000/packages.tar 
        tar -xvf ./packages.tar 
        sudo rsync -avPh ./var/cache/apt/archives/*.deb /var/cache/apt/archives/ 
        cd ..
        rm -rf 2del

        export DEBIAN_FRONTEND=noninteractive
        #installing pre-reqs 

        #wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -
        #echo deb https://download.ceph.com/debian-octopus/ focal main | sudo tee /etc/apt/sources.list.d/ceph.list

        sudo apt-get update
        sudo apt-get upgrade -y
        sudo apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg-agent \
            software-properties-common\
            chrony\
            build-essential\
            nmap \
            sshpass

        #docker install
        sudo apt-get -y install docker.io
        sudo usermod -aG docker vagrant
        sudo systemctl enable docker 

        #seting docker registry 
        sudo cat > /etc/docker/daemon.json <<EOF
        {
        "registry-mirrors": ["http://192.168.0.244:5000"],
        "live-restore": true,
        "dns": ["192.168.0.5"]
        }
        EOF

        sudo service docker restart

        #Enable root Login
        sudo su -
        echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config
        sudo sshpass -p "vagrant" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@master.ceph.osive.lab:/home/vagrant/ssh-keys/id_rsa.pub /root/.ssh/
        mv /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
        sudo chown -R root:root  /root/.ssh

        # Enable ssh password authentication
        sudo  sed -i '/PasswordAuthentication/d' /etc/ssh/sshd_config  
        echo "PasswordAuthentication yes" | sudo tee -a /etc/ssh/sshd_config 
        sudo systemctl reload sshd

        #set the hostname of the machine 
        sudo hostnamectl set-hostname node1.ceph.osive.lab  --static

        timedatectl set-timezone  Asia/Kolkata