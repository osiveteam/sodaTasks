Installation
=============

Here is a step by step guide on how to install Pi-Hole. It will get you to a point of having a local running instance

Requirements
------------

    * Hardware Requirements

        * Raspberry pi / Tinker board

    * Download the ISO from this `website <https://dlcdnets.asus.com/pub/ASUS/mb/Embedded_IPC/TinkerBoard_S/Tinker_Board-Debian-Stretch-V2.1.11-20200310.zip>`_ 

    * SD Card ``(16GB minimun)``

Quick start
-------------

    * Make a bootable sd card for Raspberry pi / Tinker board

        .. note:: Recommending to use ``Balena Etcher`` for flashing `link <https://www.balena.io/etcher/>`_ 

    * Boot up the system. Open terminal &  execute below command to get started

    .. code:: bash

        $ sudo su -

        $ curl -sSL https://install.pi-hole.net | bash
 
    * Follow the wizard to install Pi-Hole:-

        * Pi-Hole automated installer & follow the steps

            .. image:: images/pihole1.png

            .. image:: images/pihole2.png

        * Pi-Hole server need a static IP address

            .. image:: images/pihole3.png

            .. image:: images/pihole4.png

        * Select the preferred Upstream DNS Provider

            .. image:: images/pihole5.png

        * To allow 3rd party lists to block ads

            .. image:: images/pihole6.png

        * Select ip Address type as IPv4 and ipV6

            .. image:: images/pihole7.png

        * Selecting ``NO`` as we need to set static IP address.

            .. image:: images/pihole8.png

            .. image:: images/pihole10.png

        * Enter your desired Ipv4 Default gatway

            .. image:: images/pihole9.png

        * Add Web Admin interface

            .. image:: images/pihole11.png

        * Install WebServer as this is a fresh install 

            .. image:: images/pihole12.png

        * Log queries for more infomative usage in network

            .. image:: images/pihole13.png

        * Select 0 as, we will be loging every activity of the user

            .. image:: images/pihole14.png

        * Copy the password displayed in the terminal . It is required to access webpage login.

            .. image:: images/pihole16.png