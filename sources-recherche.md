# Sources de recherche - Fondamentaux de Linux

Recherche effectuée le 27 avril 2026 pour cadrer un cours court de 21h, orienté pratique et compatible avec une progression DevOps/cloud/IoT.

## Sources principales

### Linux Professional Institute - Linux Essentials

- Page certification : https://www.lpi.org/our-certifications/linux-essentials-overview/
- Objectifs détaillés 010-160 : https://www.lpi.org/our-certifications/exam-010-objectives/

Points retenus :

- Linux Essentials est le meilleur référentiel de base pour un public sans prérequis Linux.
- Les objectifs couvrent open source, ligne de commande, aide locale, fichiers, archives, recherche texte, scripts simples, matériel, réseau, sécurité, utilisateurs/groupes et permissions.
- Le syllabus du cours reprend surtout les topics 2, 3, 4 et 5, avec un rappel court du topic 1.

### Linux Foundation - Introduction to Linux (LFS101)

- Page cours : https://training.linuxfoundation.org/training/introduction-to-linux/

Points retenus :

- Cours débutant pour utilisateurs expérimentés ayant peu ou pas d'exposition à Linux.
- Progression large : philosophie Linux, démarrage système, ligne de commande, documentation, processus, fichiers, éditeurs, environnement utilisateur, manipulation de texte, réseau, Bash et sécurité locale.
- Le cours proposé condense cette progression en 21h et retire les éléments moins prioritaires pour un public DevOps/serveur, comme l'interface graphique et l'impression.

### Red Hat - System Administration I (RH124)

- Page cours : https://www.redhat.com/en/services/training/rh124-red-hat-system-administration-i

Points retenus :

- Référence utile pour les gestes professionnels d'administration sur un serveur unique.
- Contenus intégrés au plan : ligne de commande, hiérarchie de fichiers, édition texte, redirections, utilisateurs/groupes, permissions, packages, processus, systemd, réseau et SSH.
- Les éléments spécifiques RHEL sont généralisés : `dnf` est mentionné comme comparaison, mais la base de TP peut rester Ubuntu/Debian avec `apt`.

### Ubuntu Server Documentation

- Documentation serveur : https://ubuntu.com/server/docs/
- Installation de base : https://ubuntu.com/server/docs/tutorial/basic-installation/

Points retenus :

- Source opérationnelle pour les tâches Ubuntu actuelles : gestion de paquets, réseau, sécurité, SSH, pare-feu, services et dépannage.
- Le plan cible une VM Ubuntu Server LTS pour limiter les frictions d'installation et rester proche des usages cloud.
- L'installation est intégrée au Jour 1 : ISO serveur, ressources VM minimales, disque virtuel, utilisateur, réseau simple et premier boot.

### GNU Project

- Vue d'ensemble GNU : https://www.gnu.org/gnu/gnu-history.html
- Page GNU : https://www.gnu.org/gnu/

Points retenus :

- GNU commence en 1983 avec l'objectif d'un système libre compatible Unix.
- Le cours présente GNU comme une partie du contexte historique, sans débat terminologique long.

### Linux Kernel Documentation

- Mémoire Linux : https://docs.kernel.org/admin-guide/mm/index.html
- Documentation mémoire : https://docs.kernel.org/mm/index.html

Points retenus :

- La mémoire Linux combine mémoire virtuelle, pagination, allocation, cache, swap et mécanismes OOM.
- Le cours limite ce sujet aux signaux utiles en diagnostic : `free`, `/proc/meminfo`, `vmstat`, page cache, swap et logs kernel.

### NDG Linux Essentials

- Page cours : https://www.netdevgroup.com/online/courses/open-source/linux-essentials

Points retenus :

- Confirme une progression pédagogique avec labs sur ligne de commande, aide, filesystem, fichiers, archives, texte, scripting, réseau, sécurité, utilisateurs et permissions.
- Le volume NDG est beaucoup plus long. Ici, les objectifs sont compressés et priorisés pour 21h en présentiel.

## Choix de syllabus

Le syllabus retenu n'est pas une préparation complète à une certification. Il privilégie les compétences directement réutilisables en développement, DevOps, cybersécurité d'entrée de gamme et IoT :

- naviguer et travailler sans interface graphique ;
- comprendre l'histoire courte de Linux et le rôle du kernel ;
- comprendre où sont les fichiers, configurations, logs et processus ;
- manipuler texte, redirections et pipelines ;
- sécuriser les accès de base avec utilisateurs, groupes, permissions et `sudo` ;
- écrire un script Bash simple et robuste ;
- diagnostiquer un service, un port, un nom DNS, une connexion SSH et un log système.

## Sujets volontairement limités ou exclus

- Installation sur machine physique, dual boot et partitionnement manuel : hors priorité pour éviter les risques de perte de données.
- Desktop Linux, applications graphiques et impression : hors priorité pour ce public.
- Stockage avancé, LVM, RAID, SELinux/AppArmor avancé : mentionnés seulement si le rythme le permet.
- Conteneurs et Kubernetes : exclus du coeur, car couverts dans un parcours DevOps séparé.
- Administration multi-serveurs et automatisation Ansible : hors périmètre.
