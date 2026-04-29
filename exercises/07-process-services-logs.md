# TP 07 - Processus, services et logs

Objectif : observer l'etat d'une machine.

## Processus

```bash
ps aux | head
ps -eo pid,ppid,user,stat,comm --sort=comm | head
top
```

Quitter `top` avec `q`.

## Services

```bash
systemctl --failed
systemctl status ssh
```

Si `ssh` n'est pas installe :

```bash
sudo apt update
sudo apt install openssh-server
```

## Logs

```bash
journalctl -n 30
journalctl -u ssh -n 30
journalctl -p warning -b
journalctl -k | tail
```

## Incident simple

Stopper puis redemarrer SSH :

```bash
sudo systemctl stop ssh
systemctl status ssh
sudo systemctl start ssh
systemctl status ssh
```

## Livrable

Creer `~/linux-lab/notes/diagnostic-services.md` avec :

- commande qui liste les services en echec ;
- commande qui montre l'etat de SSH ;
- commande qui affiche les logs SSH ;
- difference entre `start` et `enable`.
