Deploy Ceph storage cluster
+++++++++++++++++++++++++++

Requirements
============

The following are the ubuntu server details 

    .. csv-table:: a title
        :header: "Hostname", "IP address"
        :widths: 20, 20

        "master.ceph.osive.lab", "192.168.0.230"
        "node1.ceph.osive.lab", "192.168.0.231"
        "node2.ceph.osive.lab", "192.168.0.232"


Deploy Ceph Cluster VMs
=======================

We are using vagrant to deploy ceph cluster VMs


Deploy ceph
============

    
    Change to root user

        .. code-block:: bash

            sudo su -
    

    Download the cephadm and ceph-common tools

        .. code-block:: bash

            apt install cephadm ceph-common

    Start the bootstrap process

        .. code-block:: bash

            cephadm bootstrap --mon-ip 192.168.0.230 --allow-fqdn-hostname

    Copy ssh key to nodes

        .. code-block:: bash

            ssh-copy-id -f -i /etc/ceph/ceph.pub root@node1.ceph.osive.lab
            ssh-copy-id -f -i /etc/ceph/ceph.pub root@node2.ceph.osive.lab

    Inform new node is part of the cluster

    .. code-block:: bash

        ceph orch host add node1.ceph.osive.lab
        ceph orch host add node2.ceph.osive.lab

    **Donot deploy mon as cephadm automatically deploys it**

    To deploy Monitors (2 ways to deploy monitors)

    
    Option-1 Using host Inform

        Deploy monitors on hosts

        .. code-block:: bash

            ceph orch apply mon root@node1.ceph.osive.lab,  root@node2.ceph.osive.lab, root@node3.ceph.osive.lab

    
    Option-2 Using Host labels (Recommended)

        control which hosts the monitors run on by making use of host labels.

            .. code-block:: bash

                ceph orch host label add node1.ceph.osive.lab mon
                ceph orch host label add node2.ceph.osive.lab mon
                #ceph orch host label add node3.ceph.osive.lab mon

        To view the current hosts and labels

            .. code-block:: bash

                ceph orch host ls

        Inform cephadm to deploy monitors based on the label 

            .. code-block:: bash

                ceph orch apply mon label:mon


    An inventory of storage devices on all cluster hosts can be displayed

        .. code-block:: bash

            ceph orch device ls

    To consume storage device for pool

        For consuming all devices available in the cluster    

            .. code-block:: bash

                ceph orch apply osd --all-available-devices
    
        Consuming specific device from the node   

            .. code-block:: bash

                ceph orch daemon add osd node1.ceph.osive.lab:/dev/sdb
                ceph orch daemon add osd node2.ceph.osive.lab:/dev/sdb

    

    Create Rados Gateway realm and zone (Not required)

    ..  code-block:: bash

        radosgw-admin realm create --rgw-realm=datreon --default

        radosgw-admin zonegroup create --rgw-zonegroup=delhi  --master --default

        radosgw-admin zone create --rgw-zonegroup=osive --rgw-zone=<zone-name> --master --default

        radosgw-admin period update --rgw-realm=datreon --commit
    



Troubleshooting commands
========================

Additional Cluster commands for troubleshoot

    Present a preview of what will happen without actually creating the OSDs.

        ..  code-block:: bash

            ceph orch apply osd --all-available-devices --dry-run
    
    Display avaiable OSDs 

        .. code-block:: bash
        
            ceph orch device ls