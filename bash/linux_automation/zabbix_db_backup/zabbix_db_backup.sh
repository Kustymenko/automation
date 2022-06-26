#!/bin/bash -e
#
#
#--------------------------#
# Zabbix db backup script
# version 1.0
#--------------------------#

# Set logging
LOG_PATH='/var/log/mysqldump.log'
exec > >(tee -a ${LOG_PATH})
exec 2> >(tee -a ${LOG_PATH} >&2)

# Set variables

export PATH=/bin:/usr/bin/bin:/usr/local/bin
TODAY=`date +"%Y%m%d"`
TIMENOW=`date +"%H%M%S"`
#
SCRIPTSTART='Script started on:                   '
SCRIPTFINISHOK='Script completed successfully on: '
SCRIPTFINISHNOK='Script failed on:                '
#
DB_BACKUP_PATH='/backup/dbbackup/zabbix'
#
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='admin'
MYSQL_PASS='admin'
DB_NAME='db4backup'

# Script body

echo "#------------------------------------------------------------------------------------#"
echo "# " ${SCRIPTSTART} ${TODAY} ${TIMENOW}                                                 
echo "#------------------------------------------------------------------------------------#"

mkdir -p ${DB_BACKUP_PATH}/${TODAY}


mysqldump -h ${MYSQL_HOST} \
	  -P ${MYSQL_PORT} \
	  -u ${MYSQL_USER} \
	  -p${MYSQL_PASS} \
	     ${DB_NAME}    \
	  --no-tablespaces | gzip > ${DB_BACKUP_PATH}/${TODAY}/${DB_NAME}-${TODAY}-${TIMENOW}.sql.gz

if [ $? -eq 0 ]; then

echo "                                                                                      "
echo "Backup saved in: " ${DB_BACKUP_PATH}/${TODAY}/${DB_NAME}-${TODAY}-${TIMENOW}.sql.gz 
echo "#------------------------------------------------------------------------------------#"
echo "# " ${SCRIPTFINISHOK} ${TODAY} ${TIMENOW}                                              
echo "#------------------------------------------------------------------------------------#"
echo "											    "

else

echo "                                                                                      "
echo "Backup saved in: " ${DB_BACKUP_PATH}/${TODAY}/${DB_NAME}-${TODAY}-${TIMENOW}.sql.gz 
echo "#------------------------------------------------------------------------------------#"
echo "# " ${SCRIPTFINISHNOK} ${TODAY} ${TIMENOW}                                            
echo "#------------------------------------------------------------------------------------#"
echo "											   #"
echo "exit 1"
exit 1                                                                                       

fi
