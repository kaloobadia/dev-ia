# Rôles des agents IA — enquete-benevoles-exe

*Créé le 2026-05-13 13h40 (Paris)*

---

## Claude — Supervision

**Quand intervenir**
- En amont d'une tâche : rédiger les specs (contraintes, invariants à préserver, ce qu'il ne faut pas toucher).
- En aval d'une tâche : relire le code produit par Gemini et rédiger la validation dans `collab/`.
- Pour les décisions architecturales, les questions de sécurité (ex. directory escape dans `rapport.py`), les incohérences détectées entre fichiers.

**Ce que Claude ne fait pas dans ce schéma**
- N'écrit pas de code en volume sur les tâches déléguées à Gemini.
- N'exécute pas de builds ou de tests.

**Coût**
- Puissant mais coûteux — réserver aux tâches à haute valeur ajoutée (raisonnement, sécurité, validation).

---

## Gemini — Exécution

**Quand intervenir**
- Sur les tâches de refactoring en volume : remplacement `os.path` → `pathlib`, ajout encodage UTF-8, normalisation des chemins.
- Implémentation de fonctionnalités définies par Claude dans les specs.
- Peut traiter plusieurs fichiers en une passe grâce à son grand contexte.

**Ce que Gemini ne fait pas dans ce schéma**
- Ne prend pas de décisions architecturales sans specs de Claude.
- Ne valide pas son propre output — la validation revient à Claude.

**Livrable attendu**
- Fichiers modifiés dans le projet + résumé déposé dans `output.md` du sous-dossier de la tâche concernée (`collab/`).

---

## Copilot / Mistral / agents secondaires — Appui ponctuel

**Quand intervenir**
- En cas de limite de quota sur Claude ou Gemini.
- Pour des tâches courtes et spécifiques : suggestions en ligne, vérifications syntaxiques, petits ajustements.

**Ce que ces agents ne font pas**
- Ne prennent pas en charge de tâches de fond nécessitant un grand contexte.
- Ne valident pas le travail des agents principaux.
