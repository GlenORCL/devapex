#!/bin/bash

. ./xe.env

docker stop ${ORDS_CONTAINER}
docker stop ${DB_CONTAINER}
docker stop ${WEB_CONTAINER}
