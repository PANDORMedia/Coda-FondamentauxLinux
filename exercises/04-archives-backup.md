# TP 04 - Archives et restauration

Objectif : creer une sauvegarde et verifier qu'elle se restaure.

## Creer une archive

```bash
cd ~
tar -czf linux-lab-backup.tar.gz linux-lab
```

## Verifier le contenu

```bash
tar -tzf linux-lab-backup.tar.gz | head
tar -tzf linux-lab-backup.tar.gz | grep system-notes.md
```

## Restaurer dans un dossier test

```bash
mkdir -p ~/restore-test
tar -xzf linux-lab-backup.tar.gz -C ~/restore-test
find ~/restore-test/linux-lab -maxdepth 3 -type f
```

## Comparer

```bash
diff ~/linux-lab/notes/system-notes.md ~/restore-test/linux-lab/notes/system-notes.md
```

## Livrable

Ajouter dans `~/linux-lab/notes/backup.md` :

- commande de creation ;
- commande de verification ;
- commande de restauration ;
- resultat du test.
