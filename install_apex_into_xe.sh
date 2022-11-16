#!/bin/bash

. ./xe.env

unzip -q ${APEX_ZIP} -x apex/images/* -d extras

docker exec ${DB_CONTAINER} bash -c "
cd /opt/oracle/extras/apex; sqlplus /nolog <<SQLEOF
conn sys/${SYS_PASSWORD} as sysdba
alter session set container=${DB_SERVICE};
@apxsilentins.sql ${TABLESPACE_APEX} ${TABLESPACE_FILES} ${TABLESPACE_TEMP} ${IMAGES} ${APEX_PUBLIC_USER_PASSWORD} ${APEX_LISTENER_PASSWORD} ${APEX_REST_PASSWORD} ${APEX_ADMIN_PASSWORD}
SQLEOF
"
