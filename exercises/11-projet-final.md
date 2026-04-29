# Projet final - Serveur diagnostiquable

Objectif : prouver qu'une VM Linux peut etre exploitee et diagnostiquee.

## Mission

En binome, preparer une VM Ubuntu avec un service fonctionnel.

Service recommande :

- `nginx` si Internet et `apt` fonctionnent ;
- `ssh` si nginx est impossible ;
- mini serveur Python si aucun paquet ne peut etre installe.

## Preuves attendues

Identifier la machine :

```bash
hostname
lsb_release -a
uname -r
ip address
```

Verifier ressources :

```bash
df -h
free -h
```

Verifier service :

```bash
systemctl status nginx
ss -tulpn
curl -I http://localhost
journalctl -u nginx -n 30
```

Adapter les commandes si le service choisi n'est pas nginx.

## Incident a traiter

Le formateur choisit un incident :

- service stoppe ;
- mauvais fichier de page web ;
- permission incorrecte ;
- port non ecoute ;
- disque presque plein dans un dossier de test.

## Livrable

Rendre une fiche `projet-final.md` avec :

- etat initial ;
- hypothese ;
- commandes de preuve ;
- correction appliquee ;
- test final ;
- procedure de reprise.

## Demo

3 minutes par binome :

- montrer le service ;
- montrer le port ;
- montrer les logs ;
- expliquer la correction.
