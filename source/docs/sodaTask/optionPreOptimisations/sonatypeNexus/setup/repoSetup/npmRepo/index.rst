NPM Repository
==============

**Workflow**

    .. image:: images/npm_nexus.png

Follow the steps mentioned below to get started with a maven caching repository

**Server Configuration**

    * Login to dashboard

        .. image:: ../images/nexus-dashboard.png

    * Create blob store for npm-private and npm-proxy

        .. image:: images/npm-private-blob.png

        .. image:: images/npm-proxy-blob.png

    * Create npm private Repository

        .. image:: images/npm-private.webp

    * Create npm proxy Repository

        .. image:: images/npm-proxy.webp

        .. image:: images/npm-proxy-2.webp

    * Create a group of proxy and private Repository

        .. image:: images/npm-group.webp

**Configuring your clients and projects to use your Nexus repos**

    * Generate username and password hash

        .. code-block:: bash

            echo -n 'admin:admin' | openssl base64


        .. image:: images/hash-gen.png


    * Create ``.npmrc`` file inthe root folder of the project directory and add

        .. code-block:: bash

             registry=http://192.168.0.166:8081/repository/npm-group/_auth=YWRtaW46YWRtaW4=

    * Update packages

        .. code-block:: bash

            npm install