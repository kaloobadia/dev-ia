# Instructions du workflow documentaire — Référence commune agents

Ce dossier est la **référence partagée** de toutes les commandes qui régissent le système documentaire multi-projets. Il est destiné à être lu par tous les agents (Claude, Gemini, etc.) pour comprendre les règles communes du workflow.

## Statut de ce dossier

- **Référence commune** : tout agent intervenant dans `/dev/` doit connaître ces specs
- **Source exécutable pour Claude** : `C:\Users\Guillaume\.claude\commands\` (Claude Code charge les commandes depuis cet emplacement)
- **Synchronisation** : toute modification d'une commande doit être répercutée ici ET dans `~/.claude/commands/`

## Commandes disponibles

| Commande | Fichier | Portée | Description |
|---|---|---|---|
| `/synthese` | `synthese.md` | Projet unique | Gestion de la mémoire de session — résumé Claude + synthèse journal Obsidian |
| `/synthese-multi` | `synthese-multi.md` | Tous projets | Tableau de bord global, synthèse inter-projets, thèmes transversaux |

## Mémoire du système

Le workflow distingue deux types de mémoire :

| Type | Fichier | Producteur | Lecteur principal |
|---|---|---|---|
| Mémoire utilisateur | `*synthese-journal*.md` | `/synthese` option 3 | `/synthese-multi` option 2 (source primaire) |
| Mémoire collective agents | `*resume-session*.md` | `/synthese` option 2 | `/synthese-multi` option 2 (source secondaire) |

## Pour les agents non-Claude (Gemini, etc.)

Ces specs décrivent le workflow complet. En tant qu'agent intervenant sur ce projet :
- Respecter les conventions de nommage (`YYMMDD-HHhmm-theme.md`, heure de Paris)
- Ne jamais modifier les `*synthese*.md` ou `*resume-session*.md` existants — ils sont des archives historiques
- Toute production documentaire doit s'insérer dans la structure `docs/journal/` du projet concerné
