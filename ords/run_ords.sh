#!/bin/bash

. ../xe.env

docker run -dit --name ${ORDS_CONTAINER} \
             -p 8080:8080 -p 8443:8443 \
             --network=${NETWORK_NAME} \
             -e "DB_HOSTNAME=${DB_HOSTNAME}" \
             -e "DB_PORT=${DB_PORT}" \
             -e "DB_SERVICE=${DB_SERVICE}" \
             -e "APEX_PUBLIC_USER_PASSWORD=${APEX_PUBLIC_USER_PASSWORD}" \
             -e "APEX_TABLESPACE=${TABLESPACE_APEX}" \
             -e "TEMP_TABLESPACE=${TABLESPACE_FILES}" \
             -e "APEX_LISTENER_PASSWORD=${APEX_LISTENER_PASSWORD}" \
             -e "APEX_REST_PASSWORD=${APEX_REST_PASSWORD}" \
             -e "PUBLIC_PASSWORD=${PUBLIC_PASSWORD}" \
             -e "SYS_PASSWORD=${SYS_PASSWORD}" \
             ${ORDS_CONTAINER}
             
