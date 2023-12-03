#!/bin/bash

# Simple backuping script. Script makes dump from database and copy data files from containers.
# Script deletes backup files older than 2 days

# variables taken from playbook vars
MYSQL_CONTAINER_NAME="{{ MYSQL_CONTAINER_NAME }}"
WORDPRESS_CONTAINER_NAME="{{ WP_CONTAINER_NAME }}"
MYSQL_DATABASE="{{ MYSQL_DATABASE }}"
MYSQL_ROOT_PASSWORD="{{ MYSQL_ROOT_PASSWORD }}"
WORDPRESS_TARGET="{{ WP_VOLUME_TARGET }}"
BACKUP_DIR="{{ BACKUP_DIR }}"

# other variables
SUFFIX=`date +%Y-%m-%d_%H`

## Script execute
# backup database
/usr/bin/docker exec $MYSQL_CONTAINER_NAME /usr/bin/mysqldump -u root --password=$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE | /usr/bin/gzip > $BACKUP_DIR/wordpress_db_$SUFFIX.sql.gz

# backup wordpress data
/usr/bin/docker run --rm --volumes-from $WORDPRESS_CONTAINER_NAME -v $BACKUP_DIR:/backup alpine tar czf /backup/wordpress_data_$SUFFIX.tar.gz $WORDPRESS_TARGET

# delete backups older than 2 days
/usr/bin/find $BACKUP_DIR -type f -name '*.gz' -mtime +2 -delete
