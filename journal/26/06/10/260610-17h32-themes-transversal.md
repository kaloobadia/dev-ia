---
auteur: Claude
statut: Analyse thématique
tags: ["themes", "analysis", "cross-project", "llm", "systeme-documentaire", "homelab"]
periode: "2026-05-11 to 2026-06-10"
date: 2026-06-10
---

# Thèmes transversaux — /dev (11/05 au 10/06/2026)

Analyse produite via `/synthese-multi` option 4. Sources : fichiers `*synthese-journal*.md` (mémoire utilisateur) et `*resume-session*.md` (mémoire agent) hors dossiers `archive/`, sur 30 jours. 19 mémoires, 4 projets actifs (homelab-tracker, robertet, doc-tracker, alfred).

## Thèmes identifiés

### 1. Architecture et infrastructure LLM — homelab-tracker (dominant)
6 mémoires. Proxmox, GPU-passthrough, configurations C/D/E, comparatif GPU, reconversion matérielle, inférence LLM, PBS. Projet le plus actif sur la période (dernière activité 02/06).

### 2. Système documentaire et gestion de la connaissance — doc-tracker + robertet
- **doc-tracker** : watcher, indexation, watchdog, Python, « overlap » d'architecture.
- **robertet** : knowledge-graph, KG-VBA, Gephi, analyse de nœuds, chaîne génératrice, conventions de documentation, archivage.
- Thème partagé : outillage de structuration de l'information.

### 3. Usage et choix des LLM — homelab, robertet, alfred
- **homelab** : inférence LLM (raison d'être de l'infra GPU).
- **robertet** : choix de modèle (opus, opus-sonnet, overlay Opus).
- **alfred** : conception orientée AuDHD / fonctions exécutives.

### 4. Livrable académique / licence pro — robertet
Tags `etape2, cadrage, livrable, licence-pro` : méthodologie de production d'un livrable.

## Liens et opportunités

- **homelab ↔ tous les projets IA** : l'infrastructure d'inférence LLM (homelab) est le socle implicite des projets consommant des modèles (robertet, alfred, doc-tracker, et le rapport de stage UPVM). Dépendance non formalisée à expliciter.
- **doc-tracker ↔ robertet ↔ rapport de stage** : indexation/watcher (doc-tracker), knowledge-graph (robertet) et le « système documentaire » du rapport de stage relèvent du même thème. Le script `index_folder.py` est déjà mutualisé (utilisé le 10/06 pour le fonds bibliographique du rapport). Réutilisation possible du watcher de doc-tracker pour surveiller un fonds documentaire.
- **robertet ↔ rapport de stage (UPVM)** : deux livrables licence pro. La méthodologie « cadrage → étapes → livrable » de robertet est transposable au rapport.

## Notes

- Le projet **UPVM-rapport-stage** (hors `dev/`, sous `Documents/`) recoupe les thèmes 2, 3 et 4 mais n'utilise pas les fichiers `synthese-journal`/`resume-session` ; il s'appuie sur des notes `journal/`. Il n'apparaît donc pas dans le périmètre natif de `/synthese-multi`.
- De nombreux journaux d'`enquete-benevoles` et `enquete-benevoles-report` sont archivés sous `enquete-benevolat-biblio64/archive/` (hors fenêtre, non analysés ici).
- Un seul projet (`homelab-tracker`) dispose d'un `status.yaml` ; les autres n'en ont pas, ce qui limite le tableau de bord (option 1).
