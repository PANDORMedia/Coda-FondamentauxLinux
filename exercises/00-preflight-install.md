# TP 00 - Preflight et installation Ubuntu

Objectif : obtenir une VM Ubuntu Server qui boote correctement.

## Preparation

Verifier :

- hyperviseur installe ;
- ISO Ubuntu Server LTS disponible ;
- 25 Go de disque libre ;
- au moins 2 Go de RAM pour la VM ;
- acces Internet ou mirror local ;
- clavier connu.

## VM recommandee

| Ressource | Valeur |
| --- | --- |
| CPU | 2 vCPU |
| RAM | 2 a 4 Go |
| Disque | 25 Go |
| Reseau | NAT |
| ISO | Ubuntu Server LTS |

## Installation

1. Creer la VM.
2. Monter l'ISO.
3. Demarrer sur l'ISO.
4. Choisir langue et clavier.
5. Garder le reseau en DHCP.
6. Utiliser tout le disque virtuel.
7. Creer un utilisateur standard.
8. Installer OpenSSH si le formateur le demande.
9. Ne pas installer de paquets additionnels.
10. Redemarrer.

## Verification

```bash
whoami
hostname
uname -r
lsb_release -a
ip address
```

## Livrable

Dans `system-notes.md`, noter :

- hyperviseur utilise ;
- version Ubuntu ;
- kernel ;
- RAM ;
- disque ;
- adresse IP ;
- choix SSH.

## Stop-loss

Si l'installation depasse 110 minutes, utiliser une VM preparee et continuer le cours.
