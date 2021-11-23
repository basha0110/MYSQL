#!/bin/sh 

# store start date to a variable
start_import=`date`

echo "Restore started: OK"
dumpfile="/root/table4_5.sql" # path of the backup file 

#var1="set names utf8; " It is needed whenever you want to send data to the server having characters that cannot be represented in pure ASCII, like 'ñ' or 'ö'
var1="$var1 set global net_buffer_length=1000000;"
var1="$var1 set global max_allowed_packet=1000000000; "
var1="$var1 SET foreign_key_checks = 0; "
var1="$var1 SET UNIQUE_CHECKS = 0; "
var1="$var1 SET AUTOCOMMIT = 0; "
#var1="$var1 USE jetdb;  If the dump file does not have "create  database" statement ,then select which one you need 
var1="$var1 source $dumpfile; "
var1="$var1 SET foreign_key_checks = 1; "
var1="$var1 SET UNIQUE_CHECKS = 1; "
var1="$var1 SET AUTOCOMMIT = 1; "
var1="$var1 COMMIT ; "

echo "Restore started: OK"

time mysql  -u user -ppassword -e "$var1"

# store end date to a variable
end_import=`date`

echo "Start restore:$start_import"
echo "End restore:$end_import" 
