#!/usr/bin/env bash
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
	echo "Event triggered: $ACTION"
	export
	echo "============================"

	MOUNT_POINT=`mktemp -d`

	echo "Mount point is: $MOUNT_POINT"
	mount -o ro $DEVNAME $MOUNT_POINT
	ls -la $MOUNT_POINT

	rsync -av --delete --backup --backup-dir "$BACKUP_DIR" "$MOUNT_POINT/Photos.photoslibrary" "$BACKUP_LOCATION"

	umount $MOUNT_POINT
	rmdir -f $MOUNT_POINT
} > $LOG &
