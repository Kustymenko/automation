Bash script to perform zabbix MySQL database backup.

Current script could be used to backup typical MySQL database but not only zabbix db.

Notes:

 - use  'chmod +x'  to make script executable;
 - use 'crontab -e' to schedule backup operation
 - set variables: 
   'LOG_PATH='       - directory to save operation log;
   'DB_BACKUP_PATH=' - directory to store database backup archives;
   'MYSQL_HOST='     - MySQL database host ip. Default is 'localhost';
   'MYSQL_PORT='     - MySQL database port. Default is '3306';
   'MYSQL_USER='     - MySQL database user name;
   'MYSQL_PASS='     - MySQL database use password;
   'DB_NAME='        - Zabbix database name.
