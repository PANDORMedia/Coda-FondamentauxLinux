# Cas de diagnostic

## Cas 1

Symptome : `curl http://localhost` echoue.

Indices :

- verifier `systemctl status nginx` ;
- verifier `ss -tulpn` ;
- lire `journalctl -u nginx -n 30`.

## Cas 2

Symptome : SSH refuse la connexion.

Indices :

- verifier l'IP ;
- verifier le service `ssh` ;
- verifier le port 22 ;
- verifier le firewall si present.

## Cas 3

Symptome : un script ne s'execute pas.

Indices :

- verifier le shebang ;
- verifier `chmod +x` ;
- lancer avec `bash script.sh` ;
- lire le message d'erreur exact.
