---
auteur: Gemini (Critique)
destinataire: Claude
type: note
statut: Brut
tags: ["multi-agent", "optimisation", "documentation", "workflow"]
date: 2026-05-09
---

# Optimisation du Système Documentaire — Note pour Claude

## Contexte
Suite à une phase de délibération avec l'utilisateur et une analyse critique des flux de travail, le système documentaire a été optimisé pour maximiser l'économie de jetons (tokens) et fluidifier les interactions.

## ⚡ Modifications Majeures (Agent Core)

1. **Condensation des Règles (`RULES-WORKFLOW.md`)** :
   - Création de `Journal/ressources/RULES-WORKFLOW.md` (1,3 Ko).
   - Ce fichier remplace désormais le guide de workflow de 19 Ko comme source de vérité impérative pour les agents.
   - **Action attendue** : Toujours charger ce fichier court en priorité.

2. **Refonte de `/synthese-multi` (Dashboard Immédiat)** :
   - La spécification `Journal/ressources/synthese-multi-SPEC.md` a été réécrite.
   - **Changement** : Le dashboard (`STATUS.md`) doit s'afficher immédiatement au lancement, sans menu de démarrage.
   - L'indexation et l'archivage deviennent des étapes silencieuses après validation du contenu.

3. **Refonte de `/synthese` (Clôture Unifiée)** :
   - La spécification `Journal/ressources/synthese-SPEC.md` a été créée.
   - **Changement** : Fusion des fonctions "Résumé de session" et "Synthèse journal".
   - Si des notes brutes sont détectées, l'agent produit une sortie consolidée.

4. **Abandon des Jonctions Gemini** :
   - La jonction `.gemini/` dans les projets est abandonnée.
   - La source de vérité pour Gemini est désormais exclusivement le fichier `GEMINI.md` à la racine de chaque projet.

## 🛠 Actions de Maintenance Effectuées
- Suppression du doublon `workflow-guide.md` dans `dev/IA/`.
- Mise à jour des "Rails" de Gemini dans `homelab-tracker/GEMINI.md`.
- Unification du guide détaillé dans `Journal/ressources/workflow-guide.md`.

---
*Document généré pour assurer la continuité opérationnelle entre agents.*
[[Journal/ressources/RULES-WORKFLOW.md]]
[[Journal/ressources/synthese-SPEC.md]]
[[Journal/ressources/synthese-multi-SPEC.md]]
