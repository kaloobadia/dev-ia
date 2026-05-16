# Commande /todo

## Rôle

Afficher le fichier TODO du jour, charger des tâches en session, et synchroniser les complétions vers le fichier journal.

---

## Étape 1 — Lire le fichier TODO du jour

1. Calculer la date du jour (TZ = Paris) au format `YY/MM/DD` et `YYMMDD`.
2. Chercher dans `./journal/YY/MM/DD/` un fichier dont le nom contient `TODO` (insensible à la casse).
3. Si aucun fichier n'existe : le signaler et proposer d'en créer un (`YYMMDD-HHhMM-TODO.md`). S'arrêter là.
4. Si plusieurs fichiers existent : demander lequel utiliser via AskUserQuestion.
5. Lire et afficher le contenu intégral du fichier trouvé.

## Étape 2 — Chargement sélectif en session (TaskCreate)

1. Extraire toutes les tâches non cochées `- [ ] …` du fichier.
2. Si aucune tâche non cochée : l'indiquer et s'arrêter.
3. Afficher la liste numérotée des tâches non cochées et demander via AskUserQuestion lesquelles charger en session (multiSelect).
4. Créer une tâche de session (TaskCreate) pour chaque tâche sélectionnée, en reprenant le texte exact.

## Étape 3 — Mise à jour du fichier lors des complétions

Quand une tâche de session est marquée `completed` (TaskUpdate) :
1. Identifier la ligne correspondante `- [ ]` dans le fichier journal.
2. Proposer via AskUserQuestion de la cocher `- [X]` dans le fichier.
3. Si accepté : modifier le fichier journal en remplaçant `- [ ]` par `- [X]` sur cette ligne uniquement.

## Règles

- Ne jamais modifier le fichier journal sans confirmation explicite via AskUserQuestion.
- Le fichier journal est la source de vérité persistante ; les tâches de session en sont un reflet éphémère.
- Respecter scrupuleusement la convention de nommage définie dans CLAUDE.md.
- Le dossier journal est toujours relatif au répertoire de travail courant.
