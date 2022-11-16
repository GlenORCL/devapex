#!/bin/bash

. ./xe.env

docker run -dit --name ${DB_CONTAINER} \
           -p ${DB_PORT}:${DB_PORT}  \
           --network=${NETWORK_NAME} \
           -e "ORACLE_PASSWORD=${SYS_PASSWORD}" \
           -v $(pwd)/extras:/opt/oracle/extras \
           -v $(pwd)/xeoradata:/opt/oracle/oradata \
           gvenzl/oracle-xe 

