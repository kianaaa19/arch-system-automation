#!/bin/bash

# ============================================================
#  backup.sh – Automatisiertes Backup-Skript für Arch Linux
#  Autor: Santanam Wishal
#  Beschreibung: Komprimiert wichtige Verzeichnisse und
#                speichert sie mit Zeitstempel im Backup-Ordner
# ============================================================

# --- CONFIGURATION ---
SOURCE_DIRS=(
    "$HOME/Documents"
    "$HOME/.config"
)
BACKUP_DIR="$HOME/backups"
LOG_FILE="$BACKUP_DIR/backup.log"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$DATE.tar.gz"

# --- LOG FUCTION ---
log() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1" | tee -a "$LOG_FILE"
}

# --- MACH NEU FOLDER ---
mkdir -p "$BACKUP_DIR"

log "====== Backup gestartet ======"
log "Quellverzeichnisse: ${SOURCE_DIRS[*]}"
log "Zieldatei: $BACKUP_DIR/$BACKUP_NAME"

# --- RUN THE BACKUP---
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "${SOURCE_DIRS[@]}" 2>>"$LOG_FILE"

# --- CHECK ---
if [ $? -eq 0 ]; then
    SIZE=$(du -sh "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)
    log "Backup erfolgreich abgeschlossen. Größe: $SIZE"
else
    log "FEHLER: Backup fehlgeschlagen! Bitte Logs prüfen."
    exit 1
fi

# --- HAPUS BACKUP LAMA (lebih dari 7 hari) ---
find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -delete
log "Alte Backups (älter als 7 Tage) wurden gelöscht."

log "====== Backup beendet ======"
