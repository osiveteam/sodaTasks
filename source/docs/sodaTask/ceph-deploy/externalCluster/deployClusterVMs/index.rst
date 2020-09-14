Deploy Cluster VMs 
+++++++++++++++++++

Pre requisites
===============

1. Sudo priviledged user
2. 10GB minimum RAM for 3 VMs
3. Vagrant
4. Vagrant Disk size plugin
5. Vagarnt Persistant volume plugin


Initial Setup (Prerequisites)
-----------------------------

**Install Vagrant**

    .. code-block:: bash

        sudo apt install vagrant

**Install Vagrat plugins for disk size and Persistant storage**

    .. code-block:: bash

        # Vagrant disk size plugin
        vagrant plugin install vagrant-disksize

        # Vagrant Persistant storage plugin
        vagrant plugin install vagrant-persistent-storage

**Create Vangrant files as below**

    .. toctree::
        :maxdepth: 1

        masterNode/index.rst
        workerNode1/index.rst
        workerNode2/index.rst