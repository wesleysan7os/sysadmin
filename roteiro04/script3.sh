#!/bin/bash

USER=$1

HOME="/home/$USER"
DATE=$(date +%Y%m%d)
BACKUP_DIR="$HOME/Backup"
FILE="$BACKUP_DIR/backup_$DATE.tgz"

mkdir -p $BACKUP_DIR
echo "Creating a backup for user $USER"
tar -cvzf $FILE $HOME

echo "File saved in $FILE"