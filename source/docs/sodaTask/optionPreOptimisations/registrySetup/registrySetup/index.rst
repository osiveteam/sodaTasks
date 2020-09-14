Registry Setup
==============

Requirements   
--------------

* The Registry is compatible with Docker engine version 1.6.0 or higher.

Quick Setup Guide
-----------------

**On server**

.. code:: bash

    $ docker run -d -p 5000:5000 \
        -e REGISTRY_PROXY_REMOTEURL=http://registry-1.docker.io \
        -v ~/docker/images:/var/lib/registry \
        --name registry \
        registry:2


* Checking docker registry

    .. code:: bash

        $ curl http://192.168.x.x:5000/v2/_catalog


**where ip(192.168.x.x) is the ip of the server or host machine itself to view all the images in the repository**

These images which are on the host machine can now be pulled by all other machines (clients) on the same network locally



* **On client** 
    
    * Add in /etc/docker/daemon.json

    .. code:: bash

        $    {
                "registry-mirrors": ["http://192.168.x.x:5000"] ,
                "live-restore": true,
                "debug": true,
                "dns": "192.169.x.x"
            }

    * Provide the ip of the server/host machine in registry-mirrors

        Restart docker service to apply changes

        .. code:: bash

            $ sudo systemctl restart docker

    .. note:: Each time after editing the daemon.json file After setting these configuration client will be pulling images from docker registry rather than downloading/pulling directly from docker hub

