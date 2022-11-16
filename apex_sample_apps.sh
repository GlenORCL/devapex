#!/bin/bash

. ./xe.env

SAMPLES_FILE=apex_22_2_samples.zip

if [ -f "$SAMPLES_FILE" ]; then
    echo "$SAMPLES_FILE exists."
else
    curl -o $SAMPLES_FILE https://codeload.github.com/oracle/apex/zip/refs/heads/22.2
fi

unzip -q $SAMPLES_FILE -d extras/apex_22_2_samples
cp install_apex_samples.sh extras/.

docker exec ${DB_CONTAINER} bash -c "/opt/oracle/extras/install_apex_samples.sh $1 $2 $3 $4"
