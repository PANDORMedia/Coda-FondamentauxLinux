# TP 05 - Utilisateurs et permissions

Objectif : lire et modifier les permissions de fichiers de test.

## Identifier votre contexte

```bash
whoami
id
groups
umask
```

## Creer des fichiers

```bash
mkdir -p ~/linux-lab/permissions
cd ~/linux-lab/permissions
touch public.txt secret.txt script.sh
echo 'echo hello' > script.sh
```

## Observer

```bash
ls -l
```

## Appliquer les droits

```bash
chmod 644 public.txt
chmod 600 secret.txt
chmod 755 script.sh
```

## Tester

```bash
./script.sh
cat secret.txt
ls -l
```

## Questions

- Qui peut lire `public.txt` ?
- Qui peut modifier `secret.txt` ?
- Pourquoi `script.sh` doit avoir le droit `x` ?
- Pourquoi `chmod 777` est une mauvaise solution par defaut ?

## Livrable

Creer `~/linux-lab/notes/permissions.md` avec un tableau fichier, droits, justification.
