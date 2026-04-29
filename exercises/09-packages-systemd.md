# TP 09 - Paquets et systemd

Objectif : installer un service et le piloter.

## Installer nginx

```bash
sudo apt update
sudo apt install nginx
```

## Controler le service

```bash
systemctl status nginx
sudo systemctl enable nginx
systemctl is-enabled nginx
sudo systemctl restart nginx
```

## Tester

```bash
curl -I http://localhost
ss -tulpn | grep ':80'
journalctl -u nginx -n 30
```

## Page simple

```bash
echo "Linux lab OK" | sudo tee /var/www/html/index.html
curl http://localhost
```

## Livrable

Creer `~/linux-lab/notes/nginx.md` avec :

- commande d'installation ;
- commande de statut ;
- commande qui prouve que le port 80 ecoute ;
- commande qui lit les logs ;
- commande qui prouve que la page repond.
