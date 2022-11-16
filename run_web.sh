#!/bin/bash

. ./xe.env

docker run -dit --name ora-web \
             -p 80:80 -p 443:443 \
             --network=${NETWORK_NAME} \
             ora-web
             