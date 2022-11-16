echo "******************************************************************************"
echo "ORDS Software Installation." `date`
echo "******************************************************************************"
echo "Create docker_fg group and ords user."
#groupadd -g 1042 docker_fg
#useradd ords -u 501 -G docker_fg

addgroup -g 1042 -S docker_fg
adduser ords -S -u 501 -G docker_fg

echo "ORDS setup."
mkdir -p ${ORDS_HOME}
cd ${ORDS_HOME}
unzip -oq ${SOFTWARE_DIR}/ords-latest.zip
rm -f ${SOFTWARE_DIR}/ords-latest.zip
mkdir -p ${ORDS_CONF}/logs

#echo "SQLcl setup."
#cd /u01
#unzip -oq ${SOFTWARE_DIR}/${SQLCL_SOFTWARE}
#rm -f ${SOFTWARE_DIR}/${SQLCL_SOFTWARE}

echo "Set file permissions."
chmod u+x ${SCRIPTS_DIR}/*.sh
chown -R ords:docker_fg /u01
