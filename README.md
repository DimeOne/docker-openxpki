# OpenXPKI Docker Template

This repository contains a template for running OpenXPKI with the official debian packages. 
We also provide a docker-compose.yml for easy startup and management. 
This container is supposed to run behind an nginx reverse-proxy to provide https, 
therefore we provide a tested nginx configuration example.

# Quickstart

A quickstart can be used for testing as it contains everything that is needed.
This docker-compose contains default credentials for the database, that can be changed.
When starting the containers with docker-compose up, a database container is created and linked to openxpki as mysql.
The OpenXPKI sampleconfig.sh will be called after the database has been created and initialized.

    git clone https://github.com/DimeOne/docker-openxpki.git
    cd docker-openxpki
    docker-compose up -d && docker-compose logs -f

# Userdata

All userdata is either stored in the MySql database or as files in the openxpki configuration. When using the docker-compose.yml, 
all folders, including configuration, logs and MySql database files are stored as folders in the same directory as the docker-compose.yml.

  - mysql_data
  - config
  - logs

# Configuration

There are three parts of configuration that have to be considered. But will be created using defaults if not changed.

## Database configuration



## PKI configuration

## Nginx configuration

# Running & Commands

This container is expected to be linked to a MySql server or have the connection details passed through environment variables.

## create_db

## init_db

## create_config

## wait_for_db

## wait_for_db_root


# Environment Variables:

  - APP_DB_NAME
  - APP_DB_HOST
  - APP_DB_PORT
  - APP_DB_USER
  - APP_DB_PASS
  - APP_DB_ROOT_PASS


# ToDo:

  - So much documentation.


# Known Issues:
  - Unable to run openxpki start --foreground properly
    - See: https://github.com/openxpki/openxpki/issues/538
    - might cause problems with process reaping and leave zombies
    - prevents running the processes through an external supervisor like s6 or supervisord

# Sources:
  - https://github.com/openxpki/openxpki
  - https://github.com/jetpulp/docker-openxpki
  
 