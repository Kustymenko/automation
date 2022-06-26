Bash script to remove old files.

Notes:

 - use  'chmod +x'  to make script executable;
 - current script actually uses 'mmin' keyword instead of 'mtime' for a more accurate time range search;
 - set variables: 
   'LOG_PATH='   - directory to save operation log;
   'FILE_PATH='  - directory to search for old files.

