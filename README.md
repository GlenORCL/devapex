# devapex
My DEV setup for APEX and Oracle DB and ORDS and NGINX Web

Steps to setup everything and get working

1. Download
2. cp xe.env.template xe.env
3. edit xe.env - put in a sys password, and if you want to edit other values appropriately
4. run build_all.sh
5. run setup_env_new.sh

You then have a new docker network (xedb_network) with these machines:

A) ora21xe_con - oracle xe 21 database
- listens on 1521
- pdb = xepdb1
- apex installed inside the pdb
- inside setup_env_new.sh
- this also creates a new workspace (gjm_ws), new db user (gjm, pw=gjm) and installs all apex samples into that schema/workspace
- edit this file if you want to change these defaults, or create additional workspaces and schemas

B) ora-ords : an ords server running on eclipse-temurin:11-jre-alpine using jetty
- listens on 8080
- configured within the db pdb and ready to use APEX

C) ora-web : an nginx:alpine webserver
- listens on 80
- serves up apex images on /images/
- redirects /ords requests to the ora-ords machine (on port 8080)
