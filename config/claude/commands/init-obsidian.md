# Commande /init-obsidian

## Rôle

Initialise un nouveau dossier de projet avec la structure standard. Cette commande est auto-suffisante — elle embarque la définition complète de la structure et ne dépend pas de la mémoire de session.

---

## Structure standard

```
<projet>/
├── readme.md          ← description du projet + contenu du dossier
├── index-thematique.md           ← table des matières (instantané daté)
├── index-journal.md   ← index des synthèses de session
├── TODO.md            ← liste des tâches courantes
├── journal/YY/MM/DD/  ← notes horodatées (dossier du jour créé)
├── archives/todo/YY/MM/DD/  ← archive journalisée des TODO (dossier du jour créé)
├── ressources/        ← documents reçus, consignes, références
└── travaux/           ← productions rendues ou en cours
```

---

## Règles de communication

- Toujours utiliser `AskUserQuestion` pour les choix — jamais de questions en texte libre.
- Ne jamais poser plus de 2 questions à la fois.
- Attendre la validation de l'utilisateur avant toute action sur les fichiers.
- Aucun anglicisme dans les fichiers produits ni dans la conversation.

---

## Procédure

### Étape 1 — Collecte d'informations

Exécuter les actions suivantes **sans demander** :

1. Lire le nom du dossier courant (répertoire de travail).
2. Lister le contenu du dossier : fichiers et sous-dossiers existants.
3. Récupérer l'heure et la date de Paris :
```bash
powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('HH\hmm')"
powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('yyMMdd')"
```
4. Identifier les fichiers existants qui n'appartiennent **pas** à la structure standard (c'est-à-dire : tout ce qui n'est pas `journal/`, `archives/`, `ressources/`, `travaux/`, `readme.md`, `index-thematique.md`, `index-journal.md`, `TODO.md`).

Puis utiliser `AskUserQuestion` pour recueillir :
- La description courte du projet (contexte, objectif — servira dans readme.md)
- Si des fichiers non-standard existent : faut-il les déplacer dans `ressources/` ?

### Étape 2 — Proposition de la structure

Afficher un récapitulatif clair distinguant :
- Ce qui **sera créé** (éléments absents du dossier)
- Ce qui **existe déjà** (à ne pas écraser)
- Les fichiers qui **seront déplacés** dans `ressources/` (si confirmé)

Utiliser `AskUserQuestion` : "Créer cette structure ?" — options : Oui / Annuler.

### Étape 3 — Création (après validation)

Dans l'ordre :

**3a — Dossiers**
Créer les dossiers manquants :
- `ressources/`
- `travaux/`
- `journal/YY/MM/DD/` (dossier du jour, date Paris)
- `archives/todo/YY/MM/DD/` (dossier du jour, date Paris)

**3b — Déplacement des fichiers existants**
Si confirmé à l'étape 1 : déplacer les fichiers non-standard dans `ressources/`.

**3c — readme.md** (si absent)
Créer avec :
- H1 : nom du dossier
- Horodatage Paris sur la deuxième ligne (format : `Créé le JJ/MM/AAAA à HHhMM.`)
- Description du projet fournie par l'utilisateur
- Tableau du contenu du dossier (tous les éléments créés)

**3d — index-thematique.md** (si absent)
Créer avec :
- H1 : `Index — <nom du dossier>`
- Ligne : `Généré le JJ/MM/AAAA à HHhMM. Pour régénérer : python scripts/index_folder.py "."`
- Tableau listant chaque élément du dossier (nom, type, description)

**3e — index-journal.md** (si absent)
Créer avec :
- H1 : `Index journal — <nom du dossier>`
- Tableau vide prêt à recevoir les entrées :
  `| Horodatage | Fichier | Dates couvertes | Tags | Prochaines étapes |`

**3f — TODO.md** (si absent)
Créer avec :
- H1 : `TODO — <nom du dossier>`
- Corps vide (aucune tâche fictive)

### Étape 4 — Vérification

Lister l'arborescence finale :
```bash
find . -not -path "*/\.*" | sort
```
Afficher le résultat et confirmer ce qui a été créé, ce qui existait déjà, et ce qui a été déplacé.

### Étape 5 — Configuration Obsidian (optionnel)

Utiliser `AskUserQuestion` : "Initialiser ce dossier comme vault Obsidian ?" — options : Oui / Passer.

Si Oui, créer le dossier `.obsidian/` avec les fichiers de configuration standard suivants :

**`.obsidian/app.json`**
```json
{
  "alwaysUpdateLinks": true,
  "showUnsupportedFiles": true,
  "spellcheck": false,
  "useTab": false,
  "readableLineLength": false,
  "showLineNumber": true
}
```

**`.obsidian/core-plugins.json`**
```json
{
  "file-explorer": true,
  "global-search": true,
  "switcher": true,
  "graph": true,
  "backlink": true,
  "canvas": true,
  "outgoing-link": true,
  "tag-pane": true,
  "footnotes": false,
  "properties": true,
  "page-preview": true,
  "daily-notes": true,
  "templates": true,
  "note-composer": true,
  "command-palette": true,
  "slash-command": false,
  "editor-status": true,
  "bookmarks": true,
  "markdown-importer": false,
  "zk-prefixer": true,
  "random-note": false,
  "outline": true,
  "word-count": true,
  "slides": false,
  "audio-recorder": false,
  "workspaces": false,
  "file-recovery": true,
  "publish": false,
  "sync": true,
  "bases": true,
  "webviewer": false
}
```

**`.obsidian/daily-notes.json`**
```json
{
  "format": "YYYY-MM-DD/YYMMDDHHmm",
  "folder": "/"
}
```

**`.obsidian/zk-prefixer.json`**
```json
{
  "folder": "journal",
  "format": "YYYY-MM-DD/YYMMDDHHmm"
}
```

Note : ces réglages alignent Obsidian sur la structure du projet (`journal/YY/MM/DD/`). Le format `YYYY-MM-DD/YYMMDDHHmm` crée automatiquement un sous-dossier par jour dans `journal/`.

### Étape 6 — Mise à jour Dashboard (optionnel)

Proposer d'ajouter le projet dans :
- `C:\Users\Guillaume\Documents\chantiers\dev\atelier\ressources\latest-syntheses.md`
- `C:\Users\Guillaume\Documents\chantiers\dev\atelier\Dashboard.md`

Utiliser `AskUserQuestion` : "Ajouter ce projet au Dashboard Obsidian ?" — options : Oui / Passer.

Si Oui :
- Ajouter une ligne dans `latest-syntheses.md` (colonnes : Project, Last synthesis, Date, Link — laisser Link vide pour l'instant)
- Ajouter un bloc `### <nom-du-projet>` dans `Dashboard.md` avec Dernière synthèse, Prochaines étapes et lien TODO

---

## Synchronisation de ce fichier

Toute modification doit être répercutée dans :
- `~/.claude/commands/init-obsidian.md` (primaire)
- `C:\Users\Guillaume\Documents\chantiers\dev\IA\config\claude\commands\init-obsidian.md` (copie versionnée)
