<!-- class: hero -->
# Jour 3
Comprendre le systeme, la memoire, les services et diagnostiquer.

<div class="image-grid">
  <figure>
    <img src="https://upload.wikimedia.org/wikipedia/commons/3/35/Tux.svg" alt="Tux" loading="lazy">
    <figcaption>kernel</figcaption>
  </figure>
  <figure>
    <img src="https://upload.wikimedia.org/wikipedia/commons/8/82/Gnu-bash-logo.svg" alt="Bash" loading="lazy">
    <figcaption>shell</figcaption>
  </figure>
  <figure>
    <img src="https://upload.wikimedia.org/wikipedia/commons/a/ab/Logo-ubuntu_cof-orange-hex.svg" alt="Ubuntu" loading="lazy">
    <figcaption>distribution</figcaption>
  </figure>
</div>

<div class="tag-row">
  <span class="tag">Processus</span>
  <span class="tag">Memoire</span>
  <span class="tag">systemd</span>
  <span class="tag">Logs</span>
  <span class="tag">Reseau</span>
  <span class="tag">SSH</span>
</div>

Note:
Objectif : relier les commandes apprises au fonctionnement interne d'un serveur Linux. Le diagnostic doit devenir methodique.

---

## Plan du jour

<div class="day-plan">
  <div class="plan-step">
    <span class="plan-num">01</span>
    <span class="plan-icon">[<<]</span>
    <div class="plan-time">25 min - matin</div>
    <h4>Reprise + questions</h4>
    <p>Rejouer les gestes clefs J1-J2. Repondre aux flous.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">02</span>
    <span class="plan-icon">[.*]</span>
    <div class="plan-time">35 min - matin</div>
    <h4>Regex</h4>
    <p>Briques, quantifieurs, BRE/ERE. Usage en <code>grep</code>, <code>sed</code>, <code>awk</code>, bash <code>[[ =~ ]]</code>.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">03</span>
    <span class="plan-icon">[ps]</span>
    <div class="plan-time">70 min - matin</div>
    <h4>Processus et memoire</h4>
    <p>Scheduler, page cache, swap, OOM. <code>ps</code>, <code>top</code>, <code>free</code>, signaux.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">04</span>
    <span class="plan-icon">[apt]</span>
    <div class="plan-time">55 min - matin</div>
    <h4>Paquets</h4>
    <p><code>apt update/install/remove</code>, depots, comparaison <code>dnf</code>.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">05</span>
    <span class="plan-icon">[ctl]</span>
    <div class="plan-time">75 min - apres-midi</div>
    <h4>systemd et logs</h4>
    <p><code>systemctl</code>, <code>journalctl</code>, <code>start</code> vs <code>enable</code>, diagnostic.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">06</span>
    <span class="plan-icon">[net]</span>
    <div class="plan-time">75 min - apres-midi</div>
    <h4>Reseau</h4>
    <p>IP, route, DNS, port. Methode incident en 6 questions.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">07</span>
    <span class="plan-icon">[ssh]</span>
    <div class="plan-time">55 min - apres-midi</div>
    <h4>SSH</h4>
    <p>Cles ed25519, <code>ssh-copy-id</code>, permissions, durcissement minimal.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">08</span>
    <span class="plan-icon">[v]</span>
    <div class="plan-time">60 min - cloture</div>
    <h4>Projet final + Q&amp;A</h4>
    <p>VM diagnostiquable + demo de 3 minutes par binome.</p>
  </div>
</div>

Note:
Journee de synthese. Les exercices se rapprochent du projet final. Annoncer la demo de 3 min en cloture pour qu'ils s'y preparent.

---

## Reprise : verifier une machine
<!-- exercise: ../exercises/07-process-services-logs.md -->

```bash
hostname
uptime
whoami
ip address
df -h
free -h
systemctl --failed
journalctl -p warning -n 20
```

> En 2 minutes, vous devez savoir : qui je suis, ou je suis, si le disque va bien, si la RAM va bien, si des services sont casses.

Note:
Chronometrer. C'est le rituel de diagnostic de debut de session.

---

## Regex : la grammaire des motifs

Une **expression reguliere** decrit un **motif** plutot qu'une chaine fixe.

```bash
grep "error" app.log              # cherche le mot "error"
grep -E "error|warn|fatal" app.log # un mot OU un autre
grep -E "^[0-9]{4}-[0-9]{2}" app.log # lignes qui commencent par une date
```

<div class="three-cols">
  <div class="card accent">
    <h4>Filtrer</h4>
    <p>Garder ou rejeter des lignes (<code>grep</code>, <code>awk</code>).</p>
  </div>
  <div class="card blue">
    <h4>Extraire</h4>
    <p>Capturer des champs (<code>grep -o</code>, <code>sed</code>, <code>awk</code>).</p>
  </div>
  <div class="card amber">
    <h4>Transformer</h4>
    <p>Substituer ligne par ligne (<code>sed s/.../.../</code>).</p>
  </div>
</div>

> Une regex est un **mini-langage**. On l'apprend brique par brique, on la teste etape par etape.

Note:
Annoncer le plan : briques, quantifieurs, dialectes BRE/ERE, puis utilisation reelle. Insister : la regex se construit incrementalement, jamais d'un coup.

---

## Briques de base : caracteres, classes, ancrages

```bash
echo "ssh started on port 22" | grep -E "ssh"        # litteral
echo "ssh started on port 22" | grep -E "s.h"        # . = un caractere
echo "user42" | grep -E "[a-z]+[0-9]+"               # classe + chiffres
echo "abc 123" | grep -Eo "[^ ]+"                    # tout sauf espace
echo "hello world" | grep -E "^hello"                # debut de ligne
echo "hello world" | grep -E "world$"                # fin de ligne
```

| Brique | Sens |
| --- | --- |
| `.` | n'importe quel caractere (sauf saut de ligne) |
| `[abc]` | un caractere parmi `a`, `b` ou `c` |
| `[a-z]` / `[0-9]` | une plage |
| `[^abc]` | tout caractere SAUF `a`, `b`, `c` |
| `\d` `\w` `\s` | chiffre / mot / espace (PCRE, **pas** BRE/ERE) |
| `^` / `$` | debut / fin de ligne |
| `\b` | frontiere de mot (GNU grep) |

<div class="info-box warning">
  En <code>grep</code> de base et <code>sed</code>, <code>\d</code> n'existe pas. Utiliser <code>[0-9]</code>. Idem pour <code>\w</code> -&gt; <code>[A-Za-z0-9_]</code>.
</div>

Note:
Faire taper chaque ligne. Bien insister sur la difference entre `[abc]` (un seul caractere) et `abc` (trois caracteres a la suite).

---

## Quantifieurs et alternatives

```bash
echo "aaab" | grep -Eo "a+"             # 1 ou plus
echo "color colour" | grep -Eo "colou?r" # ? = 0 ou 1
echo "ab abc abcc" | grep -Eo "abc*"     # * = 0 ou plus
echo "ip 10.0.0.1" | grep -Eo "[0-9]{1,3}(\.[0-9]{1,3}){3}"
echo "INFO ou ERROR" | grep -E "INFO|ERROR"  # alternative
echo "bonjour01" | grep -Eo "(jour)[0-9]+"   # groupe + capture
```

| Quantifieur | Effet |
| --- | --- |
| `*` | 0 ou plus |
| `+` | 1 ou plus (ERE) |
| `?` | 0 ou 1 (ERE) |
| `{n}` | exactement n |
| `{n,m}` | entre n et m |
| `(motif)` | groupe |
| <code>a&#124;b</code> | a OU b (ERE) |

<div class="info-box">
  Une regex est <strong>gourmande</strong> par defaut : elle prend le plus long match possible. Pour limiter, on ancre avec <code>^</code> / <code>$</code> ou on utilise des classes plus strictes.
</div>

Note:
Le piege classique : `.*` mange tout. Exemple : `grep -Eo "<.*>"` sur `<a><b>` matche `<a><b>` au lieu de `<a>`. Lui preferer `<[^>]*>`.

---

## BRE vs ERE : savoir quand echapper

Les outils Unix connaissent **deux dialectes** :

| Outil | Defaut | ERE active avec |
| --- | --- | --- |
| `grep` | BRE | `-E` (ou `egrep`) |
| `sed` | BRE | `-E` (ou `-r`) |
| `awk` | ERE | (toujours) |
| Bash `[[ =~ ]]` | ERE | (toujours) |

```bash
grep    "ab\+"   fichier   # BRE : + litteral, sauf si \+
grep -E "ab+"    fichier   # ERE : + quantifieur
sed     's/ab\+/X/'        # BRE
sed -E  's/ab+/X/'         # ERE, plus lisible
```

<div class="info-box danger">
  Regle de survie : <strong>toujours <code>-E</code> avec grep et sed</strong> sauf raison precise. Les regex deviennent lisibles au lieu d'etre une foret de <code>\</code>.
</div>

```bash
# BRE (penible)
grep    "^[A-Z]\{3\}-[0-9]\{4\}$" tickets.txt
# ERE (lisible)
grep -E "^[A-Z]{3}-[0-9]{4}$"     tickets.txt
```

Note:
Faire taper les deux versions cote a cote. Le declic est : "ah, le `\` change de signification selon le dialecte".

---

## Regex en pratique : bash, sed, awk

**Tester une chaine en bash avec `[[ =~ ]]`**

```bash
read -r -p "Email ? " e
if [[ "$e" =~ ^[a-z0-9._-]+@[a-z0-9.-]+\.[a-z]{2,}$ ]]; then
  echo "ok"
else
  echo "format invalide" >&2
fi
```

**Substituer avec `sed`**

```bash
sed -E 's/[0-9]{4}-[0-9]{2}-[0-9]{2}/<DATE>/g' app.log
sed -E 's/^([A-Z]+):/[\1]/' app.log     # \1 = 1er groupe capture
```

**Filtrer / extraire avec `awk`**

```bash
awk '/^ERROR/ {print}' app.log                      # lignes ERROR
awk '$1 ~ /^192\.168\./ {print $7}' web.log         # IP interne
awk 'match($0, /[0-9]{2}:[0-9]{2}:[0-9]{2}/) {print substr($0, RSTART, RLENGTH)}' app.log
```

<div class="info-box">
  Bash <code>=~</code> ne demande <strong>pas</strong> de guillemets autour de la regex (et c'est meme deconseille). On guillemete <strong>la chaine testee</strong>, pas le motif.
</div>

Note:
Trois patterns a retenir : `[[ s =~ ^...$ ]]` pour valider une saisie, `sed -E 's/.../.../'` pour transformer, `awk '/motif/ {...}'` ou `$N ~ /motif/` pour filtrer par champ. C'est 90% des besoins reels.

---

## Boot : du firmware au login
<div class="diagram">
  <div class="node">Firmware</div>
  <span class="arrow">-&gt;</span>
  <div class="node">Bootloader</div>
  <span class="arrow">-&gt;</span>
  <div class="node kernel">Kernel</div>
  <span class="arrow">-&gt;</span>
  <div class="node">systemd</div>
  <span class="arrow">-&gt;</span>
  <div class="node">Services</div>
  <span class="arrow">-&gt;</span>
  <div class="node">Login</div>
</div>

- Le bootloader charge le kernel.
- Le kernel initialise le materiel et monte le systeme racine.
- `systemd` demarre les services.
- Le login arrive apres les services essentiels.

Note:
Ne pas aller trop bas niveau. Il faut surtout comprendre ou chercher quand "ca ne boot pas" ou "un service ne demarre pas".

---

## Processus : programmes en execution
<!-- exercise: ../exercises/07-process-services-logs.md -->

```bash
ps aux
ps -ef
top
pgrep ssh
kill -TERM <pid>
```

- Un programme sur disque devient un processus quand il s'execute.
- Chaque processus a un PID.
- Le kernel planifie les processus sur le CPU.
- Un processus appartient a un utilisateur.
- Les signaux demandent a un processus de s'arreter, recharger ou se terminer.

Note:
Expliquer `TERM` avant `KILL`. `kill -9` est un dernier recours.

---

## Scheduler : partager le CPU
<div class="three-cols">
  <div class="card accent">
    <h4>Runnable</h4>
    <p>Le processus peut tourner et attend du CPU.</p>
  </div>
  <div class="card blue">
    <h4>Sleeping</h4>
    <p>Il attend une entree, un disque, un reseau ou un timer.</p>
  </div>
  <div class="card amber">
    <h4>Stopped/Zombie</h4>
    <p>Etat special a diagnostiquer si la machine se comporte mal.</p>
  </div>
</div>

```bash
ps -eo pid,ppid,user,stat,comm --sort=stat | head
```

Note:
Faire comprendre que CPU haut != toujours probleme. Il faut identifier le processus et son role.

---

## Memoire Linux : l'idee importante
<div class="diagram">
  <div class="node">Processus A</div>
  <div class="node">Processus B</div>
  <span class="arrow">voient</span>
  <div class="node kernel">Memoire virtuelle</div>
  <span class="arrow">mappee vers</span>
  <div class="node">RAM + swap + fichiers</div>
</div>

- Chaque processus croit avoir son propre espace memoire.
- Le kernel traduit les adresses virtuelles en pages physiques.
- Le cache disque utilise de la RAM disponible pour accelerer les lectures.
- Swap = extension lente, utile mais pas magique.

Note:
Le message cle : "free RAM low" n'est pas automatiquement un probleme sous Linux, car le cache est reutilisable.

---

## Lire `free -h`
<!-- exercise: ../exercises/08-memory-filesystems.md -->

```bash
free -h
cat /proc/meminfo | head
vmstat 1 5
```

| Colonne | Lecture |
| --- | --- |
| total | RAM totale visible |
| used | RAM utilisee, cache inclus selon affichage |
| free | RAM totalement libre |
| buff/cache | cache reutilisable par le kernel |
| available | estimation de RAM utilisable sans swapper fortement |

<div class="info-box">
  <strong>Regle pratique</strong> : regarder `available`, pas seulement `free`.
</div>

Note:
Faire comparer `free` et `available`. C'est un point souvent mal compris.

---

## Page cache, swap, OOM
<div class="three-cols">
  <div class="card accent">
    <h4>Page cache</h4>
    <p>RAM utilisee pour garder des donnees disque recentes. Reutilisable si besoin.</p>
  </div>
  <div class="card blue">
    <h4>Swap</h4>
    <p>Deplace des pages memoire vers disque. Sauve parfois, ralentit souvent.</p>
  </div>
  <div class="card danger">
    <h4>OOM killer</h4>
    <p>Si la memoire manque vraiment, le kernel peut tuer un processus.</p>
  </div>
</div>

```bash
journalctl -k | grep -i "out of memory"
```

Note:
Rester operationnel : comment detecter, pas comment tuner le kernel en profondeur.

---

## Disque, mounts et inodes
<!-- exercise: ../exercises/08-memory-filesystems.md -->

```bash
df -h
df -i
du -sh ~/linux-lab
findmnt
lsblk
```

- `df -h` : espace disque par filesystem.
- `df -i` : nombre d'inodes disponibles.
- `du -sh` : taille d'un dossier.
- `findmnt` : points de montage.
- `lsblk` : disques et partitions.

> Un disque peut etre "plein" en espace ou en inodes.

Note:
Introduire inodes simplement : entree qui represente un fichier. Beaucoup de petits fichiers peuvent saturer les inodes.

---

## Paquets : installer proprement
<!-- exercise: ../exercises/09-packages-systemd.md -->

```bash
sudo apt update
apt search nginx
sudo apt install nginx
apt show nginx
sudo apt remove nginx
```

- `apt update` met a jour l'index local.
- `apt install` installe depuis les depots configures.
- `apt show` explique un paquet.
- Eviter les scripts `curl | bash` sans comprendre.

Note:
Si Internet n'est pas fiable, utiliser un paquet deja disponible ou simuler avec `apt show`.

---

<!-- class: demo -->
## DEMO - Casser et reparer un service

<span class="callout-badge demo">Demo formateur - 10 min</span>

Live, sur la VM. Je provoque un incident, on le diagnostique ensemble :

1. `sudo systemctl stop ssh` -> "le service ne repond plus".
2. `systemctl status ssh` -> on lit l'etat.
3. `sudo systemctl start ssh` -> on relance.
4. Casser plus subtil : `sudo sed -i.bak 's/^Port 22/Port 2222/' /etc/ssh/sshd_config`.
5. `sudo systemctl restart ssh` -> on regarde **les logs** : `journalctl -u ssh -n 30`.
6. Reparer en restaurant la config : `sudo mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config`.
7. `sudo systemctl restart ssh` -> on verifie avec `ss -tulpn | grep ':22'`.

> Le diagnostic, c'est : **etat -> log -> hypothese -> correction -> verification**.

Note:
Demo essentielle pour le projet final. Bien verbaliser chaque etape. Insister : ne pas corriger sans avoir lu un log.

---

## systemd : controler les services
<!-- exercise: ../exercises/09-packages-systemd.md -->

```bash
systemctl status ssh
sudo systemctl start ssh
sudo systemctl stop ssh
sudo systemctl restart ssh
sudo systemctl enable ssh
systemctl is-enabled ssh
systemctl --failed
```

- Un service est une unite geree par systemd.
- `start` agit maintenant.
- `enable` agit au prochain boot.
- `status` donne l'etat et souvent les derniers logs.

Note:
Bien distinguer start et enable. Faire reformuler.

---

<!-- class: exercice -->
## EXERCICE - start vs enable
<!-- exercise: ../exercises/cahier-exercices.md -->

<span class="callout-badge exercice">Cahier - exercice 33 - 10 min</span>

Avec `ssh` (ou autre service installe) :

1. Verifier son etat (`status`).
2. Le stopper.
3. Verifier qu'il ne tourne plus (`is-active`).
4. Le redemarrer.
5. Verifier qu'il est lance au boot (`is-enabled`).

**Question** :

- quelle est la difference entre `start` et `enable` ?
- si la machine reboote, qu'est-ce qui change pour chacun ?

**Livrable** : commandes + reponses dans `notes/systemctl.md`.

Note:
Distinction clef. Beaucoup de devs en production ont decouvert ce piege en redemarrant un serveur. Faire reformuler.

---

## Logs : le journal du systeme
<!-- exercise: ../exercises/07-process-services-logs.md -->

```bash
journalctl -n 50
journalctl -u ssh
journalctl -p warning -b
journalctl -f
journalctl -k
```

- `-u` filtre par service.
- `-p` filtre par severite.
- `-b` limite au boot courant.
- `-f` suit les logs en temps reel.
- `-k` affiche les logs kernel.

<div class="info-box">
  <strong>Diagnostic</strong> : un service casse sans lecture de logs n'est pas encore diagnostique.
</div>

Note:
Faire casser ou stopper un service simple puis lire les logs associes.

---

## Reseau : modele minimal
<div class="diagram">
  <div class="node">Interface</div>
  <span class="arrow">-&gt;</span>
  <div class="node">Adresse IP</div>
  <span class="arrow">-&gt;</span>
  <div class="node">Route</div>
  <span class="arrow">-&gt;</span>
  <div class="node">DNS</div>
  <span class="arrow">-&gt;</span>
  <div class="node">Port</div>
</div>

```bash
ip address
ip route
resolvectl status
ping -c 3 1.1.1.1
ping -c 3 ubuntu.com
ss -tulpn
```

Note:
Faire la methode : IP locale, route, ping IP, DNS, port. Ne pas commencer par "Internet ne marche pas".

---

<!-- class: exercice -->
## EXERCICE - Methode IP / route / DNS / port
<!-- exercise: ../exercises/cahier-exercices.md -->

<span class="callout-badge exercice">Cahier - exercice 35 - 15 min</span>

Sans rien casser, repondez **dans l'ordre** :

1. IP locale + masque ?
2. Route par defaut (passerelle) ?
3. Resolveur DNS ?
4. `ping 1.1.1.1` passe ?
5. `ping ubuntu.com` passe ?
6. Quels ports ecoutent ?

> Si une etape echoue, **noter l'erreur** au lieu de sauter a la suivante. C'est l'erreur qui guide.

**Livrable** : 6 commandes + 6 reponses dans `notes/reseau.md`.

Note:
Methode incident. Si quelqu'un saute des etapes, lui demander pourquoi et lui faire recommencer. C'est ce qu'on evalue au projet final.

---

## Diagnostiquer un port
<!-- exercise: ../exercises/10-network-ssh.md -->

```bash
ss -tulpn
curl -I http://localhost
sudo systemctl status nginx
journalctl -u nginx -n 50
```

Questions :

- Le processus existe-t-il ?
- Le service ecoute-t-il sur le bon port ?
- Est-ce local ou expose reseau ?
- Le log montre-t-il une erreur ?
- Le firewall ou la config bloque-t-il ?

Note:
Insister sur ordre de preuve : process, port, test local, log, reseau externe.

---

## SSH : travailler a distance
<!-- exercise: ../exercises/10-network-ssh.md -->

```bash
ssh user@ip
ssh-keygen -t ed25519
ssh-copy-id user@ip
ssh -i ~/.ssh/id_ed25519 user@ip
```

- SSH chiffre la session.
- Une cle SSH evite de taper un mot de passe a chaque connexion.
- Les permissions de `~/.ssh` sont importantes.
- Root login direct est a eviter.

<div class="info-box warning">
  <strong>Minimum securite</strong> : mots de passe forts, cles SSH, pas de root direct, logs consultes.
</div>

Note:
Selon environnement, faire SSH depuis l'hote vers la VM ou simuler avec localhost.

---

## Methode incident en 6 questions
1. Qu'est-ce qui devrait marcher ?
2. Quel signal prouve que ca ne marche pas ?
3. Quel composant est implique : service, fichier, permission, reseau, disque, memoire ?
4. Quelle commande donne une preuve ?
5. Quel changement minimal tester ?
6. Comment revenir en arriere ?

```bash
systemctl status <service>
journalctl -u <service> -n 50
ss -tulpn
df -h
free -h
```

Note:
Faire appliquer au projet final. Pas de "j'ai tout essaye" sans hypothese et preuve.

---

## Projet final : serveur diagnostiquable
<!-- exercise: ../exercises/11-projet-final.md -->

Livrable par binome :

- VM Ubuntu accessible.
- Service installe et demarre au boot.
- Commande qui prouve que le processus tourne.
- Commande qui prouve que le port ecoute.
- Log utile identifie.
- Note de reprise si le service est arrete.
- Mini-demo de 3 minutes.

Note:
Le service peut etre nginx, ssh ou un mini serveur Python selon l'environnement. L'important est le diagnostic.

---

<!-- class: qna -->
## Avez-vous des questions ?

<div class="qna-mark">?</div>

Note:
Avant la cloture - 10 min. Derniere ligne droite avant la retro. Tout ce qui reste flou doit sortir maintenant. Themes a relancer : processus, memoire, services, logs, reseau, SSH, projet final. Ouvrir aussi sur "comment continuer seul" : `man`, `--help`, lire des configs reelles, casser une VM jetable. Donner 2-3 ressources de prolongation si questions.

---

<!-- class: hero -->
## Recap final
- Linux se comprend par couches : distribution, shell, services, kernel, materiel.
- Le kernel gere processus, memoire, fichiers, reseau et peripheriques.
- La memoire Linux inclut RAM, cache, swap et decisions du kernel.
- Les services se pilotent avec `systemctl` et se diagnostiquent avec `journalctl`.
- Le reseau se verifie par etapes : IP, route, DNS, port, service.
- Une bonne commande produit une preuve.

> Competence cible : etre capable d'entrer sur une machine Linux inconnue et de construire une hypothese fiable.

Note:
Terminer par les demos courtes et une retro : ce qu'ils savent faire seuls, ce qu'il faut pratiquer.
