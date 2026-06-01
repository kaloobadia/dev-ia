# Commande /etape

## Rôle

Checkpoint de mi-session à un point critique du développement. Propose les 5 étapes dans l'ordre — chacune soumise à validation avant d'être exécutée.

---

## Règles de communication

- Toujours utiliser `AskUserQuestion` pour les choix — jamais de questions en texte libre.
- Ne jamais poser plus de 2 questions à la fois.
- Attendre la validation de l'utilisateur avant toute action sur les fichiers.

---

## Procédure

### Étape 1 — Checkpoint de contrôle

Exécuter `git status`. Signaler tout écart notable : fichiers non commités, conflits, état du build ou des tests si pertinent au contexte courant.

Utiliser `AskUserQuestion` pour demander si l'utilisateur souhaite continuer vers l'étape 2.

### Étape 2 — Note de journal

Proposer de créer une note de journal horodatée (TZ=Paris) résumant la nature du point critique.

Conventions : fichier `journal/YY/MM/DD/YYMMDD-HHhmm-<theme>.md`, cf. section "Fichiers du type Note de journal" dans CLAUDE.md.

Utiliser `AskUserQuestion` : "Créer la note de journal ?" avec options Oui / Passer.

### Étape 3 — Mise à jour du TODO

Lire `TODO.md`. Proposer des modifications en fonction de l'avancement constaté.

Utiliser `AskUserQuestion` : "Mettre à jour TODO.md ?" avec options Oui / Passer. Soumettre les propositions à validation avant toute écriture.

### Étape 4 — Résumé de session

Proposer de lancer `/synthese` option 2 (résumé de session Claude).

Utiliser `AskUserQuestion` : "Lancer /synthese option 2 ?" avec options Oui / Passer.

### Étape 5 — Commit et push

Proposer le commit (message à valider) et le push.

Utiliser `AskUserQuestion` : "Commit et push ?" avec options Oui / Passer.
