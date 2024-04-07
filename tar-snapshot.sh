#!/bin/bash

# Variables permettant de changer la source et la destination de la sauvegarde
SOURCE="/"
DESTINATION="/var/www/backups/snapshot/"

# Si le répertoire temporaire des snapshots n'existe pas, le créer
if [ ! -d "$DESTINATION" ]; then
    mkdir -p $DESTINATION
fi

# Créer une archive compressée de la source en excluant les répertoires spécifiés
backup_file="${DESTINATION}snapshot_$(date +'%Y%m%d_%H%M%S').tar.gz"
tar --exclude="/dev" --exclude="/proc" --exclude="/sys" --exclude="/tmp" --exclude="/run" --exclude="/mnt" --exclude="/media" --exclude="/lost+found" -czvf $backup_file $SOURCE 2>/dev/null

# Vérifier si la compression a réussi
if [ $? -eq 0 ]; then
    echo "Sauvegarde compressée avec succès. Archive créée : ${backup_file}"
else
    echo "Erreur lors de la compression de la sauvegarde."
fi
