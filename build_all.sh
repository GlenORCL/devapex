#!/bin/bash

. ./xe.env

if [ -f "${APEX_ZIP}" ]; then
    echo "${APEX_ZIP} exists."
else
    curl -o ${APEX_ZIP} ${APEX_ZIP_URL}
fi

if [ -f "${SAMPLES_ZIP}" ]; then
    echo "${SAMPLES_ZIP} exists."
else
    curl -o ${SAMPLES_ZIP} ${SAMPLES_ZIP_URL}
fi

if [ -f "${ORDS_ZIP}" ]; then
    echo "${ORDS_ZIP} exists."
else
    curl -o ${ORDS_ZIP} ${ORDS_ZIP_URL}
fi

cd ords
./build_ords.sh
cd ..

cd web
./build_web.sh
cd ..

