---
auteur: Claude
type: status-board
date: 2026-06-10
derniere_maj: 2026-06-10 17h32
---

# Global Dashboard — /dev

*Généré par `/synthese-multi` (option 1). Mettre à jour via option 1 ou 3.*
*Note : les statuts de doc-tracker, alfred et robertet sont inférés de l'activité récente (créés le 10/06) ; à ajuster si certains sont en pause.*

---

## Projets actifs (in-progress)

### homelab-tracker — `last_update: 2026-06-02`
- **État** : application TUI (étape 1) + planning matériel. Travail récent centré sur l'architecture Proxmox et le choix GPU pour l'inférence LLM (configs C/D/E, GPU-passthrough, PBS, comparatif GPU, reconversion).
- **Prochaines étapes** : trancher la configuration GPU finale ; reprendre le développement de `homelab.py`.
- **Tags** : homelab, tui, python, textual, hardware, llm, proxmox, gpu.

### doc-tracker — `last_update: 2026-05-31`
- **État** : watcher Python d'indexation documentaire multi-projets (watchdog) installé et testé ; multi-paths en place.
- **Prochaines étapes** : décider de l'emplacement final du watcher (racine doc-tracker ou `scripts/` partagé).
- **Tags** : doc-tracker, watcher, indexation, python, watchdog.

### alfred — `last_update: 2026-05-31`
- **État** : commande matinale `/bonjour` Phase 1 écrite (Dashboard + péremption, énergie, diagnostic imagé, micro-geste).
- **Prochaines étapes** : phases suivantes de `/bonjour` ; vouvoiement strict (non négociable).
- **Tags** : alfred, audhd, fonctions-executives, commande, claude-code.

### robertet — `last_update: 2026-05-26`
- **État** : knowledge graph (chaîne génératrice KG-VBA validée), visualisation Gephi/GEXF ; livrable licence pro (étape 2).
- **Prochaines étapes** : produire les livrables de l'étape 2 (export GEXF, analyse de nœuds Gephi).
- **Tags** : robertet, knowledge-graph, kg-vba, gephi, licence-pro.

---

## Projets hors périmètre `dev/`

### UPVM-rapport-stage (`Documents/UPVM-rapport-stage`) — activité 2026-06-10
Rapport de stage licence pro. Priorités 1 et 2 finalisées (relecture stylistique, intégration de la vision stratégique « renouvellement », fonds bibliographique en cours d'organisation). N'utilise pas `synthese-journal`/`resume-session` (notes `journal/`), donc absent du périmètre natif de `/synthese-multi`.

## Projets archivés

`enquete-benevoles` et `enquete-benevoles-report` (anciennement actifs au 09/05) sont désormais archivés sous `enquete-benevolat-biblio64/archive/`.

---

## Dépendances inter-projets

Aucune dépendance formalisée (`blocking`/`blocked_by` vides dans tous les `status.yaml`).

Dépendance implicite repérée (option 4) :
```
homelab-tracker  →  robertet, alfred, doc-tracker, UPVM-rapport-stage
(infrastructure d'inférence LLM, socle des projets consommateurs de modèles)
```

---

## Statistiques

Actifs : 4 | Bloqués : 0 | Complétés : 0 | Total (dev/) : 4
`status.yaml` présents : 4/4 (après création du 10/06).
Dépendances formalisées non résolues : 0.
