# Plan - Fondamentaux de Linux - 3 jours

Objectif : rendre les étudiants autonomes sur les fondamentaux Linux nécessaires pour développer, déployer, diagnostiquer et travailler sur des environnements serveur.

Pré-requis : usage courant d'un ordinateur, notions générales de fichiers, réseau et compte utilisateur. Aucune expérience Linux obligatoire.

Règle d'or : chaque concept est manipulé immédiatement. Le cours doit rester 1/3 magistral et 2/3 pratique.

Volume : 3 x 7h pédagogiques, pauses hors budget. Chaque journée contient 140 min de magistral et 280 min de pratique.

## Parcours pédagogique

### Socle obligatoire

- Une VM Ubuntu Server installée par étudiant ou binôme.
- Un fil rouge : installer un système inconnu, puis le rendre simple, documenté et diagnostiquable.
- Des livrables visibles à la fin de chaque jour.
- Des commandes expliquées et reproductibles, pas des recettes copiées.

### Approfondissements si le rythme le permet

- `vim` au-delà du strict minimum.
- Permissions spéciales au-delà du sticky bit.
- Introduction à AppArmor ou SELinux.
- Comparaison plus poussée Debian/Ubuntu vs Red Hat.
- Premiers hooks Git ou scripts de maintenance plus avancés.

## Jour 1 - Installer Ubuntu, terminal et filesystem

Objectif : installer Ubuntu Server en VM, effectuer le premier boot, se repérer dans Linux et manipuler les fichiers sans interface graphique.

| Bloc | Durée | Magistral | Pratique | Contenu |
| --- | ---: | ---: | ---: | --- |
| 0. Accueil, objectif et préflight | 35 min | 15 | 20 | Tour de table, vérification machine, hyperviseur, ISO, réseau |
| 1. Installation Ubuntu Server en VM | 90 min | 25 | 65 | ISO, ressources VM, disque virtuel, compte utilisateur, OpenSSH optionnel, premier redémarrage |
| 2. Premier boot, histoire et modèle Linux | 55 min | 30 | 25 | Histoire Unix/GNU/Linux, distribution, noyau, shell, users, processus, filesystem |
| 3. Premières commandes Bash | 60 min | 25 | 35 | Prompt, options, historique, `whoami`, `pwd`, `echo`, `type`, `PATH` |
| 4. Navigation et exploration | 65 min | 20 | 45 | `/`, `/home`, `/etc`, `/var`, chemins absolus/relatifs, fichiers cachés |
| 5. Fichiers, aide et édition texte | 75 min | 20 | 55 | `touch`, `mkdir`, `cp`, `mv`, `rm`, `cat`, `less`, `man`, éditeur, prudence destructive |
| 6. Mini-lab J1 | 40 min | 5 | 35 | Créer une arborescence de travail documentée et vérifiable |

Livrable J1 :

- une VM Ubuntu Server installée et accessible ;
- un dossier `linux-lab/` organisé ;
- une fiche `system-notes.md` avec commandes utiles, chemins importants et observations ;
- une preuve de manipulation : version système, arborescence, fichiers créés, fichiers lus, aide consultée.

## Jour 2 - Ligne de commande productive, permissions et scripts

Objectif : transformer la ligne de commande en outil de travail quotidien : filtrer, sauvegarder, sécuriser et automatiser.

| Bloc | Durée | Magistral | Pratique | Contenu |
| --- | ---: | ---: | ---: | --- |
| 0. Rappel et kata J1 | 35 min | 5 | 30 | Retrouver des fichiers, corriger chemins, manipuler sans aide du formateur |
| 1. Redirections et pipelines | 65 min | 25 | 40 | `>`, `>>`, `<`, `2>`, `|`, sortie standard, erreur standard |
| 2. Recherche et extraction texte | 75 min | 25 | 50 | `grep`, `find`, `sort`, `cut`, `wc`, regex simples |
| 3. Utilisateurs, groupes et permissions | 85 min | 35 | 50 | `id`, `sudo`, `/etc/passwd`, `chmod`, `chown`, droits fichiers/dossiers |
| 4. Archives et sauvegardes | 55 min | 15 | 40 | `tar`, compression, vérification, restauration |
| 5. Bash scripting | 85 min | 30 | 55 | shebang, variables, arguments, boucles, exit status, messages d'erreur |
| 6. Mini-lab J2 | 20 min | 5 | 15 | Script d'audit + archive contrôlée |

Livrable J2 :

- un script `audit-home.sh` ou équivalent ;
- un rapport texte généré automatiquement ;
- une archive compressée vérifiée ;
- une explication courte des permissions appliquées.

## Jour 3 - Administration de base et diagnostic serveur

Objectif : observer un système, gérer un service, diagnostiquer un problème réseau simple et travailler à distance avec SSH.

| Bloc | Durée | Magistral | Pratique | Contenu |
| --- | ---: | ---: | ---: | --- |
| 0. Rappel et questions | 30 min | 5 | 25 | Rejouer les gestes clés J1-J2 |
| 1. Kernel, processus, mémoire et logs | 70 min | 25 | 45 | Scheduler, mémoire virtuelle, page cache, swap, `ps`, `top`, `free`, `/proc`, `journalctl` |
| 2. Paquets et cycle logiciel | 55 min | 20 | 35 | `apt`, dépôts, update/upgrade/install/remove, comparaison `dnf` |
| 3. Services avec systemd | 75 min | 30 | 45 | `systemctl`, enable/disable, status, logs, redémarrage contrôlé |
| 4. Réseau Linux essentiel | 75 min | 30 | 45 | IP, route, DNS, `/etc/hosts`, `ping`, `ip`, `ss`, ports |
| 5. SSH et sécurité minimale | 55 min | 20 | 35 | client/serveur SSH, clés, permissions, accès distant, principes de durcissement |
| 6. Projet final | 60 min | 10 | 50 | Mettre en place, documenter et diagnostiquer un service simple |

Livrable J3 :

- un service installé et démarré au boot ;
- une note de diagnostic : processus, port, logs, commande de test ;
- une connexion SSH fonctionnelle ou simulée selon environnement ;
- une procédure de reprise en cas de service arrêté.

## Projet final proposé

Chaque binôme reçoit une VM avec un état à analyser. Il doit :

- identifier la distribution, l'utilisateur courant, l'adresse IP et les services actifs ;
- installer ou vérifier un petit service ;
- corriger au moins un problème simple : permission, service arrêté, port non écouté, DNS local ou fichier de config ;
- produire une fiche d'exploitation avec commandes de vérification ;
- présenter une démo courte : preuve que le service fonctionne et preuve qu'il est diagnostiquable.

## Cahier d'exercices

Au-delà des TP intégrés (`exercises/0X-...md`) liés à chaque slide via le panneau TP, un **cahier de 36 exercices** est remis aux étudiants en début de formation : [`exercises/cahier-exercices.md`](exercises/cahier-exercices.md).

Caractéristiques :

- 36 exercices répartis sur les 3 jours ;
- 3 niveaux de difficulté (D1 = drill court, D2 = exercice ciblé, D3 = problème long) ;
- chaque exercice indique objectif, durée, livrable précis ;
- les corrections sont dans un fichier séparé (`corrections-formateur.md`) **non distribué** aux étudiants.

Usage suggéré :

- 5-10 D1 par demi-journée comme drills (entre deux blocs magistraux) ;
- 1-2 D2 en TP guidé ;
- 1 D3 en mini-projet ou à la maison.

## Validation demandée avant construction

Points à valider avant de produire les slides et TP détaillés :

- niveau exact des étudiants ;
- distribution cible : Ubuntu Server LTS par défaut, autre si nécessaire ;
- travail individuel ou binômes ;
- accès Internet autorisé pendant les TP ;
- besoin ou non d'une évaluation notée ;
- outil de virtualisation disponible dans la salle ;
- place souhaitée pour SSH réel, VM locale, cloud ou WSL.
