#!/bin/bash

source devapex.env

docker start ${DB_CONTAINER}
docker start ${ORDS_CONTAINER}
docker start ${WEB_CONTAINER}
