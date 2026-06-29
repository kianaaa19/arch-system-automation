# arch-system-automation

Automatisiertes Backup-System für Arch Linux mit Bash und Systemd.

## Funktionen
- Komprimiert wichtige Verzeichnisse als `.tar.gz`
- Automatische Ausführung täglich via Systemd Timer
- Logging mit Zeitstempel in `backup.log`
- Automatisches Löschen von Backups älter als 7 Tage

## Technologien
- Arch Linux, Bash, Systemd (Service & Timer), Git

## Installation

```bash
git clone https://github.com/kianaaa19/arch-system-automation
cd arch-system-automation
chmod +x backup.sh

# Systemd Timer aktivieren
cp systemd/* ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now backup.timer
```

## Verzeichnisstruktur

```
arch-system-automation/
├── backup.sh          # Haupt-Backup-Skript
├── systemd/
│   ├── backup.service # Systemd Service Unit
│   └── backup.timer   # Systemd Timer Unit
└── README.md
```
