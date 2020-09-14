Maven Repository
+++++++++++++++++

**Work Flow**

    .. image:: images/nexus_maven.png

Follow the below mentioned steps to get started and with maven repository on Nexus Sonatype 3

    * Login to nexus Repository Dashboard

        .. image:: ../images/nexus-dashboard.png


    * Create a blob store for maven Repositories

        .. image:: images/mvn-blob.png


    * Create ``maven group`` for grouping the existing maven release, snapshot, central repositories.

        .. image:: images/mvn-group.png


    * Create setting.xml file in ~/.m2/settings.xml

        .. code-block:: xml

            <?xml version="1.0" encoding="UTF-8"?>
            <settings xmlns="http://maven.apache.org/SETTINGS/1.1.0"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">

                <servers>
                    <server>
                        <id>nexus-snapshots</id>
                        <username>admin</username>
                        <password>admin123</password>
                    </server>
                    <server>
                        <id>nexus-releases</id>
                        <username>admin</username>
                        <password>admin123</password>
                    </server>
                </servers>

                <mirrors>
                    <mirror>
                    <id>central</id>
                    <name>central</name>
                    <url>http://your-host:8081/repository/maven-group/</url>
                    <mirrorOf>*</mirrorOf>
                    </mirror>
                </mirrors>

            </settings>

        .. image:: images/settings_maven.png


    * Edit pom.xml file and add the repository

        .. code-block:: xml

            <repositories>
                <repository>
                <id>maven-group</id>
                <url>http://your-host:8081/repository/maven-group/</url>
                </repository>
            </repositories>

        .. image:: images/pom-java.png