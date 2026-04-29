# TP 08 - Memoire et disque

Objectif : lire les signaux RAM, swap et disque.

## Memoire

```bash
free -h
cat /proc/meminfo | head
vmstat 1 5
```

Questions :

- Quelle valeur donne la RAM utilisable ?
- La machine utilise-t-elle du swap ?
- Quelle commande donne une vue dynamique ?

## Disque

```bash
df -h
df -i
du -sh ~/linux-lab
findmnt
lsblk
```

Questions :

- Quel filesystem contient `/` ?
- Combien d'espace reste-t-il ?
- Les inodes sont-ils proches de la saturation ?
- Combien pese `~/linux-lab` ?

## Livrable

Creer `~/linux-lab/notes/resources.md` avec :

- RAM totale ;
- RAM disponible ;
- swap utilise ;
- espace libre sur `/` ;
- taille de `~/linux-lab`.
