# LORIS@UVA Neuroimaging Platform

![UVA Health Logo](./htdocs/images/UVA.Health_RGB_White.png)
![LORIS Logo](./htdocs/images/LORIS_logo.png)

[![Build Status](https://travis-ci.org/aces/Loris.svg?branch=main)](https://travis-ci.org/aces/Loris)
[![Minimum PHP Version](https://img.shields.io/travis/php-v/aces/loris/main?color=787CB5)](https://php.net/)
[![Documentation Status](https://readthedocs.org/projects/acesloris/badge/?version=latest)](https://acesloris.readthedocs.io/en/latest/?badge=latest)

LORIS (Longitudinal Online Research and Imaging System) is a self-hosted web application that provides data- and project-management for neuroimaging research. LORIS makes it easy to manage large datasets including behavioural, clinical, neuroimaging and genetic data acquired over time or at different sites.

This Readme covers installation of **LORIS@UVA** using **Docker**.

Please consult the [Loris documentation](https://github.com/aces/Loris) for more information. Other installation instructions and more LORIS documentation for developers can also be found on the [LORIS ReadTheDocs website](https://acesloris.readthedocs.io/en/latest/).

## Installation

### System Requirements

* [Docker](https://docs.docker.com/engine/)
* [Docker Compose](https://docs.docker.com/compose/install/)

Installing some dependencies may require `sudo` privileges. Other dependencies are defined through Dockerfiles. Consult the [Loris repository](https://github.com/aces/Loris) for more information on these requirements.

### Install Steps

1. Create environment file in the project repo to configure MySQL and CouchDB containers

    .env example

    ```env
    MYSQL_DATABASE_NAME=$loris_db_name
    MYSQL_ROOT_PASSWORD=$db_root_password

    COUCHDB_USER=$dqt_user
    COUCHDB_PASSWORD=$couch_root_password
    ```

    *$loris_db_name ⇾ "loris" or one-word project name*

    > :warning: **Warning:** Keep these passwords secret! Do not check the *.env* file into your repo!

2. Run `docker compose build` in the root Loris folder to build your Docker images     

3. Run `docker compose  --env-file .env up -d` in the root folder of the repository to start the service

    > :memo: **Note:** If you make any changes to the *Dockerfile* or *docker-compose.yaml*, you will need to rebuild the images using `docker compose build` before running `docker compose up`

4. Open your browser and go to: `<loris-url>/installdb.php`. This web page will prompt you for your mysql connection information. Follow the instructions to finalize LORIS installation, then restart Apache in the *loris-web-1* Docker container (name could vary) using `sudo service apache2 reload`.

    > :memo: **Note:** `<loris-url>` is most likely `localhost`
    
    > :memo: **Note:** Use `docker network inspect loris_default` to find the IP Address for the MySQL database and use this for the `Server Hostname`
    
    > :memo: **Note:** Check the box for `Use existing database` and provide the database name from your *mysql.env* file

5. Follow the [Setup Guide in the LORIS Wiki](https://github.com/aces/Loris/wiki/Setup) to complete your post-installation setup and configuration, and for more documentation.

## Community

### Get in touch

For questions and troubleshooting guidance beyond what is covered in our documentation, please subscribe to the [LORIS Developers mailing list](http://www.bic.mni.mcgill.ca/mailman/listinfo/loris-dev) and email us there.

### Support and GitHub Issues

For troubleshooting specific installation issues or errors, please see the [Installation troubleshooting guide](docs/wiki/00_SERVER_INSTALL_AND_CONFIGURATION/01_LORIS_Install/Troubleshooting.md), and then contact us via the [LORIS Developers mailing list](http://www.bic.mni.mcgill.ca/mailman/listinfo/loris-dev).
For bug reporting and new feature requests, please search and report via our GitHub Issues.

Please include details such as the version of LORIS you're using as well as information
such as the OS you're using, your PHP and Apache versions, etc.

## Contributing

We are very happy to get code contributions and features from the global LORIS community.

If you would like to contribute to LORIS development, please consult our [Contributing Guide](./CONTRIBUTING.md).

## Powered by MCIN

LORIS is made by staff developers at the [McGill Centre for Integrative Neuroscience](http://www.mcin.ca), led by Alan Evans and Samir Das at The Neuro (Montreal Neurological Institute-Hospital).

Visit [the LORIS website](https://loris.ca) for the history of LORIS and our **Technical Papers**.

The original (pre-GitHub) LORIS development team from 1999-2010 included: Dario Vins, Alex Zijdenbos, Jonathan Harlap, Matt Charlet, Andrew Corderey, Sebastian Muehlboeck, James McKinney, and Samir Das.
