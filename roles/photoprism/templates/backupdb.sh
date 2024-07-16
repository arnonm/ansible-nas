#!/bin/bash
cd `pwd`
# Set Date for today
BACKUP_PATH="/backup/"
datevar=$(date +'%Y-%m-%d')

FILENAME="photoprism-db-${datevar}.sql"
docker compose exec -T photoprism photoprism backup -i -f /backup/${FILENAME}
tar -czvf ./backup/${FILENAME}.tar.gz ./backup/$FILENAME
rm ./backup/$FILENAME
find ./backup -type f -mtime +30 -delete