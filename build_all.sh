#!/bin/bash

set -Eeuo pipefail # fail script if any commands fail (-e), any variables are unset when used (-u), any within pipeline comamnd fails (-o pipefail) and also call error trap as part of fail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd ${SCRIPT_DIR}

source devapex.env

source bash_lib/fn_general

function get_software() {
# 1 = file to grab, 2 = URL to get it from
    if [ -f "${1}" ]
    then
        logit "${1} exists."
    else
        logit "Using CURL to grab ${1} from ${2}"
        curl -o ${1} ${2}
    fi
}

get_software "${APEX_ZIP}" "${APEX_ZIP_URL}"
get_software "${SAMPLES_ZIP}" "${SAMPLES_ZIP_URL}"
get_software "${ORDS_ZIP}" "${ORDS_ZIP_URL}"

logit "Using docker to build ${ORDS_IMAGE}"
cd ords
docker build -t ${ORDS_IMAGE} .
cd ..

logit "Using docker to build ${WEB_IMAGE}"
# push apex into web software (images need to be put installed into container)
cp ${APEX_ZIP} web/software/.
cd web
# remove the existing default.conf and recreate using the template (subsituting ORDS:PORT for the ords container)
#rm -f default.conf
#sed "s/proxy_pass ORDS:PORT;/proxy_pass http:\/\/${ORDS_CONTAINER}:8080;/g" default.conf.template | tee default.conf

docker build -t ${WEB_IMAGE} .
cd ..

logit "Finished"
