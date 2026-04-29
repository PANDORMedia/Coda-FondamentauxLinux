# Syllabus - Fondamentaux de Linux

## Résumé

Formation intensive de 3 jours pour acquérir les fondamentaux Linux utiles en développement, DevOps, support, cybersécurité d'entrée de gamme et systèmes embarqués. Le cours commence par l'installation d'Ubuntu Server en VM, puis amène progressivement les étudiants à manipuler le système en terminal, automatiser des tâches simples et diagnostiquer un service.

## Public cible

- Étudiants techniques ayant peu ou pas pratiqué Linux.
- Développeurs juniors devant travailler avec des serveurs, conteneurs, CI/CD ou environnements cloud.
- Profils support, réseau, sécurité ou IoT ayant besoin d'être autonomes en terminal.

## Pré-requis

- Savoir utiliser un ordinateur et un éditeur de texte.
- Comprendre les notions générales de fichier, dossier, réseau IP et compte utilisateur.
- Aucune expérience Linux préalable obligatoire.

## Objectifs pédagogiques

À la fin des 3 jours, l'étudiant doit pouvoir :

- expliquer le rôle de Linux, d'une distribution, du shell et du filesystem ;
- situer Linux dans l'histoire Unix, GNU, distributions, cloud et embarqué ;
- installer Ubuntu Server dans une VM avec des choix simples et justifiés ;
- expliquer le rôle du kernel dans les processus, la mémoire, les fichiers et le réseau ;
- utiliser Bash pour naviguer, inspecter, créer, déplacer et supprimer des fichiers sans casser le système ;
- lire l'aide locale avec `man` et `--help`, puis construire une stratégie de recherche autonome ;
- manipuler texte, redirections, pipelines, filtres et expressions régulières simples ;
- gérer archives, compression et sauvegardes simples ;
- comprendre utilisateurs, groupes, `sudo`, ownership et permissions ;
- écrire un script Bash simple avec variables, arguments, boucle, code retour et messages d'erreur ;
- observer processus, ressources, logs et services `systemd` ;
- interpréter les bases mémoire : RAM disponible, cache, swap et signaux OOM ;
- diagnostiquer les bases réseau : IP, route, DNS, port, connexion sortante ;
- configurer et utiliser SSH avec une approche minimale de sécurité.

## Format pédagogique

- Volume total : 21h pédagogiques.
- Magistral : 7h, soit 1/3.
- Pratique : 14h, soit 2/3.
- Méthode : concept court, démonstration, TP guidé, mini-challenge, débrief.
- Fil rouge : installer puis construire un environnement Linux de travail et de diagnostic autour d'une VM serveur.

## Environnement proposé

- Une VM Ubuntu Server LTS par étudiant ou par binôme, installée au début du cours.
- Virtualisation recommandée : VirtualBox, VMware, UTM ou équivalent selon les machines.
- Fallback si la virtualisation locale bloque : VM cloud préparée, machine distante, Multipass ou WSL pour les manipulations terminal.
- Accès terminal local ou SSH.
- Outils de base : Bash, `man`, `nano` ou `vim`, `grep`, `find`, `tar`, `ss`, `ip`, `systemctl`, `journalctl`, `apt`.
- Comparaisons ponctuelles avec Red Hat/RHEL : `dnf`, logique systemd identique, différences de chemins ou conventions si utile.

## Compétences évaluées

### Jour 1 - Survivre et travailler dans le terminal

Compétences :

- installer Ubuntu Server dans une VM avec disque virtuel, compte utilisateur et réseau de base ;
- se connecter après le premier boot, comprendre le prompt, identifier l'utilisateur et la machine ;
- naviguer avec chemins absolus/relatifs ;
- explorer l'arborescence Linux ;
- créer, copier, déplacer, renommer et supprimer avec prudence ;
- lire des fichiers et modifier un fichier texte simple ;
- utiliser l'aide locale.

Livrable :

- une VM Ubuntu fonctionnelle, un workspace propre contenant une arborescence documentée, un fichier de notes système et une preuve de navigation/inspection.

### Jour 2 - Exploiter la puissance de la ligne de commande

Compétences :

- chaîner des commandes avec pipes et redirections ;
- filtrer, extraire, trier et compter des données textuelles ;
- créer/restaurer une archive compressée ;
- interpréter et modifier des permissions ;
- créer un script Bash simple.

Livrable :

- un script `audit-home.sh` ou équivalent qui produit un rapport texte et une archive de sauvegarde contrôlée.

### Jour 3 - Administrer et diagnostiquer les bases serveur

Compétences :

- observer processus, mémoire, disque et logs ;
- installer/mettre à jour un paquet ;
- contrôler un service avec `systemd` ;
- diagnostiquer IP, DNS, route et ports ;
- établir une connexion SSH et appliquer un durcissement minimal ;
- résoudre un incident simple avec une démarche structurée.

Livrable :

- une VM avec un service installé, démarré au boot, accessible localement, documenté et diagnostiquable via commandes et logs.

## Évaluation proposée

- 40% : TP et livrables journaliers.
- 30% : projet final de diagnostic serveur.
- 20% : quiz courts de compréhension.
- 10% : qualité de méthode : commandes justifiées, prudence avec les opérations destructives, notes reproductibles.

Critères de réussite :

- les commandes sont comprises, pas seulement copiées ;
- l'étudiant sait trouver l'aide utile ;
- les livrables sont reproductibles ;
- les erreurs sont diagnostiquées avec une hypothèse et une preuve.

## Syllabus retenu

| Module | Contenu | Justification |
| --- | --- | --- |
| Installation Ubuntu | ISO, VM, ressources, disque virtuel, compte utilisateur, premier boot | Donner aux étudiants la chaîne complète avant le terminal |
| Histoire Linux | Unix, GNU, Linus Torvalds, distributions, cloud, Android, embarqué | Donner le contexte sans en faire un cours d'histoire |
| Culture Linux utile | distributions, open source, shell, serveur vs desktop | Aligné LPI/Linux Foundation, mais limité au strict nécessaire |
| Kernel | processus, appels système, drivers, isolation, fichiers, réseau | Comprendre ce que le système fait vraiment |
| Terminal et aide | Bash, options, historique, `man`, `--help`, documentation locale | Autonomie immédiate |
| Filesystem | `/`, `/home`, `/etc`, `/var/log`, `/tmp`, `/proc`, `/dev`, chemins | Base commune pour DevOps, support et sécurité |
| Fichiers et texte | `ls`, `cd`, `cp`, `mv`, `rm`, `mkdir`, `touch`, `cat`, `less`, `head`, `tail`, éditeur | Gestes quotidiens |
| Pipelines | redirections, pipes, `grep`, `sort`, `cut`, `wc`, regex simples | Productivité terminal |
| Archives | `tar`, `gzip`, `zip`, restauration | Sauvegarde et transfert |
| Sécurité locale | utilisateurs, groupes, `sudo`, `chmod`, `chown`, sticky bit, liens symboliques | Base administration et sécurité |
| Bash scripting | shebang, variables, arguments, boucles, exit status | Automatisation minimale |
| Processus, mémoire et logs | `ps`, `top`, `free`, `df`, `du`, `journalctl`, `/proc`, page cache, swap | Diagnostic |
| Services et packages | `apt`, notion de dépôt, `systemctl`, service au boot | Administration serveur |
| Réseau et SSH | `ip`, `ss`, `ping`, DNS, `/etc/hosts`, SSH clés, durcissement minimal | Travail distant et debugging |

## Hors périmètre pour cette version

- préparation exhaustive à LPI Linux Essentials ;
- administration avancée stockage/LVM/RAID ;
- durcissement sécurité avancé ;
- containers, Docker et Kubernetes ;
- automatisation multi-machines avec Ansible ;
- construction d'un serveur web complet de production ;
- dual boot, partitionnement manuel avancé et installation destructive sur machine physique.
