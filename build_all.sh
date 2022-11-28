#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd ${SCRIPT_DIR}

source devapex.env

source bash_lib/fn_general

if [ -f "${APEX_ZIP}" ]
then
    logit "${APEX_ZIP} exists."
else
    logit "Using CURL to grab ${APEX_ZIP} from ${APEX_ZIP_URL}"
    curl -o ${APEX_ZIP} ${APEX_ZIP_URL}
fi

if [ -f "${SAMPLES_ZIP}" ]
then
    logit "${SAMPLES_ZIP} exists."
else
    logit "Using CURL to grab ${SAMPLES_ZIP} from ${SAMPLES_ZIP_URL}"
    curl -o ${SAMPLES_ZIP} ${SAMPLES_ZIP_URL}
fi

if [ -f "${ORDS_ZIP}" ] 
then
    logit "${ORDS_ZIP} exists."
else
    logit "Using CURL to grab ${ORDS_ZIP} from ${ORDS_ZIP_URL}"
    curl -o ${ORDS_ZIP} ${ORDS_ZIP_URL}
fi

logit "Using docker to build ${ORDS_IMAGE}"
cd ords
docker build -t ${ORDS_IMAGE} .
cd ..

logit "Using docker to build ${WEB_IMAGE}"
cd web
docker build -t ${WEB_IMAGE} .
cd ..

logit "Finished"
