#!/usr/bin/env bash
set -e
BACKUP_LOCATION="/mnt"
DATE=`date "+%Y-%m-%d"`
BACKUP_DIR="$BACKUP_LOCATION/backups/$DATE"
LOG="$BACKUP_DIR/log.txt"

if [ -d "$BACKUP_DIR" ]; then
	>&2 echo "Backup directory $BACKUP_DIR already exists."
	exit 1
fi

mkdir -p $BACKUP_DIR
{
	MOUNT_POINT=/run/media/bazhenov/Photos

	rsync -av --delete --backup --backup-dir "$BACKUP_DIR" "$MOUNT_POINT/Photos.photoslibrary" "$BACKUP_LOCATION"
} | tee $LOG
