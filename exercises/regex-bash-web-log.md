# TP - Regex + Bash sur `web.log` 


**Données** : `web.log` (déjà copié dans `~/linux-lab/data/web.log`.

Format Apache standard, 10 champs séparés par des espaces :

```
192.168.56.10 - - [28/Apr/2026:08:00:02 +0200] "GET / HTTP/1.1" 200 512
$1            $2 $3 $4                $5      $6  $7 $8         $9  $10
```

---

## Partie 1 - Chasse aux regex (15 min)

Travaillez dans le terminal. Écrivez **une ligne par question** dans `~/linux-lab/notes/regex-web.md` (commande + sortie courte).

### Q1 - Toutes les erreurs 5xx

Affichez toutes les lignes dont le code HTTP commence par `5`. Indice : le code HTTP est précédé et suivi d'un espace.

### Q2 - Endpoints `/api/...`

Affichez uniquement les chemins commencés par `/api/`, sans le reste de la ligne. Indice : `grep -oE`.

### Q3 - Heures de pointe

Extrayez uniquement les heures (au format `HH:MM`) des lignes en `500`. Comptez ensuite combien de `500` se produisent par minute. Format attendu :

```
   3 08:02
   2 08:06
   1 08:12
```

### Q4 - IP externes

Affichez les IP qui **ne sont pas** dans le réseau `192.168.56.0/24`. Une seule fois chacune, triées. Indice : `awk` connaît la négation `!~`.

### Q5 - Anonymisation

Avec `sed`, remplacez toutes les IP du fichier par la chaîne `IP` et écrivez le résultat dans `~/linux-lab/notes/web-anonymise.log`. Le fichier source ne doit **pas** être modifié.

---

## Partie 2 - Script `analyse-web.sh`

Écrivez `~/linux-lab/bin/analyse-web.sh` qui prend un fichier de log Apache en argument et affiche un résumé sur stdout.

### Cahier des charges

- Si l'argument est manquant ou si le fichier n'existe pas, message sur stderr et code de retour `!= 0`.
- Le résumé contient, dans cet ordre :

  ```
  === Analyse de <fichier> ===
  Total requêtes : <n>
  Erreurs 4xx    : <n>
  Erreurs 5xx    : <n>

  Top 3 IP :
     <count> <ip>
     ...

  Top 3 codes HTTP :
     <count> <code>
     ...

  Top 3 endpoints en erreur 5xx :
     <count> <endpoint>
     ...
  ```

- Le script doit utiliser au moins **une regex** avec `grep -E`, `awk` ou `[[ ... =~ ... ]]`.
- Le script ne doit **pas** modifier le fichier d'entrée.

### Test

```bash
./analyse-web.sh ~/linux-lab/data/web.log
./analyse-web.sh /pas/un/fichier   # doit afficher une erreur sur stderr
echo $?                             # doit valoir != 0
```

### Pistes

- Total requêtes : `wc -l` ou `grep -c`.
- Comptage des 4xx / 5xx : `grep -cE` avec une regex sur le code.
- Tops : pipeline canonique vu en cours (`extraire | sort | uniq -c | sort -rn | head`).
- Endpoints en erreur 5xx : filtrer par code HTTP avec `awk`, extraire le 7e champ.

---

## Livrable

- `~/linux-lab/notes/regex-web.md` (5 réponses Q1-Q5).
- `~/linux-lab/bin/analyse-web.sh` exécutable (`chmod +x`).
- La sortie de `./analyse-web.sh ~/linux-lab/data/web.log` collée à la fin du `regex-web.md`.
