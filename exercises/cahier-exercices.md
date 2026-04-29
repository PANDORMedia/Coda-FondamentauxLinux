# Cahier d'exercices - Fondamentaux de Linux

> Version etudiante. Les corrections sont remises par le formateur en fin de bloc.

Ce cahier contient 36 exercices repartis sur 3 jours. Chaque exercice indique :

- son objectif ;
- la difficulte (D1 a D3) ;
- le temps estime (5, 10, 20 min...) ;
- ce qui doit figurer dans le livrable.

Conventions :

- toutes les manipulations se font dans `~/linux-lab` ;
- les livrables ecrits vont dans `~/linux-lab/notes/` ;
- les scripts vont dans `~/linux-lab/bin/` ;
- a chaque etape, on doit pouvoir citer la **commande** et la **preuve** (sortie, fichier, code retour).

---

## Sommaire

| # | Titre | Jour | Difficulte | Duree |
| --- | --- | --- | --- | --- |
| 01 | Identifier la machine | J1 | D1 | 5 min |
| 02 | L'aide locale en 60 secondes | J1 | D1 | 5 min |
| 03 | Naviguer sans se perdre | J1 | D1 | 10 min |
| 04 | Les fichiers caches | J1 | D1 | 5 min |
| 05 | Construire `~/linux-lab` | J1 | D1 | 10 min |
| 06 | Copier, renommer, supprimer | J1 | D1 | 10 min |
| 07 | Lire trois sortes de fichiers | J1 | D1 | 10 min |
| 08 | Fiche `system-notes.md` | J1 | D2 | 20 min |
| 09 | Pipes : compter et trier | J2 | D1 | 10 min |
| 10 | Top 5 des codes HTTP du web.log | J2 | D2 | 10 min |
| 11 | Top des IP les plus actives | J2 | D2 | 10 min |
| 12 | grep -v et le bruit | J2 | D2 | 5 min |
| 13 | grep avec contexte | J2 | D2 | 5 min |
| 14 | find et la modification recente | J2 | D2 | 10 min |
| 15 | xargs et noms a espaces | J2 | D2 | 10 min |
| 16 | sed sur un CSV | J2 | D2 | 10 min |
| 17 | awk : moyenne d'une colonne | J2 | D3 | 15 min |
| 18 | tar : creer et restaurer | J2 | D1 | 10 min |
| 19 | Lire `ls -l` | J2 | D1 | 10 min |
| 20 | Permissions : refuser le 777 | J2 | D2 | 10 min |
| 21 | Lien symbolique vers une config | J2 | D2 | 10 min |
| 22 | Bash : Hello arg | J2 | D1 | 5 min |
| 23 | Bash : valeur par defaut | J2 | D2 | 10 min |
| 24 | Bash : test sur dossier | J2 | D2 | 10 min |
| 25 | Bash : boucle for sur logs | J2 | D2 | 10 min |
| 26 | Bash : while read d'un CSV | J2 | D3 | 15 min |
| 27 | Bash : case pour service | J2 | D2 | 15 min |
| 28 | Bash : audit complet | J2 | D3 | 30 min |
| 29 | Processus : trouver les gros mangeurs | J3 | D2 | 10 min |
| 30 | Signaux et `kill` | J3 | D2 | 10 min |
| 31 | Memoire : free vs available | J3 | D1 | 5 min |
| 32 | Disque : qui mange l'espace ? | J3 | D2 | 10 min |
| 33 | systemctl : start vs enable | J3 | D2 | 10 min |
| 34 | journalctl : suivre un service | J3 | D2 | 10 min |
| 35 | Reseau : la methode IP/route/DNS/port | J3 | D2 | 15 min |
| 36 | SSH : cle ed25519 et copy-id | J3 | D2 | 15 min |

---

## Jour 1 - Survie en terminal

### Exercice 01 - Identifier la machine
**D1 - 5 min**

Dans la VM fraichement bootee, repondez a ces questions :

1. Qui suis-je connecte en tant que ?
2. Quel est le nom de la machine ?
3. Quelle est la version exacte d'Ubuntu ?
4. Quelle est la version du noyau Linux ?
5. Quelle est l'adresse IP principale ?

**Livrable** : un texte de 5 lignes dans `~/linux-lab/notes/system-notes.md` avec les 5 reponses, chacune accompagnee de la commande utilisee.

---

### Exercice 02 - L'aide locale en 60 secondes
**D1 - 5 min**

Sans Google :

1. Trouver l'option de `ls` qui affiche les tailles en format humain.
2. Trouver l'option de `df` qui fait la meme chose.
3. Trouver la difference entre `man passwd` (section 1) et `man 5 passwd` (section 5).

**Livrable** : 3 lignes dans `notes/help.md`, chacune avec la commande et la reponse trouvee.

---

### Exercice 03 - Naviguer sans se perdre
**D1 - 10 min**

Realiser cette sequence sans erreur :

1. Aller dans `/etc`.
2. Lister son contenu.
3. Revenir au home avec un chemin **absolu**.
4. Aller a nouveau dans `/etc` avec un chemin **relatif** depuis le home.
5. Revenir au home avec `cd` sans argument.
6. Verifier a chaque etape avec `pwd`.

**Livrable** : copier la sortie de `history | tail -n 15` dans `notes/navigation.md`.

---

### Exercice 04 - Les fichiers caches
**D1 - 5 min**

1. Lister tous les fichiers de `~`, **y compris** les caches.
2. Compter combien sont caches.
3. Afficher les 10 premieres lignes de `~/.bashrc`.

**Livrable** : 3 lignes dans `notes/dotfiles.md` : commande, resultat (nombre), extrait.

---

### Exercice 05 - Construire `~/linux-lab`
**D1 - 10 min**

Creer en une seule commande l'arborescence suivante :

```
~/linux-lab/
  notes/
  data/
  backup/
  bin/
  permissions/
```

Puis :

1. Verifier avec une commande qui montre la structure.
2. Creer un fichier vide `notes/README.md`.
3. Y ecrire en une commande la phrase "Linux lab - apprenti administrateur".

**Livrable** : la sortie de `find ~/linux-lab -maxdepth 2` + le contenu de `README.md`.

---

### Exercice 06 - Copier, renommer, supprimer
**D1 - 10 min**

1. Copier `/etc/os-release` dans `~/linux-lab/data/`.
2. Renommer la copie en `os-release.copy`.
3. Faire une seconde copie sous `data/os-release.bak`.
4. Supprimer la `.copy`.
5. Verifier qu'il ne reste que la `.bak`.

> Avant chaque commande, predire mentalement le resultat. Si vous etes incertain, ajouter `-i` aux commandes destructives.

**Livrable** : sequence des commandes dans `notes/manipulation.md`.

---

### Exercice 07 - Lire trois sortes de fichiers
**D1 - 10 min**

1. Afficher entierement `/etc/os-release` (court).
2. Afficher les 5 premieres lignes de `/etc/passwd`.
3. Ouvrir `/var/log/dpkg.log` (ou `/var/log/apt/history.log` si absent) avec un visualiseur paginant. Chercher le mot `install`. Quitter proprement.

**Livrable** : noter dans `notes/lecture.md` la touche utilisee pour : chercher, aller a la ligne suivante du resultat de recherche, quitter.

---

### Exercice 08 - Fiche `system-notes.md`
**D2 - 20 min**

Produire une fiche reproductible decrivant la VM :

- distribution et version ;
- noyau ;
- architecture (`uname -m`) ;
- CPU (`lscpu` ou `cat /proc/cpuinfo`) ;
- RAM totale et disponible ;
- disque : taille, utilise, libre ;
- IP, masque, passerelle ;
- utilisateur courant et groupes.

Format demande : pour chaque ligne, **commande** suivie d'une **valeur**. Le formateur doit pouvoir relancer la fiche sur la VM et retomber sur les memes preuves.

**Livrable** : `~/linux-lab/notes/system-notes.md` complet.

---

## Jour 2 - Pipes, recherche, permissions, scripts

> Pre-requis : avoir copie les fichiers d'exemple :
>
> ```bash
> cp examples/jour-2/web.log ~/linux-lab/data/
> cp examples/jour-2/inventory.csv ~/linux-lab/data/
> ```

### Exercice 09 - Pipes : compter et trier
**D1 - 10 min**

A partir de `web.log` :

1. Combien de lignes au total ?
2. Combien de lignes contiennent `ERROR` ? (insensible a la casse)
3. Lister les codes HTTP rencontres une seule fois (sans doublons).

**Livrable** : 3 commandes + 3 resultats dans `notes/pipelines.md`.

---

### Exercice 10 - Top 5 des codes HTTP du `web.log`
**D2 - 10 min**

Construire une seule pipeline qui affiche :

```
   42 200
    7 404
    3 500
...
```

(le nombre d'occurrences puis le code HTTP, du plus frequent au moins frequent).

Indices : `awk` ou `cut`, puis `sort | uniq -c | sort -rn | head`.

**Livrable** : la commande exacte + la sortie dans `notes/top-http.md`.

---

### Exercice 11 - Top des IP les plus actives
**D2 - 10 min**

A partir de `web.log`, donner les **3 IP** les plus actives, du plus actif au moins actif.

**Livrable** : la pipeline + le resultat dans `notes/top-ip.md`.

---

### Exercice 12 - `grep -v` et le bruit
**D2 - 5 min**

Afficher les lignes de `/etc/passwd` qui correspondent **a un vrai compte humain** (sans `nologin` ni `false`).

Indice : `grep -v -E "(nologin|false)$"`.

**Livrable** : la commande + le nombre de comptes obtenus.

---

### Exercice 13 - `grep` avec contexte
**D2 - 5 min**

Dans `web.log`, afficher chaque erreur 500 avec **les 2 lignes precedentes et les 2 suivantes**.

**Livrable** : la commande + un extrait de la sortie.

---

### Exercice 14 - `find` et la modification recente
**D2 - 10 min**

1. Lister tous les fichiers `.md` dans `~/linux-lab` modifies dans les **dernieres 24h**.
2. Lister tous les fichiers de plus de **1 ko** dans `~/linux-lab`.
3. Pour chaque `.md` trouve, afficher son nombre de lignes via `find ... -exec wc -l {} \;`.

**Livrable** : 3 commandes + sorties dans `notes/find.md`.

---

### Exercice 15 - `xargs` et noms a espaces
**D2 - 10 min**

1. Creer 3 fichiers nommes `"rapport final.txt"`, `"note 2.txt"`, `"todo.md"` dans un dossier `~/linux-lab/data/risque/`.
2. Les lister avec `find` puis les **supprimer** sans casser sur les espaces.
3. Refaire la manipulation en utilisant la version sure : `find -print0 | xargs -0`.

**Livrable** : la commande **fragile** (qui casse) et la commande **sure** dans `notes/xargs.md`.

---

### Exercice 16 - `sed` sur un CSV
**D2 - 10 min**

Sur une **copie** de `inventory.csv` :

1. Remplacer la chaine `ubuntu` par `Ubuntu` (toutes occurrences, toutes lignes).
2. Verifier le resultat.
3. Faire la meme operation **en place** avec backup `.bak`.

**Livrable** : commandes + diff entre `.csv.bak` et `.csv` dans `notes/sed.md`.

---

### Exercice 17 - `awk` : moyenne d'une colonne
**D3 - 15 min**

Le fichier `inventory.csv` a la structure : `hostname,os,cpu_count,ram_gb`.

1. Avec `awk`, calculer la **moyenne** de la colonne `ram_gb`.
2. Afficher la liste des hosts qui ont **plus de 4 Go** de RAM.
3. Compter combien de hosts par OS.

**Livrable** : 3 commandes + 3 resultats dans `notes/awk.md`.

---

### Exercice 18 - `tar` : creer et restaurer
**D1 - 10 min**

1. Creer une archive `linux-lab-backup.tar.gz` du dossier `~/linux-lab`.
2. Lister son contenu sans extraire.
3. Restaurer dans `~/restore-test`.
4. Comparer un fichier original et restaure avec `diff`. Resultat attendu : pas de difference.

**Livrable** : commandes + resultat de `diff` dans `notes/backup.md`.

---

### Exercice 19 - Lire `ls -l`
**D1 - 10 min**

Pour chacune de ces lignes, expliquer en une phrase ce qu'elle represente :

```
-rw-r--r-- 1 sean students 1200 Apr 28 10:00 notes.md
drwxr-x--- 2 sean students 4096 Apr 28 10:05 backup
-rwsr-xr-x 1 root root    44784 ...           passwd
lrwxrwxrwx 1 sean students   18 ...           latest -> v3/index.html
```

Indique pour chaque ligne :

- type (fichier, dossier, lien, executable special) ;
- droits owner / group / other ;
- proprietaire et groupe ;
- difference avec la ligne precedente.

**Livrable** : 4 paragraphes dans `notes/ls-l.md`.

---

### Exercice 20 - Permissions : refuser le 777
**D2 - 10 min**

Dans `~/linux-lab/permissions/` :

1. Creer `public.txt`, `secret.txt`, `script.sh`.
2. Mettre `script.sh` executable, lisible par tous, modifiable par owner uniquement.
3. Mettre `secret.txt` en `600`.
4. Mettre `public.txt` en `644`.
5. Lancer le script.

Repondre par ecrit :

- pourquoi `chmod 777` n'est pas une bonne reponse a "ca ne marche pas" ?

**Livrable** : `notes/permissions.md` avec tableau (fichier, droit, justification) + reponse argumentee.

---

### Exercice 21 - Lien symbolique vers une config
**D2 - 10 min**

1. Creer `~/linux-lab/data/config-v1.ini` avec une ligne `port=8080`.
2. Creer un lien symbolique `~/linux-lab/data/config-current.ini` qui pointe vers `config-v1.ini`.
3. Lire `config-current.ini`.
4. Creer `config-v2.ini` avec `port=9090`.
5. Modifier le lien pour pointer vers `config-v2.ini`. Verifier.

**Livrable** : commandes + sortie de `ls -l` dans `notes/symlink.md`.

---

### Exercice 22 - Bash : Hello arg
**D1 - 5 min**

Ecrire `~/linux-lab/bin/hello.sh` :

- accepte un argument prenom ;
- si pas d'argument, salue `Inconnu` ;
- imprime `Bonjour, <prenom> !`.

Tester :

```
hello.sh
hello.sh Sarah
```

**Livrable** : le script + les deux sorties.

---

### Exercice 23 - Bash : valeur par defaut
**D2 - 10 min**

Ecrire `~/linux-lab/bin/sizeof.sh <dossier>` :

- si pas d'argument, utiliser `$HOME` ;
- afficher la taille du dossier en format humain (`du -sh`).

Le script ne doit pas crasher si l'utilisateur passe un dossier inexistant : il doit afficher un message d'erreur sur **stderr** et sortir avec **code 1**.

**Livrable** : le script + 3 tests (sans arg, dossier valide, dossier invalide) avec `echo $?` apres chaque.

---

### Exercice 24 - Bash : test sur dossier
**D2 - 10 min**

Ecrire `~/linux-lab/bin/safe-rm.sh <dossier>` :

- refuser de tourner si l'argument est `/`, `/home`, `/etc`, `/var` ou vide ;
- refuser si le dossier n'existe pas ;
- demander confirmation `[y/N]` avant suppression ;
- supprimer recursivement si confirme.

**Livrable** : le script + un journal de 4 tests (vide, `/`, dossier inexistant, dossier valide).

---

### Exercice 25 - Bash : boucle `for` sur logs
**D2 - 10 min**

Ecrire `~/linux-lab/bin/log-summary.sh <dossier>` :

- boucler sur tous les fichiers `.log` du dossier ;
- pour chacun : afficher nom, nombre de lignes, nombre d'erreurs (lignes contenant `ERROR`).

Format de sortie souhaite :

```
== access.log ==
lignes : 1024
erreurs: 12
```

**Livrable** : le script + sortie sur `examples/jour-2/`.

---

### Exercice 26 - Bash : `while read` sur un CSV
**D3 - 15 min**

Ecrire `~/linux-lab/bin/inventory-report.sh <csv>` :

- lire `inventory.csv` (saute la premiere ligne d'entete) ;
- pour chaque ligne : afficher `hostname` et `ram_gb` ;
- a la fin, afficher la **somme** totale de RAM.

Indice : `while IFS=, read -r host os cpu ram; do ... done < "$csv"`.

**Livrable** : le script + la sortie attendue.

---

### Exercice 27 - Bash : `case` pour un service
**D2 - 15 min**

Ecrire `~/linux-lab/bin/lab-service.sh start|stop|status|restart` :

- chaque sous-commande affiche `[lab] <action>` ;
- `restart` enchaine `stop` puis `start` ;
- toute autre valeur affiche le bon usage sur **stderr** et sort avec **code 2**.

**Livrable** : le script + 5 tests (chaque sous-commande + une valeur invalide) avec `echo $?` apres chaque.

---

### Exercice 28 - Bash : audit complet
**D3 - 30 min**

Ecrire `~/linux-lab/bin/audit-home.sh [dossier]` qui produit un rapport horodate dans `~/linux-lab/notes/audit-<date>.md` avec :

1. utilisateur courant, hostname, date ;
2. distribution et noyau ;
3. espace disque du dossier cible ;
4. nombre de fichiers, taille totale ;
5. les 5 plus gros fichiers ;
6. archive `tar.gz` du dossier cible dans `~/linux-lab/backup/` ;
7. code retour `0` si tout va bien, autre sinon.

Le script doit utiliser : `set -euo pipefail`, des fonctions, un `main`, un `trap` pour nettoyer les fichiers temporaires.

**Livrable** : le script + le rapport produit + un test avec un dossier invalide (le script doit echouer proprement).

---

## Jour 3 - Diagnostic systeme et reseau

### Exercice 29 - Processus : trouver les gros mangeurs
**D2 - 10 min**

1. Lister tous les processus tries par **utilisation memoire** decroissante. Top 5.
2. Lister tous les processus tries par **utilisation CPU** decroissante. Top 5.
3. Trouver le PID du shell qui execute votre session courante.

Indices : `ps aux --sort=-%mem | head`, `echo $$`.

**Livrable** : 3 commandes + sorties dans `notes/processus.md`.

---

### Exercice 30 - Signaux et `kill`
**D2 - 10 min**

1. Demarrer `sleep 600 &` en arriere-plan. Noter le PID.
2. Lister les jobs (`jobs`).
3. Demander un arret **propre** avec `kill -TERM <pid>`. Verifier qu'il a disparu.
4. Relancer `sleep 600 &`. Cette fois, le tuer immediatement avec `kill -9 <pid>`.
5. Quelle difference entre `TERM` et `KILL` ? Quand prefere-t-on `TERM` ?

**Livrable** : sequence des commandes + reponse aux questions dans `notes/signaux.md`.

---

### Exercice 31 - Memoire : `free` vs `available`
**D1 - 5 min**

1. Lancer `free -h`.
2. Pour chaque colonne (`total`, `used`, `free`, `shared`, `buff/cache`, `available`), expliquer en une phrase ce qu'elle represente.
3. Pourquoi regarder `available` est plus pertinent que `free` ?

**Livrable** : `notes/memoire.md` avec les 6 explications + reponse a la question.

---

### Exercice 32 - Disque : qui mange l'espace ?
**D2 - 10 min**

1. Donner l'occupation de toutes les partitions montees.
2. Trouver les **5 dossiers les plus volumineux** dans `/var/log` (necessite probablement `sudo`).
3. Trouver le filesystem le plus rempli **en inodes** (et non en octets).

Indices : `df -h`, `du -sh /var/log/* | sort -h | tail`, `df -i`.

**Livrable** : 3 commandes + sorties dans `notes/disque.md`.

---

### Exercice 33 - `systemctl` : `start` vs `enable`
**D2 - 10 min**

Avec `ssh` (ou un autre service installe) :

1. Verifier son etat (`status`).
2. Le stopper.
3. Verifier qu'il ne tourne plus (`is-active`).
4. Le redemarrer.
5. Verifier qu'il est lance au boot (`is-enabled`).

Repondre par ecrit :

- quelle est la difference entre `start` et `enable` ?
- si la machine reboote, qu'est-ce qui change ?

**Livrable** : commandes + reponses dans `notes/systemctl.md`.

---

### Exercice 34 - `journalctl` : suivre un service
**D2 - 10 min**

1. Afficher les **30 dernieres lignes** des logs SSH.
2. Afficher uniquement les avertissements ou pire (`warning` et au-dela) **depuis le boot**.
3. Suivre les logs en direct (`-f`) puis dans un autre terminal, redemarrer SSH. Voir l'evenement.

**Livrable** : 3 commandes + capture de l'evenement de redemarrage dans `notes/journalctl.md`.

---

### Exercice 35 - Reseau : la methode IP/route/DNS/port
**D2 - 15 min**

Sans rien casser, repondre dans l'ordre :

1. Quelle est mon IP locale et mon masque ?
2. Quelle est ma route par defaut (passerelle) ?
3. Quel resolveur DNS est configure ?
4. Mon ping `1.1.1.1` passe-t-il ?
5. Mon ping `ubuntu.com` passe-t-il ?
6. Quels ports ecoutent localement ?

Si une etape echoue, **ne pas** sauter a la suivante : noter l'erreur.

**Livrable** : 6 commandes + 6 reponses dans `notes/reseau.md`.

---

### Exercice 36 - SSH : cle ed25519 et `copy-id`
**D2 - 15 min**

1. Verifier que le service SSH tourne.
2. Generer une paire de cles `ed25519` sans passphrase (lab uniquement).
3. Copier la cle publique vers un compte (autre VM, ou `localhost` en boucle si pas d'autre machine).
4. Se connecter sans mot de passe.
5. Verifier les permissions : `~/.ssh` doit etre `700`, `~/.ssh/authorized_keys` doit etre `600`.

**Livrable** : sequence des commandes + sortie de `ls -ld ~/.ssh ~/.ssh/authorized_keys` dans `notes/ssh.md`.

---

## Comment tester votre travail

A la fin de chaque jour :

```bash
ls ~/linux-lab/notes/
ls ~/linux-lab/bin/
find ~/linux-lab -maxdepth 3 -type f
```

Le formateur doit pouvoir :

- ouvrir vos `notes/*.md` et lire des phrases courtes, pas un dump brut ;
- lancer vos scripts depuis `~/linux-lab/bin/` ;
- relancer vos commandes a partir de vos notes.

Si une note dit "j'ai fait X" sans la commande, **ce n'est pas une preuve**.
