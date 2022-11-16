#!/bin/bash

. ./xe.env

unzip -q ${SAMPLES_ZIP} -d extras/apex_samples
cp install_apex_samples.sh extras/.

docker exec ${DB_CONTAINER} bash -c "/opt/oracle/extras/install_apex_samples.sh $1 $2 $3 $4"
