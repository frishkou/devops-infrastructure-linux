#!/bin/bash

# Configuration
BACKUP_DIR="/opt/backups/nginx"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/nginx-backup-$DATE.tar.gz"

# Création du dossier si nécessaire
mkdir -p "$BACKUP_DIR"

# Sauvegarde des sites et configurations Nginx
tar -czf "$BACKUP_FILE" \
    /var/www/site1.local \
    /var/www/site2.local \
    /etc/nginx/sites-available \
    /etc/nginx/sites-enabled

# Vérification
if [ $? -eq 0 ]; then
    echo "Sauvegarde réussie : $BACKUP_FILE"
else
    echo "Erreur pendant la sauvegarde"
    exit 1
fi

# Suppression des sauvegardes de plus de 7 jours
find "$BACKUP_DIR" -type f -name "nginx-backup-*.tar.gz" -mtime +7 -delete
