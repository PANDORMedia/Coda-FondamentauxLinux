# TP 06 - Script Bash d'audit

Objectif : creer un script utile, lisible et testable.

## Fichier

```bash
nano ~/linux-lab/audit-home.sh
chmod 755 ~/linux-lab/audit-home.sh
```

## Squelette

```bash
#!/usr/bin/env bash
set -u

target="${1:-$HOME}"

if [ ! -d "$target" ]; then
  echo "Erreur: dossier introuvable: $target" >&2
  exit 1
fi

echo "Audit: $target"
echo "Utilisateur: $(whoami)"
echo "Machine: $(hostname)"
date
df -h "$target"
free -h
find "$target" -maxdepth 1 -type f | wc -l
```

## Ajouter une archive

Ajouter une commande `tar` qui cree :

```text
~/linux-lab/backup/audit-backup.tar.gz
```

## Tests

```bash
~/linux-lab/audit-home.sh ~/linux-lab
echo $?

~/linux-lab/audit-home.sh /dossier/inexistant
echo $?
```

## Livrable

Le script doit :

- accepter un dossier cible ;
- refuser un dossier absent ;
- afficher un rapport court ;
- creer une archive ;
- retourner un code erreur en cas d'echec.
