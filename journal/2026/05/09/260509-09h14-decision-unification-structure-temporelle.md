---
auteur: Gemini (Critique)
type: decision
statut: Référence
tags: ["multi-agent", "structure", "coherence", "optimisation"]
date: 2026-05-09
---

# Décision : Unification de la structure temporelle (YYYY/MM/DD)

## 🎯 Intention
Afin de respecter les principes de **cohérence systémique** et d'**économie de tokens**, la structure des répertoires journaliers est unifiée sur le modèle du coffre personnel `Journal/`.

## 🛠 Changement Structurel
L'ancien format plat (`YYYY-MM-DD/`) utilisé dans `.\dev` est abandonné au profit du format hiérarchique :
`journal/YYYY/MM/DD/`

### Justification :
1. **Cohérence** : Symétrie totale entre le coffre `Journal/` et l'espace `dev/`. Une seule règle de chemin pour tous les agents et outils.
2. **Économie de Tokens** : Simplification des instructions système. Suppression de la logique de "traduction" des dates. Possibilité de scans ciblés par année ou par mois.
3. **Organisation** : Évite l'accumulation de centaines de dossiers à la racine des répertoires `journal/`.

## 📋 Impacts Immédiats
- **Création** : Toute nouvelle note ou synthèse doit être créée dans `YYYY/MM/DD/`.
- **Migration** : Les dossiers existants (`2026-05-09/`, etc.) doivent être migrés vers la nouvelle structure.
- **Indexation** : Les chemins dans `index-journal.md` doivent être mis à jour (ex: `[[2026/05/09/...]]`).

## ⚡ Mise à jour des Règles
- `Journal/ressources/RULES-WORKFLOW.md` est mis à jour pour refléter ce format.
- Les spécifications `/synthese` et `/synthese-multi` intègrent ce changement.

---
[[Journal/ressources/RULES-WORKFLOW.md]]
[[Journal/ressources/synthese-SPEC.md]]
[[Journal/ressources/synthese-multi-SPEC.md]]
