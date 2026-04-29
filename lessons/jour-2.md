<!-- class: hero -->
# Jour 2
Transformer le terminal en outil de production.

<div class="image-hero">
  <img src="https://upload.wikimedia.org/wikipedia/commons/8/82/Gnu-bash-logo.svg" alt="Logo GNU Bash" loading="lazy">
</div>

<div class="tag-row">
  <span class="tag">Pipes</span>
  <span class="tag">grep/find</span>
  <span class="tag">Permissions</span>
  <span class="tag">Archives</span>
  <span class="tag">Bash</span>
</div>

Note:
Objectif du jour : passer de "je sais lancer des commandes" a "je peux filtrer, sauvegarder, securiser et automatiser".

---

## Plan du jour

<div class="day-plan">
  <div class="plan-step">
    <span class="plan-num">01</span>
    <span class="plan-icon">[<<]</span>
    <div class="plan-time">35 min - matin</div>
    <h4>Kata J1</h4>
    <p>Verifier les acquis : navigation, fichiers, aide locale.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">02</span>
    <span class="plan-icon">[|]</span>
    <div class="plan-time">65 min - matin</div>
    <h4>Pipes et redirections</h4>
    <p>stdin/stdout/stderr, <code>></code>, <code>>></code>, <code>2></code>, <code>|</code>. Construire de gauche a droite.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">03</span>
    <span class="plan-icon">[/?]</span>
    <div class="plan-time">75 min - matin</div>
    <h4>grep, find, sed, awk</h4>
    <p>Filtrer, chercher, extraire, transformer. Cas reels sur logs et CSV.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">04</span>
    <span class="plan-icon">[gz]</span>
    <div class="plan-time">55 min - matin</div>
    <h4>Archives et restauration</h4>
    <p><code>tar</code>, gzip, verification, restauration testee.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">05</span>
    <span class="plan-icon">[rwx]</span>
    <div class="plan-time">85 min - apres-midi</div>
    <h4>Permissions et sudo</h4>
    <p>Lire <code>ls -l</code>, <code>chmod</code>, <code>chown</code>, sudo justifie, symlinks.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">06</span>
    <span class="plan-icon">[QoL]</span>
    <div class="plan-time">35 min - apres-midi</div>
    <h4>Quality of life</h4>
    <p>Historique, alias, <code>!!</code>, ctrl-r, <code>watch</code>, <code>tail -f</code>, jobs.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">07</span>
    <span class="plan-icon">[#!]</span>
    <div class="plan-time">120 min - apres-midi</div>
    <h4>Bash de A a Z</h4>
    <p>Bash c'est quoi, premier script, variables, conditions, exit, boucles, fonctions, robustesse, recettes.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">08</span>
    <span class="plan-icon">[v]</span>
    <div class="plan-time">30 min - cloture</div>
    <h4>Mini-lab + Q&amp;A</h4>
    <p>Script <code>audit-home.sh</code> + tour de questions.</p>
  </div>
</div>

Note:
Annoncer les timings. Aujourd'hui est dense : signaler que les commandes les plus utilisees sortiront en J3. Pas la peine de tout retenir aujourd'hui.

---

## Kata de reprise
<!-- exercise: ../exercises/03-text-pipelines.md -->

Sans regarder les notes :

1. Afficher l'utilisateur courant.
2. Aller dans `~/linux-lab`.
3. Creer `data/j2`.
4. Copier `/etc/passwd` dans `data/j2/passwd.copy`.
5. Afficher les 5 premieres lignes.
6. Trouver l'aide pour trier un fichier.

> Si une etape bloque, le probleme est soit le chemin, soit l'aide, soit la commande.

Note:
Ne pas corriger immediatement. Observer les reflexes : pwd, ls, man, lecture d'erreur.

---

## Philosophie Unix
<div class="three-cols">
  <div class="card accent">
    <h4>Petits outils</h4>
    <p>Chaque commande fait une chose raisonnablement bien.</p>
  </div>
  <div class="card blue">
    <h4>Texte</h4>
    <p>Les sorties sont lisibles, filtrables et combinables.</p>
  </div>
  <div class="card amber">
    <h4>Composition</h4>
    <p>Le shell relie les outils avec pipes et redirections.</p>
  </div>
</div>

```bash
cat fichier.log | grep ERROR | wc -l
```

Note:
Dire que la puissance vient moins de chaque commande que de leur composition.

---

## Standard input, output, error
<!-- exercise: ../exercises/03-text-pipelines.md -->

| Canal | Numero | Role |
| --- | --- | --- |
| stdin | 0 | Entree d'une commande |
| stdout | 1 | Sortie normale |
| stderr | 2 | Sortie d'erreur |

```bash
command > sortie.txt
command >> sortie.txt
command 2> erreurs.txt
command > sortie.txt 2> erreurs.txt
command < entree.txt
```

Note:
Faire provoquer une erreur avec `ls /root` sans sudo pour montrer stderr.

---

## Pipes : connecter les commandes
```bash
cat /etc/passwd | wc -l
cat /etc/passwd | cut -d: -f1 | sort
ip address | grep inet
journalctl -n 100 | grep -i error
```

- Le pipe `|` envoie la sortie standard d'une commande dans l'entree de la suivante.
- Chaque etape doit etre testee seule avant de construire la chaine complete.
- Le pipeline devient une phrase executable.

<div class="info-box">
  <strong>Methode</strong> : construire de gauche a droite, verifier a chaque pipe.
</div>

Note:
Faire afficher d'abord `cat /etc/passwd`, puis ajouter `cut`, puis `sort`.

---

<!-- class: demo -->
## DEMO - Construire un pipeline de gauche a droite

<span class="callout-badge demo">Demo formateur - 8 min</span>

Sur `web.log`, je construis pas a pas le **top des codes HTTP** :

```bash
cat ~/linux-lab/data/web.log               # 1. voir la donnee brute
cat ~/linux-lab/data/web.log | head        # 2. limiter
awk '{print $9}' web.log | head            # 3. extraire la colonne
awk '{print $9}' web.log | sort | head     # 4. trier
awk '{print $9}' web.log | sort | uniq -c  # 5. compter
... | sort -rn | head -n 5                 # 6. top 5
```

**Methode** : ne **jamais** ecrire le pipeline complet d'un coup. Verifier a chaque etape.

Note:
Demo lente. Faire taper les etudiants en parallele, attendre les retardataires. Verbaliser : "qu'est-ce que je veux verifier a cette etape ?". C'est l'enseignement principal de la journee.

---

## Rechercher du texte avec `grep`
<!-- exercise: ../exercises/03-text-pipelines.md -->

```bash
grep root /etc/passwd
grep -n root /etc/passwd
grep -i error /var/log/syslog
grep -r "PermitRootLogin" /etc/ssh
grep -E "bash|sh" /etc/passwd
```

- `-n` affiche le numero de ligne.
- `-i` ignore la casse.
- `-r` cherche recursivement.
- `-E` active les expressions regulieres etendues.

Note:
Si `/var/log/syslog` absent, utiliser les fichiers d'exemple ou `journalctl`.

---

## `grep` : les options qui changent la vie
<!-- exercise: ../exercises/03-text-pipelines.md -->

```bash
grep -v ":/usr/sbin/nologin" /etc/passwd
grep -c " 500 " web.log
grep -l "ERROR" *.log
grep -o "user[0-9]\+" web.log | sort -u
grep -B 2 -A 3 "ERROR" web.log
grep --color=auto -E "WARN|ERROR" web.log
```

| Option | Effet |
| --- | --- |
| `-v` | inverser : tout sauf ce qui matche |
| `-c` | compter les lignes qui matchent |
| `-l` | lister les fichiers qui matchent (sans le contenu) |
| `-o` | n'afficher que la portion qui matche |
| `-B N` / `-A N` / `-C N` | contexte avant/apres/autour |
| `--color=auto` | surligner sans casser un pipe |

> Reflexe : avant de scripter, demander si `grep -c`, `grep -l` ou `grep -v` ne suffit pas.

Note:
Faire essayer `grep -B 2 -A 3` sur `web.log` : le contexte change la lecture des incidents.

---

## Trouver des fichiers avec `find`
```bash
find ~/linux-lab -type f
find /etc -name "*.conf" 2>/dev/null
find ~/linux-lab -type f -size +1k
find ~/linux-lab -type f -mtime -1
find ~/linux-lab -type f -name "*.md" -exec wc -l {} \;
```

- `find` cherche dans l'arborescence.
- `grep` cherche dans le contenu.
- Les deux sont souvent combines.

```bash
find /etc -type f -name "*.conf" 2>/dev/null | xargs grep -n "ssh"
```

Note:
Expliquer `2>/dev/null` uniquement comme redirection des erreurs non utiles ici, pas comme reflexe systematique.

---

## `sort`, `uniq`, `wc` : compter et trier
<!-- exercise: ../exercises/03-text-pipelines.md -->

```bash
sort fichier.txt
sort -n nombres.txt
sort -r fichier.txt
sort -u fichier.txt
sort -k2,2 inventory.csv -t,
sort fichier.txt | uniq
sort fichier.txt | uniq -c | sort -rn
wc -l web.log
wc -w README.md
```

- `sort -n` : tri numerique (sinon `10` < `2`).
- `sort -u` : equivaut a `sort | uniq`.
- `uniq` ne deduplique que des **lignes adjacentes**. Toujours `sort` avant.
- `uniq -c` : compte les occurrences. Combo classique : `sort | uniq -c | sort -rn`.

> Pipeline canonique : "qui apparait le plus ?" -> `cut ... | sort | uniq -c | sort -rn | head`.

Note:
Le pipeline `sort | uniq -c | sort -rn | head` est un classique : top des erreurs, top des IP, top des extensions.

---

<!-- class: exercice -->
## EXERCICE - Top 5 des codes HTTP
<!-- exercise: ../exercises/cahier-exercices.md -->

<span class="callout-badge exercice">Cahier - exercice 10 - 10 min</span>

Construire **une seule** pipeline qui produit :

```
    42 200
    7 404
    3 500
```

(occurrences puis code HTTP, du plus frequent au moins frequent).

**Methode** : commencez par voir la donnee, puis extrayez la colonne, puis comptez.

**Bonus** : Top 3 des IP présent dans le fichier

Note:
Si quelqu'un fait `uniq` sans `sort` avant, c'est l'occasion d'enseigner. Faire pratiquer le pipeline canonique `sort | uniq -c | sort -rn`.

---

## Decouper et reassembler : `cut`, `tr`, `paste`, `column`

```bash
cut -d, -f1,3 inventory.csv
cut -c1-10 web.log
echo "PASSWD" | tr 'A-Z' 'a-z'
tr -s ' ' < web.log | head
tr -d '\r' < windows.txt > unix.txt
paste -d, fichier1.txt fichier2.txt
ls -l | column -t
```

| Outil | Usage typique |
| --- | --- |
| `cut` | extraire des colonnes par delimiteur ou caracteres |
| `tr` | substituer/supprimer des caracteres (jamais des mots) |
| `paste` | coller des fichiers ligne par ligne |
| `column -t` | aligner une sortie en colonnes lisibles |

Note:
Insister : `tr` est par caractere, `sed` est par motif. Beaucoup d'etudiants confondent.

---

## Modifier le flux : `sed` et `awk` express
<!-- exercise: ../exercises/03-text-pipelines.md -->

```bash
sed 's/ERROR/!!ERROR!!/g' web.log
sed -n '10,20p' web.log
sed -i.bak 's/foo/bar/g' config.ini

awk '{print $1, $9}' web.log
awk -F, '$3 == "ubuntu" {print $1}' inventory.csv
awk '{count[$9]++} END {for (k in count) print count[k], k}' web.log | sort -rn
```

- `sed s/ancien/nouveau/g` : substitue, le `g` rend global.
- `sed -n 'A,Bp'` : afficher seulement les lignes A a B.
- `sed -i` : modifie le fichier en place. **Toujours `-i.bak`** pour garder une copie.
- `awk` : decoupage automatique en champs (`$1`, `$2`, ..., `$NF`).

<div class="info-box warning">
  Sur macOS BSD, `sed -i` exige une chaine apres `-i`. Sur Linux GNU, `-i` seul fonctionne. La forme `sed -i.bak` marche partout.
</div>

Note:
Pas un cours sur awk. Donner deux patterns : compter et filtrer par champ.

---

## `tee`, `xargs`, redirections avancees

```bash
date | tee rapport.txt
sudo apt update | tee -a install.log
ls *.bak | xargs rm
find . -name "*.tmp" -print0 | xargs -0 rm
echo "a b c" | xargs -n 1 echo "->"
ls > liste.txt 2> erreurs.txt
ls > tout.txt 2>&1
ls &> tout.txt
diff <(sort a.txt) <(sort b.txt)
```

- `tee` : ecrire en meme temps a l'ecran et dans un fichier (`-a` pour ajouter).
- `xargs` : prend l'entree standard et la passe en arguments. `-0` avec `find -print0` pour gerer les espaces.
- `2>&1` : rediriger stderr vers stdout.
- `<(commande)` : "process substitution", utile pour `diff`.

Note:
Faire taper `ls *.bak | xargs rm -i` : le `-i` demande confirmation, securite quand on apprend.

---

## Donnees d'exemple : logs et CSV
<!-- exercise: ../exercises/03-text-pipelines.md -->

```bash
cp examples/jour-2/web.log ~/linux-lab/data/
cp examples/jour-2/inventory.csv ~/linux-lab/data/

grep " 500 " ~/linux-lab/data/web.log
cut -d, -f2 ~/linux-lab/data/inventory.csv
sort ~/linux-lab/data/inventory.csv
wc -l ~/linux-lab/data/web.log
```

> Objectif : apprendre sur des fichiers non critiques avant de manipuler `/etc` ou `/var/log`.

Note:
Ces fichiers sont dans le repo du cours. Si le cours est servi depuis un dossier different, montrer ou les copier.

---

## Archives et sauvegardes
<!-- exercise: ../exercises/04-archives-backup.md -->

```bash
tar -czf linux-lab-backup.tar.gz ~/linux-lab
tar -tzf linux-lab-backup.tar.gz | head
mkdir -p ~/restore-test
tar -xzf linux-lab-backup.tar.gz -C ~/restore-test
```

- `c` cree une archive.
- `t` liste une archive.
- `x` extrait une archive.
- `z` compresse avec gzip.
- `f` indique le fichier archive.

<div class="info-box warning">
  Une sauvegarde non testee est une hypothese, pas une sauvegarde.
</div>

Note:
Insister sur la restauration. Beaucoup de formations s'arretent a la creation de l'archive.

---

## Utilisateurs et groupes
<!-- exercise: ../exercises/05-users-permissions.md -->

```bash
id
whoami
groups
getent passwd "$USER"
getent group sudo
```

- Un processus tourne avec un utilisateur et des groupes.
- Les permissions sont evaluees par rapport a cet utilisateur.
- `sudo` execute une commande avec des privileges eleves si l'utilisateur y est autorise.

> Question : pourquoi `sudo` doit etre justifie, pas automatique ?

Note:
Ne pas faire creer trop d'utilisateurs si le temps manque. L'objectif est le modele mental.

---

## Permissions : lire `ls -l`
```bash
ls -l ~/linux-lab
```

```text
-rw-r--r-- 1 sean students 1200 Apr 28 10:00 notes.md
drwxr-x--- 2 sean students 4096 Apr 28 10:05 backup
```

| Segment | Sens |
| --- | --- |
| `-` ou `d` | fichier ou dossier |
| `rwx` | droits proprietaire |
| `r-x` | droits groupe |
| `---` | droits autres |
| `sean students` | owner et groupe |

Note:
Faire lire plusieurs lignes. Difference fichier/dossier : `x` sur dossier permet de traverser.

---

<!-- class: exercice -->
## EXERCICE - Permissions : refuser le 777
<!-- exercise: ../exercises/cahier-exercices.md -->

<span class="callout-badge exercice">Cahier - exercice 20 - 10 min</span>

Dans `~/linux-lab/permissions/` :

1. Creer `public.txt`, `secret.txt`, `script.sh`.
2. `script.sh` : executable, lisible par tous, modifiable par owner.
3. `secret.txt` en `600`.
4. `public.txt` en `644`.
5. Lancer le script.

**Question** : pourquoi `chmod 777` n'est **pas** la bonne reponse a "ca ne marche pas" ?

**Livrable** : `notes/permissions.md` avec un tableau (fichier, droit, justification) + reponse argumentee.

Note:
Cet exercice est l'occasion d'expliquer que `chmod 777` masque la cause. Faire ecrire la reponse, pas seulement la dire.

---

## `chmod`, `chown`, `umask`
<!-- exercise: ../exercises/05-users-permissions.md -->

```bash
chmod 600 secrets.txt
chmod 755 script.sh
chmod u+x script.sh
sudo chown root:root fichier
umask
```

- `600` : seul le proprietaire lit/ecrit.
- `644` : fichier lisible par tous, modifiable par owner.
- `755` : executable par tous, modifiable par owner.
- `umask` influence les permissions par defaut.

<div class="info-box danger">
  <strong>Anti-pattern</strong> : `chmod 777` pour "faire marcher". C'est presque toujours un contournement dangereux.
</div>

Note:
Montrer pourquoi `chmod +x` est necessaire pour executer un script.

---

## Liens symboliques
```bash
ln -s ~/linux-lab/notes/system-notes.md ~/system-notes-link.md
ls -l ~/system-notes-link.md
readlink ~/system-notes-link.md
```

- Un lien symbolique est un raccourci vers un chemin.
- Il peut pointer vers un fichier ou un dossier.
- S'il pointe vers une cible supprimee, il devient casse.

> Utile pour configurations, versions, chemins pratiques et compatibilite.

Note:
Ne pas approfondir hard links sauf question. Le symlink suffit pour les fondamentaux.

---

## Quality of life : le terminal qui ne fatigue pas

```bash
history | tail -n 20
!!                       # rejouer la derniere commande
!sudo                    # rejouer la derniere commande commencant par sudo
sudo !!                  # relancer la derniere avec sudo
ls -la !$                # !$ = dernier argument de la commande precedente
ctrl-r                   # recherche incrementale dans l'historique
ctrl-a / ctrl-e          # debut / fin de ligne
ctrl-w / ctrl-u          # supprimer mot precedent / toute la ligne
alt-. (ou esc-.)         # inserer le dernier argument
```

```bash
alias ll='ls -lah'
alias gs='git status'
alias ..='cd ..'
type ll
which python3
file ~/linux-lab/data/web.log
stat ~/linux-lab/notes/system-notes.md
```

> Mettre les alias dans `~/.bashrc` pour les garder. Verifier avec `type` ce qui est resolu.

Note:
Faire vivre 5 minutes : taper sans la souris, naviguer historique, alias deux commandes du jour.

---

## Voir, suivre, attendre : `less`, `watch`, `tail -f`

```bash
less /var/log/dpkg.log
# / pour chercher, n pour suivant, q pour quitter

tail -f /var/log/syslog
tail -f /var/log/syslog | grep -i error

watch -n 2 'df -h /'
watch -d 'ss -tulpn'

time find / -name "passwd" 2>/dev/null
```

- `less` : lecteur paginant. Cherche avec `/`, navigue avec espace/`b`, quitte avec `q`.
- `tail -f` : suit un fichier qui grossit (logs en direct).
- `watch -n N` : execute une commande toutes les N secondes. `-d` surligne les changements.
- `time` : mesure la duree d'une commande.

Note:
Faire suivre `journalctl -f` puis lancer une connexion SSH dans un autre terminal.

---

## Jobs et plan B : controler ce qui tourne

```bash
sleep 60 &
jobs
fg %1
ctrl-z              # suspend le job courant
bg %1               # reprend en tache de fond
disown -h %1        # detache du shell
nohup ./long.sh > out.log 2>&1 &
kill %1             # tue le job %1
```

| Geste | Resultat |
| --- | --- |
| `&` en fin de commande | demarrage en arriere-plan |
| `ctrl-z` | suspend la commande en avant-plan |
| `jobs` | liste des jobs du shell courant |
| `fg` / `bg` | repasser en avant / arriere-plan |
| `nohup` | survit a la fermeture du terminal |

> Avant `screen` ou `tmux` : ces gestes suffisent pour 80% des besoins quotidiens.

Note:
Faire vivre la sequence : sleep, ctrl-z, bg, jobs, fg, kill. C'est le geste le plus oublie.

---

## Bash, c'est quoi ?

<div class="image-hero">
  <img src="https://upload.wikimedia.org/wikipedia/commons/8/82/Gnu-bash-logo.svg" alt="Logo GNU Bash" loading="lazy">
</div>

**Bash** = **B**ourne **A**gain **SH**ell. Le shell par defaut sur Ubuntu et la plupart des distributions Linux.

<div class="three-cols">
  <div class="card accent">
    <h4>Un programme</h4>
    <p>Bash est un binaire (<code>/bin/bash</code>) lance a l'ouverture d'un terminal. Il lit votre saisie, l'interprete, lance d'autres programmes.</p>
  </div>
  <div class="card blue">
    <h4>Un langage</h4>
    <p>Variables, conditions, boucles, fonctions : Bash est aussi un vrai langage de programmation, fait pour automatiser des taches systeme.</p>
  </div>
  <div class="card amber">
    <h4>Un standard</h4>
    <p>Cree en 1989 par Brian Fox (FSF/GNU), successeur libre du Bourne Shell de 1977. Present partout en serveur.</p>
  </div>
</div>

Note:
A l'oral : "shell" veut dire "coquille" - c'est l'enveloppe utilisateur autour du noyau. Bash est l'un des nombreux shells. Sa force : la compatibilite et l'omnipresence. Toutes les pipes, redirections et grep qu'on vient de voir : c'est deja Bash en mode interactif. Maintenant on va l'ecrire dans un fichier.

---

## Bash vs les autres shells

| Shell | Origine | Pour quoi ? |
| --- | --- | --- |
| `sh` (Bourne) | 1977, AT&T | Standard POSIX. Compatibilite maximale, syntaxe minimale. |
| `bash` | 1989, GNU | Defaut Linux. Compatible `sh` + extensions. **Notre cible.** |
| `dash` | 2002, Debian | Mini shell rapide. `/bin/sh` sur Ubuntu pointe vers `dash`. |
| `zsh` | 1990 | Defaut macOS. Plus permissif, plein de fonctionnalites desktop. |
| `fish` | 2005 | Tout-en-un user-friendly. Pas compatible Bash : scripts a reecrire. |

```bash
echo $SHELL          # /bin/bash : votre shell de connexion
cat /etc/shells      # liste des shells installes
chsh -s /bin/zsh     # changer son shell par defaut
```

Note:
Pas un debat religieux. Bash est le standard pour les scripts d'admin Linux. Pour un script Bash, on ecrit toujours `#!/usr/bin/env bash` - sur d'autres machines avec d'autres shells par defaut, le script tournera quand meme.

---

## Votre premier script Bash
<!-- exercise: ../exercises/06-bash-script-audit.md -->

```bash
#!/usr/bin/env bash
set -u

target="${1:-$HOME}"

if [ ! -d "$target" ]; then
  echo "Erreur: dossier introuvable: $target" >&2
  exit 1
fi

echo "Audit de $target"
find "$target" -maxdepth 1 -type f | wc -l
```

- **Shebang** `#!/usr/bin/env bash` : indique l'interpreteur.
- **Variables** : toujours entre guillemets `"$var"`.
- **Code retour** : `0` succes, autre valeur erreur.
- **stderr** (`>&2`) pour les messages d'erreur.

Note:
Premier contact avec un script ecrit dans un fichier. Faire executer `chmod +x` et lancer. Verbaliser que c'est juste les commandes deja vues, sauvees dans un fichier.

---

## Bash : variables, quoting, expansion
<!-- exercise: ../exercises/06-bash-script-audit.md -->

```bash
nom="Linux"
chemin="$HOME/linux-lab"

echo "Hello $nom"
echo 'Hello $nom'                  # litteral, pas d'interpolation
echo "Chemin = ${chemin}"

# Valeur par defaut si non definie
target="${1:-$HOME}"

# Substitution de commande
date_iso="$(date -Iseconds)"
nb_files=$(find "$chemin" -type f | wc -l)

# Arithmetique
total=$((10 + 5 * 2))
```

| Forme | Comportement |
| --- | --- |
| `"$var"` | interpolation, espaces preserves |
| `'$var'` | litteral, pas d'interpolation |
| `${var:-defaut}` | utiliser `defaut` si vide |
| `$(commande)` | sortie de la commande |
| `$((expr))` | calcul arithmetique |

<div class="info-box warning">
  <strong>Toujours guillemeter</strong> : `"$var"`, `"$@"`, `"$1"`. Sans guillemets, un nom de fichier avec espace casse tout.
</div>

Note:
L'erreur n. 1 des debutants : oublier les guillemets. La montrer en direct avec un nom de fichier contenant un espace.

---

## Bash : tests et conditions

```bash
if [ -d "$dir" ]; then
  echo "$dir existe"
elif [ -f "$dir" ]; then
  echo "$dir est un fichier"
else
  echo "$dir absent" >&2
  exit 1
fi

# [[ ... ]] : forme Bash, plus permissive
if [[ "$file" == *.log ]]; then
  echo "fichier log"
fi
```

| Test | Vrai si... |
| --- | --- |
| `-e f` / `-f f` / `-d f` | existe / fichier / dossier |
| `-r f` / `-w f` / `-x f` | lisible / ecrit / executable |
| `-z s` / `-n s` | chaine vide / non vide |
| `s1 = s2` / `s1 != s2` | egalite chaines |
| `n1 -eq n2`, `-lt`, `-gt` | tests numeriques |

Note:
Preferer `[[ ]]` en Bash. Garder `[ ]` si le script doit tourner avec `/bin/sh`. Faire taper un test simple avant d'enchainer sur les boucles.

---

## Exit status : le code qui ne ment pas

```bash
ls ~/linux-lab
echo $?

ls /dossier/inexistant
echo $?
```

- Le shell garde le code retour de la derniere commande dans `$?`.
- Convention : `0` = succes, **autre** = erreur.
- Un script doit sortir en erreur (`exit 1`) si la condition attendue n'est pas vraie.
- Les pipelines cachent parfois l'erreur du milieu - on resoudra avec `set -o pipefail`.

```bash
set -euo pipefail
```

Note:
Premiere notion d'`exit`. Preview `set -euo pipefail` sans rentrer dans le detail - on revient dessus dans la slide robustesse.

---

<!-- class: exercice -->
## EXERCICE - Bash : Hello arg
<!-- exercise: ../exercises/cahier-exercices.md -->

<span class="callout-badge exercice">Cahier - exercice 22 - 5 min</span>

Ecrire `~/linux-lab/bin/hello.sh` :

- accepte un argument **prenom** ;
- si pas d'argument, salue `Inconnu` ;
- imprime `Bonjour, <prenom> !`.

```
$ hello.sh
Bonjour, Inconnu !
$ hello.sh Sarah
Bonjour, Sarah !
```

**Pieges classiques** : oublier le shebang, oublier `chmod +x`, oublier les guillemets autour de `"$1"`.

Note:
Premier script qu'ils ecrivent vraiment. Faire passer 5 min. Aider sur shebang/chmod, pas sur la logique.

---

## Bash : boucles for, while, case

```bash
for f in *.log; do
  echo ">> $f"
  wc -l "$f"
done

for i in {1..5}; do
  echo "Tour $i"
done

# Lire un fichier ligne par ligne
while IFS= read -r line; do
  echo "ligne: $line"
done < fichier.txt

# Boucle infinie controlee
count=0
while [ "$count" -lt 3 ]; do
  echo "$count"
  count=$((count + 1))
done

case "$1" in
  start) echo "demarrage" ;;
  stop)  echo "arret" ;;
  status) echo "etat" ;;
  *) echo "usage: $0 {start|stop|status}" >&2; exit 2 ;;
esac
```

<div class="info-box">
  Pour parcourir une sortie de commande, preferer une <strong>boucle while read</strong> a `for x in $(...)` qui casse sur les espaces.
</div>

Note:
Anti-pattern celebre : `for f in $(ls)`. Montrer pourquoi `for f in *` est meilleur, et `while read` mieux encore.

---

## Bash : fonctions et code structure

```bash
#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '[%s] %s\n' "$(date +%H:%M:%S)" "$*" >&2
}

require_dir() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    log "Erreur: $dir introuvable"
    return 1
  fi
}

audit() {
  local target="$1"
  log "Audit de $target"
  find "$target" -maxdepth 1 -type f | wc -l
}

main() {
  local target="${1:-$HOME}"
  require_dir "$target" || exit 1
  audit "$target"
}

main "$@"
```

- `local` : variable limitee a la fonction.
- `"$@"` (avec guillemets) : tous les arguments preserves.
- Une fonction retourne via `return N` ou via la valeur de la derniere commande.
- Convention : un `main` appele en bas avec `"$@"` rend le script lisible.

Note:
Insister sur `local` et sur le pattern `main "$@"`. Code lisible = code maintenable.

---

## Bash : robustesse (`set`, `trap`, `getopts`)

```bash
#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

cleanup() {
  rm -rf "$tmpdir"
}
trap cleanup EXIT
trap 'echo "Interrompu"; exit 130' INT TERM

tmpdir=$(mktemp -d)

while getopts "v:f:h" opt; do
  case "$opt" in
    v) verbose="$OPTARG" ;;
    f) file="$OPTARG" ;;
    h) echo "usage: $0 [-v level] [-f file]"; exit 0 ;;
    *) exit 2 ;;
  esac
done
```

| Drapeau `set` | Effet |
| --- | --- |
| `-e` | sortir des qu'une commande echoue |
| `-u` | erreur si variable non definie |
| `-o pipefail` | un pipe echoue si l'une des commandes echoue |
| `-E` | les fonctions heritent du `trap ERR` |
| `-x` | mode debug : afficher chaque commande |

> `mktemp -d` + `trap cleanup EXIT` : pattern de base pour ne pas laisser de fichiers temporaires.

Note:
`set -euo pipefail` n'est pas magique : il revele les bugs caches mais peut casser des scripts bavards. Le presenter comme defaut "production".

---

<!-- class: demo -->
## DEMO - Bash : casser un script avec des espaces

<span class="callout-badge demo">Demo formateur - 5 min</span>

Je projette un script pige :

```bash
#!/usr/bin/env bash
target=$1                          # pas de guillemets
for f in $(find $target -type f); do
  echo "Traite $f"
done
```

Je le lance contre un dossier qui contient `"rapport final.txt"`. Le script casse.

Puis on **corrige en direct** :

```bash
target="$1"
find "$target" -type f -print0 | while IFS= read -r -d '' f; do
  echo "Traite : $f"
done
```

> La difference entre script de TP et script de prod : 4 paires de guillemets et `-print0`.

Note:
La meilleure facon d'ancrer "toujours guillemeter" : faire vivre le bug. Garder cet exemple en tete - c'est le 80/20 du Bash robuste.

---

## Bash : recettes utiles

```bash
# Iterer sur les fichiers en gerant les espaces
find . -type f -name "*.log" -print0 | while IFS= read -r -d '' f; do
  echo "Traite : $f"
done

# Quitter proprement avec un message
die() { echo "ERREUR: $*" >&2; exit 1; }
[ -d "$1" ] || die "$1 n'existe pas"

# Confirmer avant action destructive
read -r -p "Supprimer $target ? [y/N] " ans
[[ "$ans" =~ ^[yY]$ ]] || exit 0
rm -rf -- "$target"

# Tableaux et boucles indexees
fichiers=("a.txt" "b.txt" "c.txt")
for f in "${fichiers[@]}"; do
  echo "$f"
done

# Heredoc pour generer un fichier de config
cat > /tmp/conf.ini <<'EOF'
[server]
port = 8080
EOF
```

- `die` : helper d'erreur reutilise dans presque tous les scripts pros.
- `find -print0` + `while read -d ''` : la seule maniere fiable de gerer tous les noms de fichiers.
- Heredoc avec `<<'EOF'` (quote) : pas d'interpolation. `<<EOF` non quote : interpolation.

Note:
Donner le snippet `die` aux etudiants. C'est un rituel a installer.

---

<!-- class: exercice -->
## EXERCICE - Bash : log-summary
<!-- exercise: ../exercises/cahier-exercices.md -->

<span class="callout-badge exercice">Cahier - exercice 25 - 10 min</span>

Ecrire `~/linux-lab/bin/log-summary.sh <dossier>` :

- boucler sur tous les fichiers `.log` du dossier ;
- pour chacun, afficher nom, nombre de lignes, nombre d'erreurs.

Format attendu :

```
== access.log ==
lignes : 1024
erreurs: 12
```

**Pieges** : si pas de `.log` dans le dossier, le glob doit "disparaitre" (`shopt -s nullglob`). Si `grep -c` retourne 0 erreurs, le code retour est 1 -> `set -e` tue le script. Solution : `|| true`.

Note:
Excellent terrain pour montrer 2 pieges Bash classiques d'un coup. Si quelqu'un est bloque, demander : "que fait ton glob si le dossier est vide ?"

---

## Mini-lab J2 : audit automatise
<!-- exercise: ../exercises/06-bash-script-audit.md -->

Construire `audit-home.sh`.

Le script doit produire :

- utilisateur courant ;
- hostname ;
- date ;
- espace disque ;
- RAM disponible ;
- nombre de fichiers dans un dossier cible ;
- archive `tar.gz` du dossier cible ;
- code retour clair si le dossier n'existe pas.

Note:
Faire travailler en binomes. Interdire les scripts qui ne font que copier les commandes sans structure.

---

<!-- class: qna -->
## Avez-vous des questions ?

<div class="qna-mark">?</div>

Note:
Fin de J2 - 10 min. A ce stade certains sont satures. Tour de table court : "une chose claire, une chose floue". Mettre les confusions sur tableau pour reprise demain matin. Themes a relancer : pipes, grep, find, sed/awk, permissions, Bash avance.

---

<!-- class: hero -->
## Recap J2
- Les pipes composent des commandes simples.
- `grep` cherche dans le contenu, `find` cherche dans les chemins.
- Une sauvegarde se teste par restauration.
- Les permissions repondent a trois questions : qui ? quoi ? sur quel fichier ?
- `sudo` doit etre justifie.
- Un script Bash utile gere arguments, erreurs et codes retour.

> Demain : processus, memoire, services, logs, reseau et SSH.

Note:
Exit ticket : demander une pipeline utile, une permission expliquee et une erreur Bash rencontree.
