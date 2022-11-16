#!/bin/bash

. ./xe.env

./stop_env.sh

# remove old docker containers
docker rm ${DB_CONTAINER}
docker rm ${ORDS_CONTAINER}
docker rm ${WEB_CONTAINER}

docker network rm ${NETWORK_NAME}

#cleanup old directories
rm -Rf xeoradata
rm -Rf extras

# setup the extras directory
mkdir extras

docker network create ${NETWORK_NAME}

# Run up the XE Database container
./run_xe.sh

# wait for database to be ready
while [$(docker logs ${DB_CONTAINER}|grep "DATABASE IS READY TO USE"|wc -l) -eq 0 ]
do
  sleep 5
done

# Install APEX
./install_apex_into_xe.sh

# Install APEX base
# apex_base - 1=DB schema to create, 2=Workspace to create, 3=email address for apex users (schema and apex user pw defaults to lowercase user name)
cp apex_base.sql extras/apex_base.sql 
docker exec ${DB_CONTAINER} bash -c "
cd /opt/oracle/extras; sqlplus /nolog <<SQLEOF
conn sys/${SYS_PASSWORD} as sysdba
alter session set container=${DB_SERVICE};
alter system set db_create_file_dest=\"/opt/oracle/oradata/XE\";
@apex_base.sql gjm gjm_ws glenmorris@me.com
SQLEOF
"

# Install all APEX sample apps
# 1 - db schema, 2 - db password, 3 - db service, 4 - Workspace NAME
./apex_sample_apps.sh gjm gjm ${DB_SERVICE} gjm_ws

# all done, so start ORDS
./run_ords.sh

# then start the web server
./run_web.sh
