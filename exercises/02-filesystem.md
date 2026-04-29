# TP 02 - Filesystem et fichiers

Objectif : creer une arborescence propre et manipuler des fichiers sans risque.

## Creer le lab

```bash
mkdir -p ~/linux-lab/notes
mkdir -p ~/linux-lab/data
mkdir -p ~/linux-lab/backup
```

## Explorer

```bash
ls /
ls /etc
ls /var
ls -la ~
pwd
```

## Copier des fichiers systeme

```bash
cp /etc/os-release ~/linux-lab/data/os-release.copy
cp /etc/passwd ~/linux-lab/data/passwd.copy
```

## Lire

```bash
cat ~/linux-lab/data/os-release.copy
head -n 5 ~/linux-lab/data/passwd.copy
less ~/linux-lab/data/passwd.copy
```

## Editer

```bash
nano ~/linux-lab/notes/commandes.md
```

Ajouter 10 commandes utiles et une phrase pour chacune.

## Verifier

```bash
find ~/linux-lab -maxdepth 3 -type f
```

## Livrable

Le dossier `~/linux-lab` doit contenir :

- `notes/system-notes.md` ;
- `notes/commandes.md` ;
- `data/os-release.copy` ;
- `data/passwd.copy`.
