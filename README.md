# Fondamentaux de Linux

Cours de 3 jours pour acquérir les fondamentaux Linux utiles en développement, DevOps, support, cybersécurité d'entrée de gamme et systèmes embarqués.

## Intention

Former des étudiants à utiliser Linux efficacement en contexte professionnel : terminal, fichiers, permissions, scripts simples, processus, services, réseau, SSH et diagnostic de base.

Le format pédagogique reste simple :

- un fil rouge unique plutôt qu'une suite de commandes isolées ;
- chaque notion théorique est suivie d'une manipulation immédiate ;
- livrables observables à la fin de chaque demi-journée ;
- ratio cible strict : 1/3 magistral, 2/3 pratique.

## Format

- Durée : 3 jours x 7h pédagogiques, soit 21h.
- Répartition : 7h magistral, 14h pratique.
- Niveau : débutant technique à intermédiaire léger.
- Fil rouge proposé : installer Ubuntu Server en VM, puis transformer cette machine fraîche en serveur exploitable, sécurisé au minimum et diagnostiquable.

## Fichiers

- [Syllabus.md](Syllabus.md) : objectifs, public, prérequis, compétences et évaluation.
- [Plan.md](Plan.md) : déroulé détaillé jour par jour avec minutage magistral/pratique.
- `slides/` : moteur de slides local.
- `lessons/` : contenu des 3 journées (J1, J2, J3).
- `exercises/` : TP individuels **et** [cahier d'exercices](exercises/cahier-exercices.md) à 36 exercices.
- `examples/` : fichiers de logs, CSV, scripts et services pour les TP.
- `scripts/` : serveur local pour ouvrir les slides.
- `templates/` : gabarits de leçons.

## Lancer les slides

```bash
scripts/serve.sh
```

Puis ouvrir `http://localhost:8000/`.

## Naviguer dans les slides

| Touche | Action |
| --- | --- |
| `←` / `→` | slide précédente / suivante |
| `1` `2` `3` | aller au jour 1/2/3 |
| `T` | ouvrir le TP lié à la slide courante |
| `M` | menu des slides |
| `F` | plein écran |
