#!/bin/bash -e
#
#
#------------------------------#
# Remove old files 
# version 2.0
#------------------------------#


# Set logging
LOG_PATH='/var/log/remove_old_files.log'
exec > >(tee -a ${LOG_PATH})
exec 2> >(tee -a ${LOG_PATH} >&2)
#
# Set variables
#
export PATH=/bin:/usr/bin/bin:/usr/local/bin
#
TIMENOW=`date +"%Y-%m-%d %H:%M:%S"`
FILE_PATH='/backup/dbbackup/db4backup/'
#
SCRIPTSTART='Script started on:                                      '
SCRIPTFINISH='Script finished on:                                    '
STARTSEARCHNOW='Start searching for files by specified criteria.     '
FINISHSEARCHNOW='Finished searching for files by specified criteria. '
ERROR='Error.Something went wrong. Exiting now.                      '

#
# Script body
#

echo "#-------------------------------------------------"
echo "#" ${SCRIPTSTART} ${TIMENOW} 
echo "#-------------------------------------------------"
echo

#
# List files before any sensitive operation
#

echo "Filepath is: " ${FILE_PATH}
echo


echo "Please enter the filename to search (use * to set wildcard): "
read FILENAME
echo "${FILENAME}" >> ${LOG_PATH}

echo "Please enter the number of days since last time files were modified: "
read MDAYS
echo "${MDAYS}" >> ${LOG_PATH} 


if [ "${MDAYS:=0}" = 0 ]; then
    echo ${ERROR}
    echo ${MDAYS}
    echo "exit 1"
    exit 1
else
    echo ${STARTSEARCHNOW}
    echo "                                             "
fi

RESULT=`find ${FILE_PATH} -type f -name ${FILENAME} -type f  -mmin +$((60*24*${MDAYS}))`


if [ "${RESULT:=0}" = 0 ]; then
    echo "Search returned 0 results. Please modify the search input"
    echo ${FINISHSEARCHNOW}
    echo "                                             "
    echo "#--------------------------------------------------"
    echo "#" ${SCRIPTFINISH} ${TIMENOW}
    echo "#--------------------------------------------------"
    exit 0
else
    echo "Search returned the following results:       "
    echo "${RESULT}"
    echo "                                                  "
fi     


# Confirm sensitive operation 


echo "Delete old files ? [yes/no] "
read CONFIRM
echo ${CONFIRM} >> ${LOG_PATH}

case "${CONFIRM}" in
    [yY]|[yY][eE][sS])
       echo "Delete operation is in progress"
       DELFILES=`rm -f ${RESULT}` 
       echo "Delete operation finished"
       echo "Bye"
       echo "#-----------------------------------------------"
       echo "#" ${SCRIPTFINISH} ${TIMENOW}
       echo "#-----------------------------------------------"
       ;;

   [nN]|[nN][oO])
      echo "Operation canceled by user"
      echo "Bye"
      echo "#------------------------------------------------"
      echo "#" ${SCRIPTFINISH} ${TIMENOW}
      echo "#------------------------------------------------"
      ;;

   *)
      echo ${ERROR}
      echo ${CONFIRM}
      echo "#------------------------------------------------"
      echo "#" ${SCRIPTFINISH} ${TIMENOW}
      echo "#------------------------------------------------"
      exit 1
      ;;
esac

exit 0
