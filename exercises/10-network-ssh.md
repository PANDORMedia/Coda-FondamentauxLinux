# TP 10 - Reseau et SSH

Objectif : verifier IP, DNS, port et acces distant.

## Reseau local

```bash
ip address
ip route
ping -c 3 1.1.1.1
ping -c 3 ubuntu.com
resolvectl status
```

## Ports

```bash
ss -tulpn
curl -I http://localhost
```

## SSH

Verifier le service :

```bash
systemctl status ssh
ss -tulpn | grep ':22'
```

Depuis l'hote ou une autre VM :

```bash
ssh user@ip
```

Remplacer `user` et `ip`.

## Cle SSH

```bash
ssh-keygen -t ed25519
ssh-copy-id user@ip
ssh user@ip
```

## Livrable

Creer `~/linux-lab/notes/network-ssh.md` avec :

- IP de la VM ;
- route par defaut ;
- serveur DNS ;
- ports 22 et 80 si presents ;
- commande SSH testee ;
- probleme rencontre et correction.
