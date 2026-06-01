# Démarrage de session — protocole et modèle

*Créé le 2026-05-15 13h28 (Paris)*

---

## Objectif

Orienter Claude (ou tout autre agent) en début de session sans exploration du codebase.
Fournir ce fichier rempli à Claude au lieu de laisser l'agent lire et inférer le contexte.
Économie typique : 5 à 10 lectures de fichiers évitées.

---

## Modèle de note de contexte

Copier-coller le bloc ci-dessous, remplir les champs, transmettre à Claude en début de session.

```
## Contexte de session — 26/MM/DD HHhMM

### Phase en cours
Phase X — [thème court, ex : "rapports DOCX/PPTX"]

### Dernière session (résumé)
[2-3 lignes : ce qui a été fait, ce qui a été validé, ce qui a été mis en attente]

### Tâches du jour
- NN-[nom-tache] : [fichier(s) concerné(s) + objectif en une ligne]
- NN-[nom-tache] : ...

### Dossier collab de la session
collab/26/MM/DD/collab-26MMDD-[theme]/

### Contraintes ou points d'attention
[Ce qu'il ne faut pas toucher, dépendances fragiles, choix déjà arbitrés]
```

---

## Consignes pour Claude

Quand ce modèle est fourni en début de session :

- Ne pas explorer le codebase avant d'avoir lu ce contexte.
- Rédiger tous les `specs.md` du jour en un seul passage (cf. "Optimisations token" dans `protocol.md`).
- Si un champ du modèle est insuffisant, poser une question ciblée plutôt que d'inférer.

---

## Consignes pour Gemini

- Lire le dossier `collab/` indiqué dans la note de contexte.
- Exécuter les tâches dans l'ordre des numéros de sous-dossiers.
- Pour chaque tâche, lire `specs.md`, modifier les fichiers du projet, déposer `output.md`.
- Dans `output.md`, signaler explicitement tout choix fait en l'absence d'instruction (section "Décisions prises").
