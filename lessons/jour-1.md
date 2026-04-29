<!-- class: hero -->
# Fondamentaux de Linux
Installer Ubuntu, comprendre Linux, survivre dans le terminal.

<div class="image-hero">
  <img src="https://upload.wikimedia.org/wikipedia/commons/3/35/Tux.svg" alt="Tux, la mascotte officielle de Linux" loading="lazy">
</div>

<div class="tag-row">
  <span class="tag">Ubuntu Server</span>
  <span class="tag">Kernel</span>
  <span class="tag">Shell</span>
  <span class="tag">Filesystem</span>
  <span class="tag">Terminal</span>
</div>

Note:
Objectif de cadrage : les etudiants doivent sortir du J1 avec une VM installee, une comprehension claire de la pile Linux et assez d'autonomie terminal pour ne pas etre bloques par les commandes de base.

---

<!-- class: presentation -->
## Qui suis-je

<div class="formateur-card">
  <div class="formateur-body">
    <strong>Sion GENDERS</strong>
    <em>Formateur depuis 2011 - PANDOR MEDIA</em>
    <ul>
      <li>Stack quotidien : Mac/Linux, Docker, Kubernetes, Golang, Typescript, React &amp; Python</li>
      <li>LinkedIn : <a href="https://www.linkedin.com/in/sion-gdrs/">linkedin.com/in/sion-gdrs</a></li>
      <li>Contact : sean@pandor.media</li>
    </ul>
  </div>
</div>

Note:
3-4 minutes max. Noter les profils pour adapter les exemples.

---

## Plan du jour

<!-- exercise: ../exercises/00-preflight-install.md -->

<div class="day-plan">
  <div class="plan-step">
    <span class="plan-num">01</span>
    <span class="plan-icon">[~]</span>
    <div class="plan-time">35 min - matin</div>
    <h4>Preflight + accueil</h4>
    <p>Tour de table, hyperviseur, ISO, ressources VM, reseau. Verifier que tout le monde peut installer.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">02</span>
    <span class="plan-icon">[+]</span>
    <div class="plan-time">90 min - matin</div>
    <h4>Installation Ubuntu Server</h4>
    <p>Creer la VM, monter l'ISO, choisir disque, utilisateur, reseau, SSH. Premier reboot.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">03</span>
    <span class="plan-icon">[?]</span>
    <div class="plan-time">55 min - matin</div>
    <h4>Modele mental Linux</h4>
    <p>Histoire courte, kernel vs distribution, role du shell, les 5 couches du systeme.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">04</span>
    <span class="plan-icon">[$]</span>
    <div class="plan-time">60 min - apres-midi</div>
    <h4>Premieres commandes Bash</h4>
    <p>Prompt, options, historique, <code>man</code>, <code>--help</code>. L'aide locale d'abord.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">05</span>
    <span class="plan-icon">[/]</span>
    <div class="plan-time">65 min - apres-midi</div>
    <h4>Filesystem et navigation</h4>
    <p><code>/home</code>, <code>/etc</code>, <code>/var</code>, chemins absolus/relatifs, fichiers caches.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">06</span>
    <span class="plan-icon">[*]</span>
    <div class="plan-time">75 min - apres-midi</div>
    <h4>Fichiers et edition</h4>
    <p><code>cp</code>, <code>mv</code>, <code>rm</code>, lecture, edition. Manipulations prudentes.</p>
  </div>
  <div class="plan-step">
    <span class="plan-num">07</span>
    <span class="plan-icon">[v]</span>
    <div class="plan-time">40 min - cloture</div>
    <h4>Mini-lab + Q&amp;A</h4>
    <p>Documenter sa machine. Livrable observable. Tour de questions avant retro.</p>
  </div>
</div>

Note:
Donner les timings. L'installation est un support pedagogique, pas un tunnel technique. Si elle bloque plus de 110 minutes, basculer sur VM preparee.

---

## Pourquoi Linux compte
<div class="three-cols">
  <div class="card accent">
    <h4>Serveurs</h4>
    <p>Linux est la base de nombreux serveurs web, bases de donnees, environnements cloud et plateformes DevOps.</p>
  </div>
  <div class="card blue">
    <h4>Developpement</h4>
    <p>Le terminal, les scripts, Git, Docker et CI/CD reposent sur des conventions Unix/Linux.</p>
  </div>
  <div class="card amber">
    <h4>Objets et embarque</h4>
    <p>De nombreux routeurs, box, robots, gateways IoT et appareils Android utilisent un noyau Linux.</p>
  </div>
</div>

> Objectif du cours : comprendre assez pour agir, diagnostiquer et apprendre seul.

Note:
Relier au contexte des etudiants. Linux n'est pas seulement une alternative desktop : c'est l'environnement de production et d'automatisation.

---

## Linux et le gaming

<div class="image-hero">
  <img src="https://upload.wikimedia.org/wikipedia/commons/8/83/Steam_icon_logo.svg" alt="Logo Steam" loading="lazy">
</div>

<div class="three-cols">
  <div class="card accent">
    <h4>Proton</h4>
    <p>Couche de compatibilite (Wine + DXVK) qui fait tourner les jeux Windows sur Linux. Open source, integree a Steam depuis 2018.</p>
  </div>
  <div class="card blue">
    <h4>Steam Deck</h4>
    <p>Console portable de Valve, sortie en 2022, sous SteamOS - une distribution Linux base Arch. Plusieurs millions d'unites vendues.</p>
  </div>
  <div class="card amber">
    <h4>ProtonDB</h4>
    <p>Base communautaire qui note la compatibilite de chaque jeu. ~80% du top Steam est jouable sous Linux aujourd'hui.</p>
  </div>
</div>

> En 5 ans, Valve a transforme Linux en plateforme de jeu credible - et tout est open source.

Note:
Valve a investi dans Linux par crainte de Microsoft (Windows 8 store ferme). Proton est un fork de Wine maintenu par Valve et CodeWeavers. Le Steam Deck a fait basculer la perception : Linux peut etre une console grand public.

---

## Histoire courte de Linux

<div class="portrait-card">
  <img src="https://upload.wikimedia.org/wikipedia/commons/0/01/LinuxCon_Europe_Linus_Torvalds_03_%28cropped%29.jpg" alt="Linus Torvalds, createur du noyau Linux" loading="lazy">
  <div class="portrait-body">
    <strong>Linus Torvalds</strong>
    <em>Createur du noyau Linux, 1991</em>
    <p>Etudiant finlandais, il publie en aout 1991 sur Usenet un noyau "juste un hobby, rien de gros et professionnel". Le projet devient le coeur logiciel d'Internet, du cloud et de la majorite des serveurs et smartphones.</p>
  </div>
</div>

| Date | Evenement | Pourquoi c'est important |
| --- | --- | --- |
| 1969 | Unix nait chez Bell Labs | Modele fichiers/processus/outils simples |
| 1983 | Projet GNU | Volonte d'un systeme libre compatible Unix |
| 1991 | Linus Torvalds annonce son noyau | Le kernel Linux commence comme projet personnel |
| 1992 | Linux adopte la GPLv2 | Croissance communautaire et redistribuable |
| 1993-1994 | Debian, Slackware, Red Hat, SUSE | Les distributions rendent Linux installable |
| 2000s | Serveurs web, clusters, embarque | Linux devient une plateforme industrielle |
| 2010s-2020s | Cloud, Android, conteneurs | Linux devient l'infrastructure invisible du numerique |

Note:
Insister sur la nuance : Linux au sens strict est le noyau. Le systeme utilise aussi des composants GNU, systemd, utilitaires, bibliotheques et paquets de distribution.

---

## Linux, GNU/Linux, distribution

<div class="image-grid">
  <figure>
    <img src="https://upload.wikimedia.org/wikipedia/commons/2/22/Heckert_GNU_white.svg" alt="Logo GNU" loading="lazy">
    <figcaption>GNU - les outils</figcaption>
  </figure>
  <figure>
    <img src="https://upload.wikimedia.org/wikipedia/commons/3/35/Tux.svg" alt="Logo Tux Linux" loading="lazy">
    <figcaption>Linux - le noyau</figcaption>
  </figure>
  <figure>
    <img src="https://upload.wikimedia.org/wikipedia/commons/a/ab/Logo-ubuntu_cof-orange-hex.svg" alt="Logo Ubuntu" loading="lazy">
    <figcaption>Ubuntu - la distribution</figcaption>
  </figure>
</div>

<div class="diagram">
  <div class="node">Applications</div>
  <span class="arrow">sur</span>
  <div class="node">Shell + outils</div>
  <span class="arrow">avec</span>
  <div class="node kernel">Kernel Linux</div>
  <span class="arrow">sur</span>
  <div class="node">Materiel</div>
</div>

- **Linux** : le noyau, responsable de l'acces au materiel et des ressources.
- **GNU/Linux** : formulation qui rappelle le role des outils GNU dans l'OS complet.
- **Distribution** : noyau + outils + gestionnaire de paquets + choix de configuration.
- **Ubuntu Server** : distribution generaliste, LTS, pratique pour apprendre et deployer.

Note:
Ne pas transformer en debat terminologique. Faire comprendre que "installer Linux" veut souvent dire "installer une distribution".

---

## Tour d'horizon des distributions

<div class="distro-grid">
  <div class="distro-card">
    <div class="distro-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/a/ab/Logo-ubuntu_cof-orange-hex.svg" alt="Ubuntu" loading="lazy"></div>
    <div class="distro-name">Ubuntu</div>
    <p class="distro-tag">Le grand public, du desktop au cloud.</p>
  </div>
  <div class="distro-card">
    <div class="distro-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/4/4a/Debian-OpenLogo.svg" alt="Debian" loading="lazy"></div>
    <div class="distro-name">Debian</div>
    <p class="distro-tag">Stable, universel, base de nombreuses distros.</p>
  </div>
  <div class="distro-card">
    <div class="distro-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/4/41/Fedora_icon_%282021%29.svg" alt="Fedora" loading="lazy"></div>
    <div class="distro-name">Fedora</div>
    <p class="distro-tag">Innovation a l'etat pur, sponsorisee par Red Hat.</p>
  </div>
  <div class="distro-card">
    <div class="distro-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/d/d8/Red_Hat_logo.svg" alt="Red Hat Enterprise Linux" loading="lazy"></div>
    <div class="distro-name">RHEL</div>
    <p class="distro-tag">Reference Linux en entreprise, support commercial.</p>
  </div>
  <div class="distro-card">
    <div class="distro-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/f/f9/Archlinux-logo-standard-version.svg" alt="Arch Linux" loading="lazy"></div>
    <div class="distro-name">Arch Linux</div>
    <p class="distro-tag">Rolling release minimaliste, pour utilisateurs avances.</p>
  </div>
  <div class="distro-card">
    <div class="distro-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/c/c4/NixOS_logo.svg" alt="NixOS" loading="lazy"></div>
    <div class="distro-name">NixOS</div>
    <p class="distro-tag">Systeme entierement reproductible et declaratif.</p>
  </div>
  <div class="distro-card">
    <div class="distro-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/2/2c/Alpine_Linux_logo.png" alt="Alpine Linux" loading="lazy"></div>
    <div class="distro-name">Alpine</div>
    <p class="distro-tag">Ultra-legere, standard de fait dans les conteneurs Docker.</p>
  </div>
  <div class="distro-card">
    <div class="distro-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/f/f2/New_Linux_Mint_logo.svg" alt="Linux Mint" loading="lazy"></div>
    <div class="distro-name">Linux Mint</div>
    <p class="distro-tag">Bureau accessible et familier pour debutants.</p>
  </div>
</div>

> Deux grandes familles : **Debian/Ubuntu** (`apt`, `.deb`) et **Red Hat/Fedora** (`dnf`, `.rpm`). Une commande qui marche sur Ubuntu marche generalement sur Debian. Pas sur Fedora.

Note:
Insister sur les familles : Debian -> Ubuntu -> Mint (heritage), et Red Hat -> Fedora / RHEL / Rocky / AlmaLinux. Arch et NixOS sont des "philosophies" a part. Alpine = Docker. Mentionner que choisir une distrib, c'est choisir un gestionnaire de paquets, un cycle de release, et une communaute.

---

## Pourquoi Ubuntu

<div class="info-box">
  <strong>Heritage Debian</strong> : Ubuntu est un <em>fork</em> de Debian (Canonical, 2004). On herite de <code>apt</code>, du format <code>.deb</code> et de 30 ans de packaging. Tout ce qu'on apprend ici se transpose a Debian, Mint, Pop!_OS, Raspberry Pi OS, Kali...
</div>

<div class="three-cols">
  <div class="card accent">
    <h4>LTS = stabilite</h4>
    <p>Versions <strong>Long Term Support</strong> maintenues 5 ans (10 avec Ubuntu Pro).</p>
  </div>
  <div class="card blue">
    <h4>Ecosysteme massif</h4>
    <p>60 000+ paquets via <code>apt</code>. Tutos, images Docker et Ansible roles ciblent Ubuntu.</p>
  </div>
  <div class="card amber">
    <h4>Cloud-native</h4>
    <p>Image officielle chez AWS, GCP, Azure, OVH, Hetzner. Standard de fait sur les VPS.</p>
  </div>
</div>

<div class="three-cols">
  <div class="card accent">
    <h4>Communaute</h4>
    <p>Doc officielle, askubuntu, base d'utilisateurs enorme. Quand vous bloquez, quelqu'un a deja resolu.</p>
  </div>
  <div class="card blue">
    <h4>Securite par defaut</h4>
    <p><code>unattended-upgrades</code>, AppArmor, <code>ufw</code>, <code>sudo</code> sans root direct.</p>
  </div>
  <div class="card amber">
    <h4>Server-first</h4>
    <p>Installation minimaliste, sans desktop, sans bloatware.</p>
  </div>
</div>

Note:
A l'oral : "pour ce cours, on prend Ubuntu Server LTS en VM, sans interface graphique - c'est le terrain le plus realiste pour apprendre." Ubuntu n'est pas la seule distribution, mais c'est celle ou un debutant aura le plus de retour sur investissement.

---

## Avantages de la VM

<div class="three-cols">
  <div class="card accent">
    <h4>Jetable</h4>
    <p>Si on casse, on supprime et on recommence. La machine hote n'est jamais en danger.</p>
  </div>
  <div class="card blue">
    <h4>Snapshots</h4>
    <p>Etat fige a un instant T. Avant une experience risquee : snapshot. En cas de probleme : retour en arriere en 5 secondes.</p>
  </div>
  <div class="card amber">
    <h4>Reproductible</h4>
    <p>Une VM = un fichier disque. On la clone, on la partage, on la relance ailleurs avec le meme etat.</p>
  </div>
</div>

<div class="three-cols">
  <div class="card accent">
    <h4>Isolation</h4>
    <p>Reseau, fichiers et processus separes du systeme hote. Une commande dangereuse reste dans la VM.</p>
  </div>
  <div class="card blue">
    <h4>Realiste</h4>
    <p>Une VM Ubuntu Server reproduit fidelement un serveur de production : meme noyau, meme outils, meme comportement.</p>
  </div>
  <div class="card amber">
    <h4>Pas de dual boot</h4>
    <p>Pas de partitionnement manuel, pas d'effacement du disque hote, pas de risque de perte de donnees personnelles.</p>
  </div>
</div>

Note:
Insister : la VM permet d'apprendre Linux **sans risque**. C'est pour ca qu'on ne fait pas d'installation physique pendant le cours. Mentionner les snapshots comme reflexe avant toute experience.

---

## VM : modele mental
<div class="diagram">
  <div class="node">Machine hote</div>
  <span class="arrow">execute</span>
  <div class="node">Hyperviseur</div>
  <span class="arrow">cree</span>
  <div class="node kernel">Machine virtuelle</div>
  <span class="arrow">boote</span>
  <div class="node">Ubuntu</div>
</div>

| Element | Role |
| --- | --- |
| CPU/RAM | Ressources pretees par l'hote |
| Disque virtuel | Fichier qui simule un disque |
| ISO | Image d'installation |
| Reseau NAT | Acces Internet simple depuis la VM |
| Snapshot | Point de retour si l'etat se degrade |

Note:
Faire dessiner le schema. C'est crucial pour comprendre pourquoi une VM a sa propre IP, son disque, son utilisateur et ses services.

---

## WSL2 vs VM

**WSL2** : noyau Linux dans une micro-VM Hyper-V integree a Windows.

| | VM classique | WSL2 |
| --- | --- | --- |
| Demarrage | lent | instantane |
| Reseau | isole | partage avec l'hote |
| Realisme serveur | fidele | simplifie |
| macOS | oui | non |

Note:
A l'oral : WSL2 = fallback Windows si la VM bloque. Sur Mac, VirtualBox ou UTM. Pour le diagnostic serveur (J3), une vraie VM reste plus pedagogique (boot complet, systemd reel, isolation reseau).

---

## Preflight installation
<!-- exercise: ../exercises/00-preflight-install.md -->

Avant de cliquer sur installer :

1. Verifier virtualisation activee.
2. Telecharger l'ISO Ubuntu Server LTS.
3. Creer une VM avec 2 vCPU, 2 a 4 Go RAM, 25 Go disque.
4. Configurer reseau NAT.
5. Monter l'ISO comme lecteur optique.
6. Noter l'hyperviseur, la version ISO et les ressources choisies.

Note:
Si la salle a des machines faibles, reduire la RAM a 2 Go pour Ubuntu Server. Ne pas lancer Ubuntu Desktop.

---

## Installation Ubuntu Server : les ecrans importants
<!-- exercise: ../exercises/00-preflight-install.md -->

| Ecran | Choix recommande | Pourquoi |
| --- | --- | --- |
| Langue/clavier | Francais (AZERTY) | Eviter les surprises sur `/`, `-`, `:` |
| Reseau | DHCP/NAT par defaut | Suffisant pour apprendre |
| Proxy/mirror | Defaut | Limiter les variables |
| Disque | Use entire disk | Disque virtuel, sans risque hote |
| Profile | utilisateur simple | Compte principal avec sudo |
| SSH | installer si usage distant prevu | Utile J3, optionnel J1 |
| Snaps | aucun au depart | Garder une base minimale |

Note:
Faire lire chaque ecran. Le but est de comprendre les choix, pas de cliquer vite.

---

<!-- class: demo -->
## DEMO - Ubuntu vient de booter

<span class="callout-badge demo">Demo formateur - 5 min</span>

Je projette ma VM. Pas a pas, on regarde :

1. l'invite (le **prompt**) et ce qu'il dit ;
2. taper `whoami`, `hostname`, `pwd` -> trois preuves de "qui/ou/quoi" ;
3. provoquer une erreur volontairement : `cd /root` -> lire le message ;
4. taper `man ls` puis `q` pour sortir ;
5. effacer l'ecran avec `clear` (et `ctrl-l`).

Note:
Demander aux etudiants de taper en meme temps. Si quelqu'un decroche, rejouer. Demo lente. Verbaliser chaque touche. Expliquer le retour a la ligne, le prompt qui reapparait, ce que `q` fait dans `less`.

---

## Premier boot : verifier que la machine existe
<!-- exercise: ../exercises/01-premier-boot-terminal.md -->

```bash
whoami
hostname
uname -a
lsb_release -a
ip address
df -h
free -h
```

> Question : quelle commande prouve la distribution ? Quelle commande prouve le kernel ? Quelle commande prouve les ressources ?

Note:
Les etudiants doivent commencer leur fiche system-notes.md avec ces preuves. Faire verbaliser la difference distribution/kernel.

---

## La pile Linux en 5 couches
<div class="diagram">
  <div class="node">Applications</div>
  <span class="arrow">-&gt;</span>
  <div class="node">Bibliotheques</div>
  <span class="arrow">-&gt;</span>
  <div class="node">Appels systeme</div>
  <span class="arrow">-&gt;</span>
  <div class="node kernel">Kernel</div>
  <span class="arrow">-&gt;</span>
  <div class="node">Materiel</div>
</div>

- Une commande utilisateur ne parle presque jamais directement au disque, au reseau ou a la RAM.
- Elle demande au kernel via des **system calls**.
- Le kernel arbitre : droits, ressources, pilotes, memoire, processus.

Note:
Analogie : le kernel est le guichet obligatoire entre les programmes et les ressources dangereuses.

---

## Ce que fait le kernel
<div class="three-cols">
  <div class="card accent">
    <h4>Processus</h4>
    <p>Creer, planifier, interrompre et isoler les programmes.</p>
  </div>
  <div class="card blue">
    <h4>Memoire</h4>
    <p>Donner une memoire virtuelle a chaque processus, gerer pages, cache et swap.</p>
  </div>
  <div class="card amber">
    <h4>Materiel</h4>
    <p>Pilotes disque, reseau, clavier, USB, GPU, capteurs et peripheriques.</p>
  </div>
</div>

- Le kernel ne remplace pas le shell.
- Le kernel ne "connait" pas vos intentions metier.
- Le kernel applique des regles : permissions, isolation, priorites et limites.

Note:
Preparer J3 : scheduler, memoire, page cache et services. Ne pas trop approfondir ici.

---

## Shell, terminal, prompt
| Mot | Definition courte |
| --- | --- |
| Terminal | Fenetre ou console qui affiche du texte et lit le clavier |
| Shell | Programme qui interprete les commandes, ici Bash |
| Prompt | Ligne d'invite qui indique qu'on peut taper |
| Commande | Programme ou fonction appelee par le shell |
| Option | Modifie le comportement d'une commande |
| Argument | Cible sur laquelle agit la commande |

```bash
ls -la /etc
# commande = ls
# options = -la
# argument = /etc
```

Note:
Faire taper et decomposer une commande simple. C'est un prerequis pour l'aide locale.

---

## Le manuel est dans la machine
<!-- exercise: ../exercises/01-premier-boot-terminal.md -->

| Commande | A quoi ca sert |
| --- | --- |
| `man <cmd>` | manuel complet, paginant |
| `<cmd> --help` | rappel rapide des options |
| `apropos <mot>` | chercher dans **les descriptions** des manuels |
| `whatis <cmd>` | resume en une ligne |
| `type <cmd>` | est-ce un alias, une fonction, un builtin, un binaire ? |
| `which <cmd>` | chemin du binaire execute |

```bash
man ls          # / pour chercher, n suivant, q quitter
ls --help | less
apropos network
type cd          # cd is a shell builtin
which python3    # /usr/bin/python3
```

Note:
Faire chercher une option precise : comment afficher les tailles humaines avec ls ? Attendre qu'ils trouvent `-h`. Ancrer le reflexe : on ouvre le manuel **avant** de googler.

---

## Filesystem : tout part de `/`
<!-- exercise: ../exercises/02-filesystem.md -->

| Chemin | Role |
| --- | --- |
| `/home` | Dossiers utilisateurs |
| `/etc` | Configuration systeme |
| `/var/log` | Logs persistants |
| `/tmp` | Fichiers temporaires |
| `/proc` | Vue dynamique du kernel et des processus |
| `/dev` | Peripheriques exposes comme fichiers |
| `/bin`, `/usr/bin` | Programmes executables |

> Linux expose beaucoup de choses comme des fichiers : config, logs, disques, processus, devices.

Note:
Faire un tour guide avec `ls /`, puis `ls /etc`, `ls /var/log`, `cat /proc/cpuinfo | head`.

---

<!-- class: exercice -->
## EXERCICE - Identifier la machine
<!-- exercise: ../exercises/cahier-exercices.md -->

<span class="callout-badge exercice">Cahier - exercice 01 - 5 min</span>

Sans aide, repondez en tapant les commandes :

1. Qui suis-je connecte en tant que ?
2. Quel est le nom de la machine ?
3. Quelle version exacte d'Ubuntu ?
4. Quelle version du noyau Linux ?
5. Quelle adresse IP principale ?

**Livrable** : 5 lignes dans `~/linux-lab/notes/system-notes.md`, chaque reponse accompagnee de la commande utilisee.

Note:
Chronometrer 5 min stricts. Passer entre les rangees, ne pas donner la commande - donner la **direction** ("regarde du cote de uname", "y'a une commande qui commence par lsb"). Quand un etudiant a fini, lui demander de lever la main pour declencher le debrief collectif.

---

## Chemins absolus et relatifs
```bash
pwd
cd /etc
cd ..
cd ~
cd ./linux-lab
```

- Chemin absolu : commence par `/`.
- Chemin relatif : part du dossier courant.
- `.` signifie ici.
- `..` signifie dossier parent.
- `~` signifie le home de l'utilisateur courant.

<div class="info-box warning">
  <strong>Piege classique</strong> : executer une commande destructive depuis le mauvais dossier.
</div>

Note:
Faire predire le resultat avant execution. Demander "ou sommes-nous ?" toutes les 5 minutes au debut.

---

## Manipuler les fichiers sans se pieger
<!-- exercise: ../exercises/02-filesystem.md -->

```bash
mkdir -p ~/linux-lab/{notes,data,backup}
touch ~/linux-lab/notes/system-notes.md
cp /etc/os-release ~/linux-lab/data/
mv ~/linux-lab/data/os-release ~/linux-lab/data/os-release.copy
rm ~/linux-lab/data/os-release.copy
```

- `mkdir -p` cree une arborescence.
- `cp` copie, `mv` deplace ou renomme.
- `rm` supprime vraiment.
- Pas de corbeille en terminal.

Note:
Faire utiliser `ls` avant et apres chaque action. Les commandes doivent etre observables.

---

<!-- class: exercice -->
## EXERCICE - Construire `~/linux-lab`
<!-- exercise: ../exercises/cahier-exercices.md -->

<span class="callout-badge exercice">Cahier - exercice 05 - 10 min</span>

En **une seule** commande, creez :

```
~/linux-lab/
  notes/   data/   backup/   bin/   permissions/
```

Puis :

1. Verifier la structure avec `find` ou `tree`.
2. Creer un fichier vide `notes/README.md`.
3. Y ecrire `Linux lab - apprenti administrateur` en une commande.

**Indice** : `mkdir -p` accepte une expansion `{a,b,c}`.

Note:
L'expansion d'accolades surprend. Si quelqu'un fait 5 mkdir, lui montrer la syntaxe et faire reessayer. Pas de coup de tampon "echec" : c'est un drill.

---

## Lire et editer du texte
```bash
cat /etc/os-release
less /var/log/syslog
head -n 5 /etc/passwd
tail -n 20 /var/log/syslog
nano ~/linux-lab/notes/system-notes.md
```

- `cat` affiche un petit fichier.
- `less` explore un fichier long.
- `head` et `tail` inspectent le debut ou la fin.
- `nano` suffit pour editer sans apprendre un editeur modal.

Note:
Si `syslog` n'existe pas selon la version, utiliser `journalctl -n 20` comme teaser J3.

---

## Mini-lab J1 : preuve d'autonomie
<!-- exercise: ../exercises/02-filesystem.md -->

Objectif : produire un dossier `linux-lab/` qui prouve que la VM est comprise.

Livrables :

- `notes/system-notes.md` avec version Ubuntu, kernel, RAM, disque, IP.
- `data/os-release.copy` copie controlee d'un fichier systeme.
- `notes/commandes.md` avec 10 commandes expliquees en une phrase.
- capture texte ou sortie de `tree` si installe, sinon `find linux-lab -maxdepth 3`.

Note:
Evaluer la qualite des preuves : les sorties doivent permettre a quelqu'un d'autre de comprendre la machine.

---

<!-- class: qna -->
## Avez-vous des questions ?

<div class="qna-mark">?</div>

Note:
Fin de J1 - 10 min. Tour de table : chacun **une** question ou **un** point flou. Si silence, lancer : "qu'est-ce que vous avez tape aujourd'hui que vous n'avez pas vraiment compris ?" Themes a relancer si necessaire : installation, shell, chemins, aide, filesystem, droits, premier script Bash.

---

<!-- class: hero -->
## Recap J1
- Linux est un noyau, Ubuntu est une distribution.
- La VM isole un systeme complet dans la machine hote.
- Le kernel arbitre processus, memoire, fichiers, reseau et peripheriques.
- Bash interprete les commandes, le terminal n'est que l'interface texte.
- Le filesystem part de `/`, et les chemins doivent etre maitrises.
- L'aide locale est une competence, pas un bonus.

> Demain : pipes, grep, permissions, archives, puis bash de A a Z.

Note:
Demander un exit ticket : une commande apprise, une commande dangereuse, une question encore floue.
