# Commande /synthese

## Rôle

Tu es un assistant de gestion de projet. Cette commande gère la mémoire des sessions de travail — côté Claude (résumé de session) et côté utilisateur (synthèse pour l'Atelier Obsidian).

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
└── journal/YY/MM/DD/                ← TODO et notes horodatés (pas de TODO.md à la racine)
```

---

## Démarrage — Choix de l'option

Au lancement de `/synthese`, utiliser `AskUserQuestion` pour présenter ce menu :

```
Que souhaitez-vous faire ?
1. Lire l'index du journal pour reprendre le fil du projet
2. Résumé de session (mémoire Claude)
3. Synthèse pour l'Atelier Obsidian (mémoire utilisateur)
4. Résumé de session + Synthèse pour l'Atelier Obsidian (les deux)
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

1. Créer `docs/journal/YYYY-MM-DD/YYMMDD-HHhmm-resume-session.md` avec en-tête YAML :

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

# Résumé de session — YYYY-MM-DD HHhmm
```

2. Ajouter une ligne dans `docs/journal/index-journal.md` :

```
| YYMMDD-HHhmm | [[YYYY-MM-DD/YYMMDD-HHhmm-resume-session\|thème]] | dates | ["tag1", "tag2"] | Prochaines étapes |
```

3. Mettre à jour `C:\Users\Guillaume\Documents\dev\atelier\ressources\latest-syntheses.md` — remplacer la ligne du projet courant avec le nouveau fichier et la date.

4. Mettre à jour `C:\Users\Guillaume\Documents\dev\atelier\Dashboard.md` — voir section "Mise à jour de Dashboard.md".

---

## Option 3 — Synthèse pour l'Atelier Obsidian (mémoire utilisateur)

### Étape 1 — Lire et synthétiser

Lire automatiquement tous les dossiers dans `docs/journal/YYYY-MM-DD/`. Produire en une seule réponse :
- La synthèse structurée (décisions et arbitrages, points pédagogiques, questions ouvertes, références utiles)
- Les **dates couvertes** (ex: "2026-05-02 à 2026-05-03")
- Les tags proposés (3 à 5, format listé avec guillemets : `["tag1", "tag2"]`)
- Le nom de fichier proposé au format `YYMMDD-HHhmm-synthese-journal.md`

### Étape 2 — Validation en une question

Utiliser `AskUserQuestion` avec deux options : "Tout me convient" et "Reprendre depuis le début". L'option "Other" est automatiquement disponible pour toute modification.

### Étape 3 — Créer et mettre à jour les index

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

**3c — Mettre à jour latest-syntheses.md**
3. Mettre à jour `C:\Users\Guillaume\Documents\dev\atelier\ressources\latest-syntheses.md` — remplacer la ligne du projet courant avec le nouveau fichier, la date, et le lien `obsidian://open?vault=<nom-du-vault>&file=<chemin-encodé>`.

**3d — Mettre à jour Dashboard.md**
4. Mettre à jour `C:\Users\Guillaume\Documents\dev\atelier\Dashboard.md` — voir section "Mise à jour de Dashboard.md".

**3e — Synthèse des TODO**
5. Identifier les fichiers TODO pertinents : tous ceux **créés ou modifiés depuis la dernière synthèse** (via `git log`, fichiers dont le nom contient `TODO` dans `journal/`). Si aucune synthèse précédente, retenir tous les TODO ayant encore au moins une checkbox ouverte (`[ ]`, `[?]` ou `[!]`). Conventions complètes : `IA/workflow/instructions/TODO-conventions.md`.

Les lire et ajouter en fin de fichier de synthèse une section résumant l'état de chaque TODO par type de checkbox :

- `[x]` tâche accomplie
- `[ ]` tâche en attente
- `[?]` point en suspens
- `[!]` point critique

```markdown
## État des TODO

### [nom-du-fichier](lien)

- **Accomplies [x] :** …
- **En attente [ ] :** …
- **En suspens [?] :** … *(si présent)*
- **Critiques [!] :** … *(si présent)*
```

---

## Option 4 — Résumé de session + Synthèse pour l'Atelier Obsidian (les deux)

Cette option exécute les Options 2 et 3 en séquence, avec un horodatage partagé.

### Étape 1 — Produire les deux contenus en une seule réponse

Récupérer l'heure exacte (heure de Paris) — c'est l'horodatage partagé pour les deux fichiers.

Produire en une seule réponse :
- **Résumé de session** (cf. Option 2, Étape 1) : décisions, fichiers produits, état d'avancement, erreurs, prochaines étapes
- **Synthèse pour l'Atelier Obsidian** (cf. Option 3, Étape 1) : décisions et arbitrages, points pédagogiques, questions ouvertes, références utiles ; dates couvertes
- Les tags proposés pour chaque document (3 à 5 chacun)
- Les noms de fichiers proposés :
  - `YYMMDD-HHhmm-resume-session.md`
  - `YYMMDD-HHhmm-synthese-journal.md`
  - (même horodatage pour les deux)

### Étape 2 — Validation en une question

Utiliser `AskUserQuestion` avec deux options : "Tout me convient" et "Reprendre depuis le début". L'option "Other" est disponible pour toute modification.

### Étape 3 — Créer les fichiers et mettre à jour les index

Exécuter dans l'ordre :

**3a — Créer le résumé de session** (cf. Option 2, Étape 3, points 1 à 2 — sans mettre à jour Dashboard.md)

**3b — Créer la synthèse pour l'Atelier Obsidian** (cf. Option 3, Étape 3, points 3a à 3b — sans mettre à jour Dashboard.md)

**3c — Mettre à jour `latest-syntheses.md`**
Mettre à jour `C:\Users\Guillaume\Documents\dev\atelier\ressources\latest-syntheses.md` — utiliser le lien vers la synthèse pour l'Atelier Obsidian (mémoire utilisateur, prioritaire pour Obsidian).

**3d — Mettre à jour `Dashboard.md`** (cf. section "Mise à jour de Dashboard.md") — une seule fois, en combinant les prochaines étapes des deux documents.

**3e — Synthèse des TODO** (cf. Option 3, étape 3e) — ajouter la section en fin de la synthèse pour l'Atelier Obsidian.

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
