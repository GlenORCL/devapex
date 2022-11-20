#!/bin/bash

source devapex.env
source fn_docker_cmds
source fn_install_cmds

# CLEANUP ANY EXISTING OLD ENVIRONMENT
echo "STOP old environment - if none there, docker will just complain that they don't exist"
docker stop ${ORDS_CONTAINER}
docker stop ${DB_CONTAINER}
docker stop ${WEB_CONTAINER}

# remove old docker containers
echo "REMOVE old environment - if none there, docker will just complain that they don't exist"
docker rm ${DB_CONTAINER}
docker rm ${ORDS_CONTAINER}
docker rm ${WEB_CONTAINER}
docker network rm ${NETWORK_NAME}
#cleanup old directories
echo "REMOVE old data base files and extras directory"
rm -Rf xeoradata
rm -Rf extras

# TODO
# - test docker running
# - test each image is available (esp ords and web)

# SETUP EXTRAS DIRECTORY
echo "Setup extras directory"
install_setup_extras

# NOW START DOCKER SETUP
echo "Starting docker setup"
docker network create ${NETWORK_NAME}
# Run up the XE Database container
echo "Setup/Start DB"
docker_initiate_db
# wait for database to be ready
docker_await_db_ready
# perform standard db init - set db directories, open acls etc.
install_exec_sql_in_pdb @scripts/db_init.sql

# Install APEX
echo "Installing APEX"
install_apex_into_xe
# all done, so inititate ORDS machine
echo "Setup/Start ORDS"
docker_initiate_ords
# then initiate web machine
echo "Setup/Start WEB"
docker_initiate_web

# CUSTOMISATION
echo "Customisations"
source custom_devapex

