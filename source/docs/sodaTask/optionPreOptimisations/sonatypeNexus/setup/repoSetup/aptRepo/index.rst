APT Repository
==============

**Work Flow Diagram**

    .. image:: images/nexus_APT.png


Please follow the below mentioned steps to get started with local APT caching repository


    * Create blob store for apt Repository

        .. image:: images/blob_store.png


    * Create a `apt-proxy` Repository

        .. image:: images/repo_new.png


        .. image:: images/apt-proxy.png


    * Edit ``sources.list`` for adding repo url

        .. code-block:: bash

            sudo nano /etc/sources.list

        .. image:: images/sources_list.png


    *  Update and upgrade the system


        .. code-block:: bash

            sudo apt update && sudo apt upgrade

        .. image:: images/apt_update.png