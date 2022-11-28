#!/bin/bash

set -Eeuo pipefail # fail script if any commands fail (-e), any variables are unset when used (-u), any within pipeline comamnd fails (-o pipefail) and also call error trap as part of fail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd ${SCRIPT_DIR}

source bash_lib/fn_general
source bash_lib/fn_docker_cmds
source bash_lib/fn_install_cmds

source devapex.env

# CLEANUP ANY EXISTING OLD ENVIRONMENT

stop_docker_containers
remove_docker_containers

install_setup_extras

# NOW START DOCKER SETUP
docker_create_network

docker_initiate_db
docker_await_db_ready

# perform standard db init - set db directories, open acls etc.
install_exec_sql_in_pdb @scripts/db_init.sql

install_apex_into_db

docker_initiate_ords
docker_initiate_web

# CUSTOMISATION
source custom_devapex

logit "Finished"
