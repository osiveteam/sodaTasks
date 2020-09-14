Vagrant Setup
=============

Follow the below mentioned steps to get quickly started with vagrant enviroment

Vagrant Installation
---------------------

    * Install Ruby

        You must have a modern Ruby (>= 2.2) in order to develop and build Vagrant.
        
        - Install GPG keys for RVM (Ruby version manager):
        
        .. code-block:: bash

            gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
        
        -  For installing RVM with default Ruby and Rails in one command, run: 

        .. code-block:: bash

            curl -sSL https://get.rvm.io | bash -s stable --rails

    * Install Vagrant from binaries

        - Clone Vagrant's repository from GitHub into the directory where you keep code on your machine:

        .. code-block:: bash

            $ git clone https://github.com/hashicorp/vagrant.git

        - Next, ``cd`` into that path. All commands will be run from this path:
        
        .. code-block:: bash

            cd /path/to/your/vagrant/clone
        
        - Run the bundle command with a required version* to install the requirements:

        .. code-block:: bash

            bundle install
        
        - You can now run Vagrant by running ``bundle exec vagrant`` from inside that directory

        .. code-block:: bash

            bundle exec vagrant
        
        - Run the following command from the Vagrant repo:

         .. code-block:: bash

            bundle --binstubs exec

        - This will generate files in exec/, including vagrant and Create a symbolic link to your exec:

        .. code-block:: bash

            ln -sf /path/to/vagrant/exec/vagrant /usr/local/bin/vagrant
    

Install Required Plugins
-------------------------

    Required Vagrant plugins are:

    +-----+----------------------------+----------------------------------------------------------------+
    | Sno | Plugin Name                | Description                                                    |
    +-----+----------------------------+----------------------------------------------------------------+
    | 1   | vagrant-env                | Plugin to load environment variables from .env into ENV        |
    +-----+----------------------------+----------------------------------------------------------------+
    | 2   | vagrant-disksize           | Plugin to resize root disk                                     |
    +-----+----------------------------+----------------------------------------------------------------+
    | 3   | vagrant-persistent-storage | Creates a persistent storage and attaches it to guest machine. |
    +-----+----------------------------+----------------------------------------------------------------+


    * Vagrant plugin to load environment variables from .env into ENV

    .. code-block:: bash

        $ vagrant plugin install vagrant-env
    
    * Vagrant disk size plugin to resize root disk
    
    .. code-block:: bash

        vagrant plugin install vagrant-disksize
    
    .. note::

        *Example*

        ``config.disksize.size = '50GB'``
    
    * Vagrant plugin that creates a persistent storage and attaches it to guest machine.

    .. code-block:: bash

        $ vagrant plugin install vagrant-persistent-storage


        .. note:: 

        *Example Usage*
        
        config.persistent_storage.enabled = true
        config.persistent_storage.location = "~/development/sourcehdd.vdi"
        config.persistent_storage.size = 5000
        config.persistent_storage.mountname = 'mysql'
        config.persistent_storage.filesystem = 'ext4'
        config.persistent_storage.mountpoint = '/var/lib/mysql'
        config.persistent_storage.volgroupname = 'myvolgroup'
        

        .. important::

        After installing you can set the location and size of the persistent storage.

        The following options will create a persistent storage with 5000 MB, named ``docker``, mounted on ``/var/lib/docker``, in a volume group called ``'myvolgroup'``

        `Persistent storage <https://github.com/kusnier/vagrant-persistent-storage>`_

        .. image:: images/presistentStorage.png
