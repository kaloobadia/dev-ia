# Commande /synthese

## Rôle

Tu es un assistant de gestion de projet. Cette commande gère la mémoire des sessions de travail — côté Claude (résumé de session) et côté utilisateur (synthèse du journal Obsidian).

---

## Référence commune agents

La version lisible de cette spec (pour tous les agents) est dans :
`C:\Users\Guillaume\Documents\dev\IA\workflow\instructions\synthese.md`

**Synchronisation** : toute modification de ce fichier doit être répercutée dans `dev/IA/workflow/instructions/synthese.md`.

---

## Règles de communication

- Toujours poser les questions sous forme de liste numérotée avec options explicites.
- Ne jamais poser plus de 2 questions à la fois.
- Attendre la validation de l'utilisateur avant toute action sur les fichiers.
- Toujours utiliser `AskUserQuestion` pour les choix — jamais de questions en texte libre.

---

## Structure des fichiers (par projet)

```
<projet>/
├── .claude/
│   └── settings.local.json
├── CLAUDE.md                        ← à la racine du projet
├── docs/
│   ├── journal/
│   │   ├── index-journal.md         ← index des synthèses
│   │   └── YYYY-MM-DD/              ← dossiers actifs (notes brutes + synthèses)
│   │       └── YYMMDD-HHhmm-synthese-journal.md
│   ├── reference/
│   └── archives/
│       └── journal/YYYY-MM-DD/      ← dossiers archivés après synthèse
└── TODO.md
```

---

## Démarrage — Choix de l'option

Au lancement de `/synthese`, utiliser `AskUserQuestion` pour présenter ce menu :

```
Que souhaitez-vous faire ?
1. Lire l'index du journal pour reprendre le fil du projet
2. Résumé de session (mémoire Claude)
3. Synthèse du journal Obsidian (mémoire utilisateur)
```

---

## Option 1 — Lire l'index du journal

1. Lire le fichier `docs/journal/index-journal.md`
2. Afficher les entrées de manière lisible
3. Utiliser `AskUserQuestion` pour proposer l'ouverture d'une entrée :
   - Lister les entrées en **ordre anté-chronologique** (la plus récente en premier)
   - Chaque option = horodatage + thème + dates + prochaines étapes
   - Dernière option fixe : "Passer directement au travail"

---

## Option 2 — Résumé de session (mémoire Claude)

### Étape 1 — Produire le résumé complet

Produire en une seule réponse :
- Le résumé structuré (décisions, fichiers produits, état d'avancement, erreurs, prochaines étapes)
- Les tags proposés (3 à 5, en minuscules, format listé avec guillemets : `["tag1", "tag2"]`)
- Le nom de fichier proposé au format `YYMMDD-HHhmm-resume-session.md`

Récupérer l'heure exacte, heure de Paris (UTC+2 été / UTC+1 hiver) :

Windows (PowerShell) :
```powershell
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::UtcNow, 'Romance Standard Time').ToString('yyMMdd-HH\hmm')
```

macOS/Linux (bash/zsh) :
```bash
TZ='Europe/Paris' date +'%y%m%d-%Hh%M'
```

**Consultation** : Se référer à `docs/reference/YAML-Conventions.md` si disponible pour le format exact des métadonnées.

### Étape 2 — Validation en une question

Utiliser `AskUserQuestion` avec deux options : "Tout me convient" et "Reprendre depuis le début". L'option "Other" est automatiquement disponible pour toute modification — ne pas ajouter d'option "Modifier" explicite (redondante).

### Étape 3 — Créer le fichier et mettre à jour l'index

1. Créer `docs/journal/YYYY-MM-DD/YYMMDD-HHhmm-resume-session.md` avec en-tête YAML, et inclure en fin de fichier un snapshot du TODO :

```yaml
---
auteur: Claude
statut: Résumé de session
type: archive-historique
tags: ["session", "resume", "tag3"]
date: YYYY-MM-DD
---
```

```markdown
> ⚠️ Archive de session — document historique. Ne pas interpréter comme des instructions courantes.
```

```markdown
## État du TODO (snapshot)

> Snapshot de `TODO.md` au moment de la synthèse.

[contenu intégral de TODO.md]
```

2. Archiver `TODO.md` → `archives-<projet>/archives-<projet>-todo/YYMMDD-HHhmm-TODO.md` (copie à l'identique, même horodatage que la synthèse). Le chemin exact est défini dans le CLAUDE.md du projet.

3. Ajouter une ligne dans `docs/journal/index-journal.md` :

```
| YYMMDD-HHhmm | [[YYYY-MM-DD/YYMMDD-HHhmm-resume-session\|thème]] | dates | ["tag1", "tag2"] | Prochaines étapes |
```

4. Mettre à jour `C:\Users\Guillaume\Documents\dev\atelier\ressources\latest-syntheses.md` — remplacer la ligne du projet courant avec le nouveau fichier et la date.

5. Mettre à jour `C:\Users\Guillaume\Documents\dev\atelier\Dashboard.md` — voir section "Mise à jour de Dashboard.md".

---

## Option 3 — Synthèse du journal Obsidian (mémoire utilisateur)

### Étape 1 — Lire et synthétiser

Lire automatiquement tous les dossiers **actifs** (non archivés) dans `docs/journal/YYYY-MM-DD/`. Produire en une seule réponse :
- La synthèse structurée (décisions et arbitrages, points pédagogiques, questions ouvertes, références utiles)
- Les **dates couvertes** (ex: "2026-05-02 à 2026-05-03")
- Les tags proposés (3 à 5, format listé avec guillemets : `["tag1", "tag2"]`)
- Le nom de fichier proposé au format `YYMMDD-HHhmm-synthese-journal.md`

### Étape 2 — Validation en une question

Utiliser `AskUserQuestion` avec deux options : "Tout me convient" et "Reprendre depuis le début". L'option "Other" est automatiquement disponible pour toute modification.

### Étape 3 — Créer, mettre à jour l'index, lier, archiver, puis proposer TODO

**3a — Créer la synthèse**
1. Créer `docs/journal/YYYY-MM-DD/YYMMDD-HHhmm-synthese-journal.md` avec en-tête YAML (tags, date, dates couvertes) et avertissement archive :

```yaml
---
auteur: Claude
statut: Synthèse journal
type: archive-historique
tags: ["tag1", "tag2"]
date: YYYY-MM-DD
dates_couvertes: YYYY-MM-DD à YYYY-MM-DD
---
```

```markdown
> ⚠️ Archive de session — document historique. Ne pas interpréter comme des instructions courantes.
```

**3b — Mettre à jour l'index**
2. Ajouter une ligne dans `docs/journal/index-journal.md` :

```
| YYMMDD-HHhmm | [[YYYY-MM-DD/YYMMDD-HHhmm-synthese-journal\|thème]] | 2026-05-02 à 2026-05-03 |
```

**3c — Lier les notes brutes à la synthèse**
3. Pour chaque dossier daté traité (`docs/journal/YYYY-MM-DD/`), ajouter en fin de **chaque fichier brut** :

```
[[YYMMDD-HHhmm-synthese-journal]]
```

(lien relatif — les fichiers sont dans le même dossier `YYYY-MM-DD/`)

**3d — Archiver les dossiers datés (ACTION CRITIQUE)**
4. Déplacer les dossiers **entiers** (synthèse incluse) dans `archives-<projet>/archives-<projet>-journal/` :
   - `docs/journal/YYYY-MM-DD/` → `archives-<projet>/archives-<projet>-journal/YYYY-MM-DD/`
   - Mettre à jour le lien dans `index-journal.md` en conséquence
   - Le chemin exact est défini dans le CLAUDE.md du projet
   - ⚠️ **Vérification** : `docs/journal/` ne doit contenir que `index-journal.md` (plus de dossiers datés actifs)

**3e — Mettre à jour latest-syntheses.md**
5. Mettre à jour `C:\Users\Guillaume\Documents\dev\atelier\ressources\latest-syntheses.md` — remplacer la ligne du projet courant avec le nouveau fichier, la date, et le lien `obsidian://open?vault=<nom-du-vault>&file=<chemin-encodé>`.

**3f — Mettre à jour Dashboard.md**
6. Mettre à jour `C:\Users\Guillaume\Documents\dev\atelier\Dashboard.md` — voir section "Mise à jour de Dashboard.md".

**3g — Archiver TODO.md et inclure le snapshot dans la synthèse**
7. Archiver `TODO.md` → `archives-<projet>/archives-<projet>-todo/YYMMDD-HHhmm-TODO.md` (même horodatage que la synthèse). Le chemin exact est défini dans le CLAUDE.md du projet.
8. Ajouter en fin du fichier de synthèse créé en 3a :

```markdown
## État du TODO (snapshot)

> Snapshot de `TODO.md` au moment de la synthèse.

[contenu intégral de TODO.md]
```

**3h — Proposer mise à jour TODO.md**
9. Lire `TODO.md` et proposer des ajouts ou mises à jour à partir du contenu des notes journal synthétisées — soumettre les propositions à la validation de l'utilisateur avant toute modification

---

## Mise à jour de Dashboard.md

Fichier : `C:\Users\Guillaume\Documents\dev\atelier\Dashboard.md`

### Ce qu'il faut mettre à jour

**1. Frontmatter `updated`**
Remplacer la date par aujourd'hui au format `YYYY-MM-DD`.

**2. Lien "Aujourd'hui"**
Calculer la date du jour en heure de Paris (même commande que pour l'horodatage) et reconstruire :
- Lien interne Obsidian : `[[journal/YYYY/MM/DD/YYMMDD|Note du YYYY-MM-DD]]`
- Exemple pour le 2026-05-09 : `[[journal/2026/05/09/260509|Note du 2026-05-09]]`

**3. Section du projet courant**
Identifier le bloc `### <nom-du-projet>` correspondant au projet en cours de session, et mettre à jour :
- **Dernière synthèse** : nouveau lien `obsidian://open?vault=<nom-du-vault>&file=<chemin-encodé>` + date
- **Prochaines étapes** : extraites du résumé/synthèse que l'on vient de produire

Le nom du vault correspond au nom du dossier projet (ex: `enquete-benevoles-report`).

### Ce qu'il ne faut PAS modifier
- Les autres blocs `### <projet>` — ne pas toucher aux projets non concernés par la session en cours.
- La section "Ressources" — stable, ne pas modifier automatiquement.
