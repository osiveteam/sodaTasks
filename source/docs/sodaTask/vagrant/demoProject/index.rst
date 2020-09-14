Vagrant Sample Project
=======================

    * Make a directory for vagrant using mkdir
        
    .. code:: bash

        $ mkdir vagrant
        $ cd vagrant/

    * Make a directory inside Vagrant and give the name of VM & cd into it

    .. code:: bash

        $ mkdir ubuntu
        $ cd ubuntu/

    .. important::

        Discover `Vagrant Boxes <https://app.vagrantup.com/boxes/search>`_

        Search your required image

    * Download the image of ubuntu-20.04 in directory

    Open the same directory in the terminal & use the following command for downloading the image of the VM

    .. code:: bash

        $ vagrant init bento/ubuntu-20.04

    * Replace generated vagrant file with the below:

    .. code-block:: bash

        # -*- mode: ruby -*-
        # vi: set ft=ruby :

        # All Vagrant configuration is done below. The "2" in Vagrant.configure
        # configures the configuration version (we support older styles for
        # backwards compatibility). Please don't change it unless you know what
        # you're doing.
        Vagrant.configure("1") do |config|
            config.vm.box = "bento/ubuntu-20.04"
            config.vm.host_name = "saki"
            config.vm.network "public_network", bridge: "Intel(R) 82579LM Gigabit Network Connection"
                
            config.persistent_storage.enabled = true
            config.persistent_storage.location = "~/development/sourcehdd.vdi"
            config.persistent_storage.size = 5000
            config.persistent_storage.mountname = 'docker'
            config.persistent_storage.filesystem = 'ext4'
            config.persistent_storage.mountpoint = '/var/lib/docker'
            config.persistent_storage.volgroupname = 'myvolgroup'
            
            config.disksize.size = '50GB'
            
        
        # The most common configuration options are documented and commented below.
        # For a complete reference, please see the online documentation at
        # https://docs.vagrantup.com.

        # Every Vagrant development environment requires a box. You can search for
        # boxes at https://vagrantcloud.com/search.
        

        # Disable automatic box update checking. If you disable this, then
        # boxes will only be checked for updates when the user runs
        # `vagrant box outdated`. This is not recommended.
        # config.vm.box_check_update = false

        # Create a forwarded port mapping which allows access to a specific port
        # within the machine from a port on the host machine. In the example below,
        # accessing "localhost:8080" will access port 80 on the guest machine.
        # NOTE: This will enable public access to the opened port
        # 

        # Create a forwarded port mapping which allows access to a specific port
        # within the machine from a port on the host machine and only allow access
        # via 127.0.0.1 to disable public access
        # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

        # Create a private network, which allows host-only access to the machine
        # using a specific IP.
        # config.vm.network "private_network", ip: "192.168.33.10"

        # Create a public network, which generally matched to bridged network.
        # Bridged networks make the machine appear as another physical device on
        # your network.
        # config.vm.network "public_network"

        # Share an additional folder to the guest VM. The first argument is
        # the path on the host to the actual folder. The second argument is
        # the path on the guest to mount the folder. And the optional third
        # argument is a set of non-required options.
        # config.vm.synced_folder "../data", "/vagrant_data"

        # Provider-specific configuration so you can fine-tune various
        # backing providers for Vagrant. These expose provider-specific options.
        # Example for VirtualBox:
        #
        # config.vm.provider "virtualbox" do |vb|
        #   # Display the VirtualBox GUI when booting the machine
        #   vb.gui = true
        #
        #   # Customize the amount of memory on the VM:
        #   vb.memory = "1024"
        # end
        #
        # View the documentation for the provider you are using for more
        # information on available options.

        # Enable provisioning with a shell script. Additional provisioners such as
        # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
        # documentation for more information about their specific syntax and use.
        # config.vm.provision "shell", inline: <<-SHELL
        #   apt-get update
        #   apt-get install -y apache2
        # SHELL
        config.vm.provision :shell, :path=>"script.sh"
        end


    * Set the size you want for one disk in your Vagrantfile

    Open the vagrant file inside your VM directory

    * Provide Host Name & give network as bridge

    .. code:: bash

        config.vm.host_name ="saki"

    & network to be bridged

    .. code:: bash

        $ config.vm.network "public_network", ip: "192.168.0.245"
        default_router = "192.168.0.1"
        config.vm.provision :shell, :inline => "ip route delete default 2>&1 >/dev/null || true; ip route add default via #{default_router}"


    * The script.sh file here will be uploaded & executed via Vagrant shell provisioner-

    Use script file below to get started with your Project
    
    .. code-block:: bash

        #!/bin/bash

        # install docker in the virtual machine
        sudo apt-get update
        #SET UP THE REPOSITORY
        sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg-agent \
            software-properties-common
        #docker install     
        sudo apt-get install docker.io
        # adding docker registry in the vagrant script.sh
        sudo mkdir /etc/docker
        ls -l /etc/docker/
        echo " registry-mirrors" | sudo tee /etc/docker/daemon.json
        echo "\"registry-mirrors\": [\"http://192.168.0.244:5000\"]," | sudo tee -a /etc/docker/daemon.json ;cat /etc/docker/daemon.json

    Execute ``script.sh`` within the guest machine

        .. image:: images/addingScript.png
    
    **Script Contents:**
    
    Adding docker registry in the guest virtual machine

    .. code:: bash

        sudo mkdir /etc/docker
        ls -l /etc/docker/
        echo " registry-mirrors" | sudo tee /etc/docker/daemon.json
        echo "\"registry-mirrors\": [\"http://192.168.0.244:5000\"]," | sudo tee -a /etc/docker/daemon.json ;cat /etc/docker/daemon.json

    * Hit command in the terminal

    .. code:: bash

        $ vagrant up