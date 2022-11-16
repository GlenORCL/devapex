# ------------------------------------------------------------------------------

FROM eclipse-temurin:11-jre-alpine

# File Author / Maintainer
# Use LABEL rather than deprecated MAINTAINER
LABEL maintainer="glenmorris@me.com"

# ------------------------------------------------------------------------------
# Define fixed (build time) environment variables.
ENV SOFTWARE_DIR="/u01/software"                                               \
    SCRIPTS_DIR="/u01/scripts"                                                 \
    KEYSTORE_DIR="/u01/keystore"                                               \
    ORDS_HOME="/u01/ords"                                                      \
    ORDS_CONF="/u01/config/ords"                                               

# ------------------------------------------------------------------------------
# Define config (runtime) environment variables.
ENV _JAVA_OPTS="-Dconfig.url=${ORDS_CONF} -Xms1024M -Xmx1024M" 

RUN apk add --no-cache bash

# ------------------------------------------------------------------------------
# Get all the files for the build.
COPY software/* ${SOFTWARE_DIR}/
COPY scripts/* ${SCRIPTS_DIR}/

# ------------------------------------------------------------------------------
# Unpack all the software and remove the media.
# No config done in the build phase.
RUN sh ${SCRIPTS_DIR}/ords_software_installation.sh

# Perform the following actions as the ords user
USER ords

#VOLUME [${CATALINA_BASE}]
EXPOSE 8080 8443
HEALTHCHECK --interval=1m --start-period=1m \
   CMD ${SCRIPTS_DIR}/healthcheck.sh >/dev/null || exit 1

# ------------------------------------------------------------------------------
# The start script performs all config based on runtime environment variables,
# and starts ords.
CMD exec ${SCRIPTS_DIR}/start.sh

# End
