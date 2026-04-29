# TP 03 - Texte, pipes et recherche

Objectif : filtrer des fichiers avec des commandes composees.

## Donnees

Depuis la racine du cours :

```bash
cp examples/jour-2/web.log ~/linux-lab/data/
cp examples/jour-2/inventory.csv ~/linux-lab/data/
```

Si vous etes dans la VM sans partage de dossier, le formateur fournit les fichiers.

## Logs web

Compter les lignes :

```bash
wc -l ~/linux-lab/data/web.log
```

Trouver les erreurs serveur :

```bash
grep " 500 " ~/linux-lab/data/web.log
```

Compter les erreurs serveur :

```bash
grep " 500 " ~/linux-lab/data/web.log | wc -l
```

Lister les IP uniques :

```bash
cut -d' ' -f1 ~/linux-lab/data/web.log | sort | uniq
```

## Inventaire CSV

Afficher les hostnames :

```bash
cut -d, -f1 ~/linux-lab/data/inventory.csv
```

Chercher les machines Ubuntu :

```bash
grep -i ubuntu ~/linux-lab/data/inventory.csv
```

## Livrable

Creer `~/linux-lab/notes/pipelines.md` avec :

- 3 commandes utiles ;
- le resultat attendu ;
- une phrase qui explique chaque pipe.
