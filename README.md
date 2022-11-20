# devapex
My DEV setup for APEX and Oracle DB and ORDS and NGINX Web

Steps to setup everything and get working :
1. Download into a directory (devapex would be fine)
2. cp devapex.env.template devapex.env
3. edit devapex.env - put in a sys password, and if you want to edit other values appropriately
4. run build_all.sh (this downloads all required software and builds ora-ords and ora-web docker images)
5. run destroy_setup_new_devapex.sh (this sets up the db, configures everthing and starts it up)

You then have a new docker network (xedb_network) with these machines:

A) ora-db - oracle xe 21 database
- listens on 1521
- pdb = xepdb1
- apex installed inside the pdb
- this also creates a new workspace (play_ws), new db user (play, pw=play) and installs all apex samples into that schema/workspace
- edit custom_devapex.sh to modify or create additional workspaces and schemas

B) ora-ords : an ords server running on eclipse-temurin:11-jre-alpine using jetty
- listens on 8080
- configured within the db pdb and ready to use APEX

C) ora-web : an nginx:alpine webserver
- listens on 80
- serves up apex images on /images/
- redirects /ords requests to the ora-ords machine (on port 8080)


Later use :
1. stop_devapex.sh - stop all running servers
2. start_devapex.shœ - starts all servers
3. destroy_setup_new_devapex.sh - destroys all data and recreates the servers

Advanced use :
1. edit vm_sripts/db_init.sql
    - put in here the standard things you want to do when the db is created (executes before apex is installed and before custom_devapex is invokved)
2. edit custom_devapex
    - by default, this will create play schema and play_ws workspace (with play/play as apex user/pw) and install ALL apex samples into this
    - this file can be left as is, or 
    - put in here the db schema, apex workspace that you want to create and include the apex samples into that workspace if you want
    - this file is sourced as apart of destroy_setup_new_devapex.sh after everyting is built/setup
