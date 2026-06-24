# Intégration /bonjour dans le brief matinal

Note de journal — création le 16/06/2026, dernière mise à jour le 16/06/2026

## Objectif

Faire du brief matinal (tâche planifiée) le socle de `/bonjour`, afin que la commande
ne soit plus un point d'entrée autonome mais la couche interactive qui s'appuie sur un
brief déjà produit.

## Séquence à respecter

1. **Automatiser la mise à jour du Dashboard** (`dev/atelier/Dashboard.md`) — prérequis.
   Sans Dashboard fiable, le brief ne peut pas inclure l'état des projets.

2. **Étendre le brief matinal** pour lire le Dashboard et les projets actifs
   (aujourd'hui il ne couvre que le journal et les scripts).
   Ajouter en fin de brief une invitation : "Pour démarrer, lancez `/bonjour`."

3. **Simplifier `/bonjour`** : si un brief du jour existe déjà dans le journal,
   sauter les étapes 1-2 (lecture Dashboard + projets actifs) et démarrer
   directement sur la question d'énergie.

## État au 16/06/2026

- Brief matinal : opérationnel (tâche Cowork `morning-brief`)
- Dashboard auto-update : en cours de conception
- `/bonjour` : inchangé pour l'instant
