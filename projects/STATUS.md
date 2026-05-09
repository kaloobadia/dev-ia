---
auteur: Claude
type: status-board
date: 2026-05-09
derniere_maj: 2026-05-09 08h38
---

# Global Dashboard — /dev

*Généré par `/synthese-multi`. Mettre à jour via option 1 ou 3.*

---

## Projets actifs (in-progress)

### enquete-benevoles-report — `last_update: 2026-05-09`
- **État** : Rapport fonctionnel sur localhost:8000, console sans erreurs bloquantes
- **Complété** : Sections 01, 02, 03, 06 — K slider unifié, RadarLegend, interprétations auto-générées
- **En attente** : Section 04 (gap formation multi-variable) — heatmap ou barres comparatives, décision non prise
- **Bloqué par** : `enquete-benevoles` pour export `radarAxesInfo` (spec produite : `docs/data-request-radar-axes-info.md`, côté rapport : RadarLegend déjà implémenté avec fallback gracieux)
- **Branche** : `rework-clustering` — pas encore mergée sur `main`

### enquete-benevoles — `last_update: 2026-05-09`
- **État** : Pipeline Python complet (13 axes analysés, rapports Word/PPTX/HTML livrés)
- **En cours** : Section 04 — décision en attente : données pré-calculées (Option 1) vs calcul client (Option 2)
- **À exporter** : `radarAxesInfo` (définitions des axes radar) pour `enquete-benevoles-report`
- **Bloque** : `enquete-benevoles-report` (radarAxesInfo)

### homelab-tracker — `last_update: 2026-05-05`
- **État** : Application TUI étape 1 en cours (homelab.py), code partiellement écrit
- **Décisions matériel (2026-05-05)** :
  - Config A (0€) validée : 3 machines AM4, GTX 1080 reste en place, inférence E4B (Gemma 4)
  - Config B révisée (~700€) : objectif VRAM abaissé de 24 Go → 16 Go ; cibles RTX 5070 Super ou RX 9070 XT, disponibles maintenant
  - Gemma 4 26B A4B (MoE) : ~14-16 Go en Q4, couverts par config B
- **Prochaines étapes** : Démarrer config A ; surveiller prix GPU ; reprendre homelab.py

---

## Dépendances inter-projets

```
enquete-benevoles  →  enquete-benevoles-report  (radarAxesInfo — définitions axes radar)
```

---

## Statistiques

Actifs : 3 | Bloqués : 0 | Complétés : 0 | Total : 3
Dépendances non résolues : 1 (radarAxesInfo)
