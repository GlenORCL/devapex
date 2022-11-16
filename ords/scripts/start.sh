echo "******************************************************************************"
echo "Check if this is the first run." `date`
echo "******************************************************************************"
FIRST_RUN="false"
if [ ! -f ~/CONTAINER_ALREADY_STARTED_FLAG ]; then
  echo "First run."
  FIRST_RUN="true"
  touch ~/CONTAINER_ALREADY_STARTED_FLAG
else
  echo "Not first run."
fi

echo "******************************************************************************"
echo "Handle shutdowns." `date`
echo "docker stop --time=30 {container}" `date`
echo "******************************************************************************"
#function gracefulshutdown {
#  ${ORDS_HOME}/bin/ords
#}

#trap gracefulshutdown SIGINT
#trap gracefulshutdown SIGTERM
#trap gracefulshutdown SIGKILL

if [ "${FIRST_RUN}" == "true" ]; then
  echo "******************************************************************************"
  echo "Configure ORDS. Safe to run on DB with existing config." `date`
  echo "******************************************************************************"
  cd ${ORDS_HOME}

  export ORDS_CONFIG=${ORDS_CONF}
  ${ORDS_HOME}/bin/ords --config ${ORDS_CONF} install \
       --log-folder ${ORDS_CONF}/logs \
       --admin-user SYS \
       --db-hostname ${DB_HOSTNAME} \
       --db-port ${DB_PORT} \
       --db-servicename ${DB_SERVICE} \
       --feature-db-api true \
       --feature-rest-enabled-sql true \
       --feature-sdw true \
       --gateway-mode proxied \
       --gateway-user APEX_PUBLIC_USER \
       --proxy-user \
       --password-stdin <<EOF
${SYS_PASSWORD}
${APEX_LISTENER_PASSWORD}
EOF

#  cp ords.war ${CATALINA_BASE}/webapps/
fi

echo "******************************************************************************"
echo "Start ORDS with SERVE." `date`
echo "******************************************************************************"
${ORDS_HOME}/bin/ords --config ${ORDS_CONF} serve 
