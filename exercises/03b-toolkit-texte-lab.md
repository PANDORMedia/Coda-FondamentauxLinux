# TP 03b - Toolkit texte: une matinee chez Coda Media

> Scenario realiste pour digerer les 12 commandes du toolkit texte en les utilisant pour resoudre 4 tickets reels avant midi.

**Duree** : 1h30 (1h00 guide ticket par ticket, 30 min challenge libre)
**Commandes** : `wc`, `grep`, `find`, `sort`, `uniq`, `cut`, `tr`, `sed`, `awk`, `paste`, `column`, `tee`, `xargs`

---

## Le contexte

Vous venez d'arriver chez **Coda Media**. Lundi 9h, votre lead vous tend un post-it avec quatre tickets a clore avant midi :

| Ticket | Type | Demandeur | Description |
| --- | --- | --- | --- |
| **JIRA-217** | INCIDENT | SRE | Le site a renvoye des `500` cette nuit. Trouve qui, quand, quoi. |
| **JIRA-218** | DATA | Marketing | Rapport CA produit du sprint, trie, format colonne lisible. |
| **JIRA-219** | SECURITY | RGPD | Liste les comptes `inactive` a supprimer, deduplique, ordre alpha. |
| **JIRA-220** | SRE | Ops | Inventaire serveur a livrer en CSV propre : roles en minuscules. |

Pas de Python, pas d'Excel. Juste le terminal. Vos donnees : 6 fichiers dans `examples/jour-2/`.

## Preparer le lab

```bash
mkdir -p ~/linux-lab/data ~/linux-lab/backup ~/linux-lab/notes
cp examples/jour-2/web.log       ~/linux-lab/data/
cp examples/jour-2/inventory.csv ~/linux-lab/data/
cp examples/jour-2/users.txt     ~/linux-lab/data/
cp examples/jour-2/ventes.csv    ~/linux-lab/data/
cp examples/jour-2/noms.txt      ~/linux-lab/data/
cp examples/jour-2/emails.txt    ~/linux-lab/data/
cd ~/linux-lab/data
ls
```

Vous devez voir 6 fichiers. Tous les exemples qui suivent partent de ce dossier.

---

# Phase 0 - Reconnaissance (10 min)

> Avant de toucher a quoi que ce soit, on regarde ce qu'on a.

## `wc` - mesurer

```bash
wc -l web.log
wc -l *.csv *.txt
wc -lwc web.log
```

`wc -l` compte les lignes, `-w` les mots, `-c` les octets. Avec plusieurs fichiers, `wc` ajoute une ligne `total`.

**Question** : combien de requetes dans `web.log` ? Combien de comptes dans `users.txt` (avec doublons) ?

## `find` - localiser

```bash
find ~/linux-lab -type f
find ~/linux-lab -type f -name "*.csv"
find ~/linux-lab -type f -size +1k
find ~/linux-lab -type f -mtime -1
```

`find` parcourt une arborescence. `-type f` ne garde que les fichiers, `-name` filtre par nom (joker shell), `-size` par taille, `-mtime` par date de modification.

> **Reflexe** : `find` cherche dans les chemins, `grep` cherche dans le contenu. On les combine souvent.

---

# Phase 1 - JIRA-217 : Incident 500 (15 min)

> "Le site a renvoye des 500 cette nuit. Trouve qui, quand, quoi."

## `grep` - filtrer des lignes

```bash
grep " 500 " web.log | head
grep -c " 500 " web.log
grep -n " 500 " web.log | head
grep -i " 500 " web.log | wc -l
```

`grep` filtre les lignes qui contiennent un motif. `-c` compte au lieu d'afficher, `-n` ajoute le numero de ligne, `-i` ignore la casse, `-v` inverse.

**Premiere reponse** : combien de `500` au total ?

```bash
grep -B 1 -A 1 " 500 " web.log | head -15
```

`-B N` / `-A N` : N lignes de contexte avant/apres. Permet de voir ce qu'il s'est passe juste avant et juste apres un crash.

## `awk` - decouper en champs

Une ligne de log Apache a 10 champs separes par des espaces :

```
192.168.56.20 - - [28/Apr/2026:09:35:42 +0200] "GET /api/items HTTP/1.1" 500 96
$1            $2 $3  $4                  $5     $6  $7        $8       $9  $10
```

```bash
awk '{print $1}' web.log | head
awk '$9 == 500 {print $1, $7}' web.log | head
awk '$9 == 500 {print $7}' web.log | sort | uniq -c | sort -rn
```

`awk` voit chaque ligne comme une suite de champs `$1, $2, ...`. La forme `condition {action}` n'execute l'action que si la condition est vraie.

**Deuxieme reponse** : quel endpoint a le plus de `500` ?

## `sort | uniq -c | sort -rn` - le pipeline canonique

```bash
awk '$9 == 500 {print $1}' web.log \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -5
```

Lecture etape par etape :

1. `awk` extrait l'IP des lignes en erreur 500.
2. `sort` regroupe les IP identiques (prerequis de `uniq`).
3. `uniq -c` compte les doublons consecutifs.
4. `sort -rn` retrie en numerique decroissant.
5. `head -5` garde le top 5.

> **Cinq commandes, une question metier resolue.** Ce pipeline marche pour : top des erreurs, top des IP, top des extensions, top des codes HTTP, top de n'importe quoi qu'on extrait avec `awk`.

**Troisieme reponse** : quelles sont les 5 IP responsables du plus de `500` ?

---

# Phase 2 - JIRA-218 : Rapport CA produit (15 min)

> "CA par produit du sprint, du plus gros au plus petit, format colonne lisible."

## `cut` - extraire des colonnes

```bash
head ventes.csv
cut -d, -f2 ventes.csv | head
cut -d, -f2,3 ventes.csv | head
cut -d, -f1,3-4 ventes.csv | head
```

`cut` extrait des colonnes. `-d` definit le separateur (ici `,`), `-f` choisit les champs par numero, liste ou plage. Rapide mais bete : il ne gere pas les separateurs multiples ni les champs entoures de guillemets.

## `awk` - calculer

```bash
awk -F, 'NR>1 {ca[$2] += $3*$4} END {for (p in ca) print ca[p], p}' ventes.csv
```

Decoupage :

- `-F,` : separateur virgule.
- `NR>1` : on saute la ligne 1 (l'en-tete).
- `ca[$2] += $3*$4` : on accumule `quantite x prix` dans un tableau indexe par produit.
- `END {...}` : on imprime apres avoir lu tout le fichier.

> **Patterns awk a memoriser** : `NR==1` (premiere ligne), `NR>1` (saute l'en-tete), `END {print sum}` (apres le dernier), `tableau[cle] += valeur` (agregation).

## `sort -rn` + `column -t` - presenter

```bash
awk -F, 'NR>1 {ca[$2] += $3*$4} END {for (p in ca) print ca[p], p}' ventes.csv \
  | sort -rn \
  | column -t
```

`column -t` aligne en colonnes lisibles a partir d'un texte dont les champs sont separes par des espaces. Utile pour livrer un rapport sans Excel.

**Sortie attendue** : 8 lignes, `ecran` en tete, montants alignes.

---

# Phase 3 - JIRA-219 : Audit RGPD comptes inactifs (15 min)

> "Liste les comptes `inactive` a supprimer, sans doublon, ordre alpha. Format CSV final : `nom,role`."

## `grep` + `sort -u` - filtrer et dedupliquer

```bash
head users.txt
grep ":inactive$" users.txt
grep ":inactive$" users.txt | sort -u
```

`sort -u` = `sort | uniq`, en plus court. `:inactive$` ancre la fin de ligne (regex).

## `cut` - garder les bonnes colonnes

```bash
grep ":inactive$" users.txt | sort -u | cut -d: -f1,2
```

On garde `nom` et `role`, on jette `statut`.

## `tr` - changer le separateur

```bash
grep ":inactive$" users.txt | sort -u | cut -d: -f1,2 | tr ':' ','
```

`tr` substitue caractere par caractere (pas de regex, pas de mots). `-d` supprime, `-s` compresse les repetitions consecutives.

## Injecter une en-tete

Comme on veut livrer un CSV propre, il faut une ligne d'en-tete devant le flux. Le moyen le plus portable (Linux et macOS) :

```bash
{ echo "nom,role"; \
  grep ":inactive$" users.txt | sort -u | cut -d: -f1,2 | tr ':' ','; \
} > ~/linux-lab/notes/audit-rgpd.csv

cat ~/linux-lab/notes/audit-rgpd.csv
```

L'astuce : `{ commande1; commande2; }` execute deux commandes a la suite et envoie leur sortie combinee dans une seule redirection.

> Variante GNU (Linux uniquement) : `sed '1i nom,role'` insere une ligne avant la ligne 1. La forme `{ echo ...; ... }` marche partout.

## `sed` - editer ligne par ligne (pour la suite)

`sed` reste indispensable des qu'il faut **modifier** des lignes existantes :

```bash
sed 's/active/ACTIVE/' users.txt | head
sed -n '1,5p' web.log
sed '/inactive/d' users.txt | head
```

`sed s/avant/apres/` substitue, `/g` repete sur toute la ligne, `-n '1,5p'` affiche uniquement les lignes 1 a 5, `/motif/d` supprime les lignes qui matchent.

## `paste` - rapprocher avec un autre fichier (en bonus)

Imaginez qu'un collegue vous a livre les **emails** des comptes inactifs dans un autre fichier, ligne par ligne. `paste` colle deux fichiers cote a cote :

```bash
paste -d, noms.txt emails.txt | head
```

`-d` definit le separateur. `paste` est aveugle : ligne N de fichier1 + ligne N de fichier2.

**Livrable** : un fichier `~/linux-lab/notes/audit-rgpd.csv` avec en-tete et comptes inactifs.

---

# Phase 4 - JIRA-220 : Inventaire propre (15 min)

> "L'inventaire serveur a les roles en MAJUSCULES, on veut tout en minuscules pour la livraison."

## `sed` - transformer ligne par ligne

Premiere lecture :

```bash
head inventory.csv
cut -d, -f3 inventory.csv | sort -u
```

On voit `WEB`, `DB`, `CACHE`, etc. en majuscules (sauf l'en-tete).

```bash
sed 's/,WEB,/,web,/g' inventory.csv | head
sed 's/,WEB,/,web,/g; s/,DB,/,db,/g' inventory.csv | head
```

`sed s/avant/apres/` substitue, `/g` repete sur toute la ligne. On peut chainer plusieurs substitutions avec `;`.

Plus elegant : `tr` accepte les classes de caracteres.

## `awk` - reformater colonne par colonne

```bash
awk -F, 'NR==1 {print; next} {print $1","$2","tolower($3)","$4","$5}' inventory.csv | head
```

Decoupage :

- `NR==1 {print; next}` : on garde l'en-tete intacte et on passe a la ligne suivante.
- `print $1","$2","tolower($3)","$4","$5` : on reconstruit la ligne avec le 3e champ en minuscule.

## `tee` - garder une trace en passant

```bash
awk -F, 'NR==1 {print; next} {print $1","$2","tolower($3)","$4","$5}' inventory.csv \
  | tee ~/linux-lab/notes/inventory-clean.csv \
  | column -t -s,
```

`tee` ecrit dans un fichier ET renvoie le flux dans le pipe. Tres utile pour livrer un fichier propre tout en l'inspectant a l'ecran. `-a` ajoute en fin de fichier au lieu d'ecraser.

## `xargs` - traitement en lot

Bonus : on a livre `inventory-clean.csv`. Maintenant on veut creer une copie de **tous** les `.csv` du dossier dans `backup/` :

```bash
find ~/linux-lab/data -type f -name "*.csv" \
  | xargs -I {} cp {} ~/linux-lab/backup/
```

`xargs` recoit du texte sur stdin et le transforme en arguments d'une autre commande. `-I {}` definit un placeholder reutilisable. Indispensable des qu'on enchaine `find` avec autre chose que `grep` ou `wc`.

---

# Phase 5 - Pipeline complet (5 min)

Le pipeline qui repond completement a JIRA-217 (top 5 IP fautives + sauvegarde + colonne propre) :

```bash
awk '$9 == 500 {print $1}' web.log \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -5 \
  | tee ~/linux-lab/notes/top5-ip-erreurs.txt \
  | column -t
```

Six commandes, une question metier resolue, livrable archive au passage.

---

# Phase 6 - Challenge libre (30 min)

> Trois defis. Construisez chaque pipeline **etape par etape**, ne tapez jamais le pipeline complet d'un coup. Verifiez la sortie a chaque pipe.

## Defi A - Sondes externes suspectes

Sur `web.log`, trouvez les **IP qui ne font pas partie du reseau interne** `192.168.56.0/24`. Comptez combien chacune a tape.

Format de sortie attendu :
```
   14 203.0.113.42
   14 185.220.101.5
    8 45.142.122.18
   ...
```

**Indice** : `awk '$1 !~ /^192\.168\./ {print $1}'` (le `!~` est la negation de regex en awk).

**Bonus** : ajoutez un `tee` pour sauvegarder ce top dans `~/linux-lab/notes/sondes-externes.txt`.

## Defi B - Backend en panne, qui crie le plus ?

Sur `web.log`, trouvez **les 3 IP qui ont recu le plus de `502`** (Bad Gateway, le backend repond mal). Affichez aussi la **plage horaire** (HH:MM de la 1re a la HH:MM de la derniere) et le **total** de `502`.

Format de sortie attendu :
```
=== top 3 IP ===
   3 192.168.56.55
   3 192.168.56.10
   2 192.168.56.13
=== plage 502 ===
debut: 08:26
fin  : 11:02
total: 13
```

**Indices** :
- `awk '$9 == 502 {print $1}'` extrait l'IP, `awk '$9 == 502 {print substr($4, 14, 5)}'` extrait `HH:MM`.
- `sort | head -1` donne le premier, `sort | tail -1` le dernier.
- `grep -c " 502 "` compte directement.

## Defi C - Annuaire propre

Vous devez livrer un annuaire `annuaire.csv` qui combine `noms.txt` et `emails.txt`, avec :

- une en-tete `nom_complet,email` ;
- les noms en minuscules ;
- une virgule comme separateur ;
- une copie de sauvegarde dans `~/linux-lab/backup/annuaire.csv` au passage du flux.

Format attendu :
```
nom_complet,email
alice martin,alice.martin@coda.local
bob durand,bob.durand@coda.local
...
```

**Indices** : `paste -d,` colle les deux fichiers cote a cote, `tr A-Z a-z` met en minuscules, `{ echo "header"; pipeline; }` injecte l'en-tete au debut, `tee` sauvegarde au passage.

---

# Livrable

Dans `~/linux-lab/notes/toolkit.md` :

| Ticket | Pipeline | Sortie courte | Pourquoi cet ordre ? |
| --- | --- | --- | --- |
| JIRA-217 | `awk ... \| sort \| uniq -c \| ...` | top 5 IP | une phrase |
| JIRA-218 | `awk -F, ... \| sort -rn \| column -t` | rapport CA | une phrase |
| JIRA-219 | `grep \| sort -u \| cut \| tr \| sed` | audit RGPD | une phrase |
| JIRA-220 | `awk -F, ... \| tee \| column -t` | inventaire propre | une phrase |
| Defi A | ... | sondes externes | une phrase |
| Defi B | ... | 502 a HH:MM | une phrase |
| Defi C | ... | annuaire | une phrase |

Plus :

- la commande qui vous a le plus surpris pendant le TP et pourquoi ;
- une commande que vous garderez en alias dans `~/.bashrc` (ex : `alias top5='sort | uniq -c | sort -rn | head -5'`).

---

# Annexe - le pipeline canonique en une ligne

```
extraire | sort | uniq -c | sort -rn | head
```

Si vous ne deviez retenir qu'une chose de ce TP, c'est ce pipeline. Il repond a 80% des questions "qui apparait le plus dans ces donnees ?" : top IP, top erreurs, top users, top extensions, top endpoints. La seule difficulte c'est le premier maillon : choisir la bonne commande pour **extraire** la colonne (souvent `awk '{print $N}'` ou `cut -d X -f N`).
