# Fondamentaux de Linux

Statut : **cours construit**. Le dossier contient le syllabus, le plan, les slides, les TP, les exemples et les garde-fous formateur.

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
- [guide-timing-formateur.md](guide-timing-formateur.md) : stop-loss, ordre de sacrifice et checkpoints.
- [checklist-formateur.md](checklist-formateur.md) : check rapide avant et pendant la session.
- [corrections-formateur.md](corrections-formateur.md) : **document formateur uniquement**, corrections de tous les exercices du cahier + barème.
- [sources-recherche.md](sources-recherche.md) : sources web utilisées pour cadrer le syllabus.
- `slides/` : moteur de slides local.
- `lessons/` : contenu des 3 journées.
- `exercises/` : TP liés au panneau TP **et** [cahier d'exercices](exercises/cahier-exercices.md) à 36 exercices remis aux étudiants.
- `examples/` : fichiers de logs, CSV, scripts et services.
- `scripts/` : serveur local.

## Ce qui est remis aux étudiants vs formateurs

| Document | Étudiant | Formateur |
| --- | :---: | :---: |
| Slides (`slides/`) | oui | oui |
| Lessons (`lessons/`) | oui | oui |
| TP individuels (`exercises/0X-...md`) | oui | oui |
| **Cahier d'exercices** (`exercises/cahier-exercices.md`) | oui | oui |
| **Corrections** (`corrections-formateur.md`) | **non** | oui |
| Guide timing, checklist | non | oui |

## Prochaine étape

Lancer les slides :

```bash
scripts/serve.sh
```

Puis ouvrir `http://localhost:8000/`.
