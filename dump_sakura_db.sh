#!/bin/bash

DIR=$(cd $(dirname $0);pwd)

# set ssh info
SSH_HOST=hogehoge.sakura.ne.jp
SSH_USER=hogehoge
SSH_PASS=passwd

# set mysql info
DB_HOST=mysqlxxx.db.sakura.ne.jp
DB_USER=hogehoge
DB_PASS=dbpasswd
DB_NAME=dbname

# set file info
BACKUP_FILE_NAME=/home/${SSH_USER}/product_db_`date "+%Y%m%d%H%M"`.sql
LOCAL_FOLDER=${DIR}/backiup/
LOGFILE=${DIR}/log.log

# check local folder
if [ ! -e $LOCAL_FOLDER ]; then
	mkdir -p ${LOCAL_FOLDER}
	if [ $? -ne 0] ; then
		echo "ERROR: Folder Is Not Exsist - ${LOCAL_FOLDER}"
		exit 1
	fi
fi

# backup mysql
expect -c "
	log_file ${LOGFILE}
	set timeout 3
	spawn ssh ${SSH_USER}@${SSH_HOST}
	expect \"password:\"
	send \"$SSH_PASS\n\"
	expect \"%\"
	send \"mysqldump -h$DB_HOST -u$DB_USER -p$DB_PASS --no-create-db $DB_NAME > $BACKUP_FILE_NAME\n\"
	expect eof
"
# get backup file 
expect -c "
	log_file ${LOGFILE}
	set timeout 3
	spawn rsync -avlC -e ssh ${SSH_USER}@${SSH_HOST}:$BACKUP_FILE_NAME $LOCAL_FOLDER
	expect \"password:\"
	send \"$SSH_PASS\n\"
	expect \"total size\"
	expect eof
"
	#interact



