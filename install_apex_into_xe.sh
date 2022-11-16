#!/bin/bash

. ./xe.env

APEX_FILE=apex_22_2_en.zip

if [ -f "$APEX_FILE" ]; then
    echo "$APEX_FILE exists."
else
    curl -o $APEX_FILE https://download.oracle.com/otn_software/apex/apex_22.2_en.zip
fi

# TODO - exclude images - not needed in DB server
unzip -q $APEX_FILE -d extras

docker exec ${DB_CONTAINER} bash -c "
cd /opt/oracle/extras/apex; sqlplus /nolog <<SQLEOF
conn sys/${SYS_PASSWORD} as sysdba
alter session set container=${DB_SERVICE};
@apxsilentins.sql ${TABLESPACE_APEX} ${TABLESPACE_FILES} ${TABLESPACE_TEMP} ${IMAGES} ${APEX_PUBLIC_USER_PASSWORD} ${APEX_LISTENER_PASSWORD} ${APEX_REST_PASSWORD} ${APEX_ADMIN_PASSWORD}
@utilities/reset_image_prefix_core /images/ XX
SQLEOF
"
