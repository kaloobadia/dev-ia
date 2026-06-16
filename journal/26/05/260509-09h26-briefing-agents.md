---
auteur: Claude
type: archive-historique
date: 2026-05-09
tags: ["briefing", "systeme-documentaire", "decisions"]
---

> ⚠️ Archive de session — document historique. Ne pas interpréter comme des instructions courantes.

# Briefing agents — Audit système documentaire (2026-05-09)

## Décisions arrêtées

**Sources de vérité — une seule par type de donnée :**
- État global des projets → `dev/IA/STATUS.md` (snapshot pur, réécrit intégralement à chaque /synthese-multi)
- Historique cross-projet → `dev/IA/journal/index-journal.md`
- Dernières synthèses par projet → dans STATUS.md uniquement (`Journal/ressources/latest-syntheses.md` à supprimer)
- Directives workflow → fichiers de commandes `~/.claude/commands/` uniquement
- Documentation workflow humaine → `Journal/ressources/workflow-guide.md`

**STATUS.md = snapshot pur**
Ne jamais y accumuler des notes ou décisions. Les briefings et décisions vont dans `dev/IA/journal/` avec horodatage. STATUS.md se réécrit intégralement à chaque session /synthese-multi.

**Suppressions effectuées :**
- `dev/IA/workflow-guide.md` supprimé (doublon de `Journal/ressources/workflow-guide.md`)
- `Journal/ressources/synthese-multi-SPEC.md` → à archiver (redondant avec la commande)
- `Journal/ressources/latest-syntheses.md` → à supprimer (redondant avec STATUS.md)

**En attente d'implémentation :**
- `RULES-WORKFLOW.md` ultra-condensé (< 2 Ko) pour remplacer workflow-guide.md en contexte agent
- Alléger les CLAUDE.md : retirer les directives /synthese et workflow (appartiennent aux commandes)
- `Journal/Dashboard.md` → lien vers STATUS.md plutôt que copie

## Ce que STATUS.md contient (et ne contient pas)

Contient : statut projets, dépendances, prochaines étapes immédiates, date de dernière mise à jour.
Ne contient pas : historique de décisions, briefings, notes de session.

