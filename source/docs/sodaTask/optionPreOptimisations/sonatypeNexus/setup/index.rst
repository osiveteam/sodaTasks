Nexus Sonatype repository setup
+++++++++++++++++++++++++++++++

Sonatype Nexus Artifactory Initial Setup
=========================================

Follow the below steps to start with sonatype nexus for caching various repositories at single place.

    * Create a nexus/sonatype container.

        .. code-block:: bash

            docker run -d --name my-nexus -p 8081:8081 -p 10000-10010:10000-10010 -v $PWD:/nexus-data sonatype/nexus3

        .. image:: images/docker_run.png


    * Read the content of admin.password file for admin user default password

        .. code-block:: bash

            cat ./admin.password


        .. image:: images/cat_default_pass.png


    * Login to url ``http://localhost:8081``

        .. image:: images/login_nexus.png


    * Create new password

        .. image:: images/pass_reset.png

        .. image:: images/anon.png

Follow the steps to setup various repositories for lab enviroment optimisations.

    .. toctree::
        :maxdepth: 1
        :hidden:

        Sonatype Repositories Setup <./repoSetup/index.rst>
