Go Repository
==============

**Work FLow Diagram**

    .. image:: images/GO_nexus.png

Follow the steps below to get started with a go proxy caching repository

    * Login to nexus repository dashboard

        .. image:: ../images/nexus-dashboard.png


    * Create blob store for go repositories

        .. image:: images/go_blob.png


    * Create go proxy repository

        .. image:: images/go-proxy.png


    * Create a Go group repository and include proxy

        .. image:: images/go-group.png


    * Create a enviroment variable to use go proxy repository

        .. code-block:: bash

            export GOPROXY=http://192.168.0.166:8081/repository/go-group


        .. image:: images/export_var_goproxy.png