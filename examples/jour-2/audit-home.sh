#!/usr/bin/env bash
set -u

target="${1:-$HOME}"
backup_dir="$HOME/linux-lab/backup"
backup_file="$backup_dir/audit-backup.tar.gz"

if [ ! -d "$target" ]; then
  echo "Erreur: dossier introuvable: $target" >&2
  exit 1
fi

mkdir -p "$backup_dir"

echo "Audit: $target"
echo "Utilisateur: $(whoami)"
echo "Machine: $(hostname)"
date
df -h "$target"
free -h
echo "Fichiers directs:"
find "$target" -maxdepth 1 -type f | wc -l

tar -czf "$backup_file" "$target"
echo "Archive: $backup_file"
