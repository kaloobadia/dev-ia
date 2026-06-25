# Commande /synthese

## Rôle

Tu es un assistant de gestion de projet. Cette commande gère la mémoire des sessions de travail — côté Claude (résumé de session) et côté utilisateur (synthèse pour l'Atelier Obsidian).

Copie unique : ce fichier (`~/.claude/commands/synthese.md`) est la seule version. Les anciennes copies versionnées et de référence ont été supprimées le 25/06/2026.

---

## Règles de communication

- Toujours poser les questions sous forme de liste numérotée avec options explicites.
- Ne jamais poser plus de 2 questions à la fois.
- Attendre la validation de l'utilisateur avant toute action sur les fichiers.
- Toujours utiliser `AskUserQuestion` pour les choix — jamais de questions en texte libre.

---

## Structure des fichiers (par projet)

```text
<projet>/
├── CLAUDE.md                        ← à la racine du projet
├── index-journal.md                 ← index des synthèses (racine projet)
├── TODO.md                          ← TODO courant (mis à jour en continu)
├── .claude/
│   └── settings.local.json
├── docs/
│   └── reference/
└── journal/YY/MM/DD/                ← notes brutes, snapshots TODO, resume-session ET synthèses
    └── YYMMDD-HHhmm-synthese-journal.md
```

---

## Pré-amble — Checkpoint de session

### Étape préalable — Proposition de point d'étape

Avant toute chose, utiliser `AskUserQuestion` : "Voulez-vous d'abord faire un point d'étape ?" avec options :

- "Oui, lancer /etape" — invoquer la skill `/etape` et attendre qu'elle soit terminée avant de poursuivre
- "Non, continuer la synthèse" — passer directement aux étapes A, B, C ci-dessous

**Si vous venez directement de `/etape`** (étapes 1-3 déjà réalisées), passer directement au menu d'options sans répéter les étapes A, B et C.

Ces trois étapes s'exécutent au lancement de `/synthese`, avant le menu d'options.

### Étape A — Checkpoint git

Exécuter `git status`. Signaler tout écart notable : fichiers non commités, conflits, état du build si pertinent.

### Étape B — Note de journal

Proposer de créer une note de journal horodatée (TZ=Paris) résumant la session en cours.

Conventions : `journal/YY/MM/DD/YYMMDD-HHhmm-<theme>.md`, cf. section "Fichiers du type Note de journal" dans CLAUDE.md.

Utiliser `AskUserQuestion` : "Créer une note de journal ?" avec options Oui / Passer.

### Étape C — Mise à jour du TODO

Chercher un TODO actif dans cet ordre de priorité :

1. `TODO.md` à la racine du projet (s'il existe et contient au moins une checkbox ouverte)
2. Sinon, le fichier le plus récent dans `journal/` dont le nom contient `TODO` et ayant au moins une checkbox ouverte (`[ ]`, `[?]`, `[!]`)

**Si un TODO actif est trouvé :** le lire et proposer des modifications en fonction de l'avancement constaté. Utiliser `AskUserQuestion` : "Mettre à jour le TODO ?" avec options Oui / Passer. Soumettre les propositions à validation avant toute écriture.

**Si aucun TODO actif n'est trouvé :** utiliser `AskUserQuestion` : "Aucun TODO actif trouvé. Créer un nouveau TODO ?" avec options Oui / Passer. Si Oui, créer `TODO.md` à la racine du projet avec un squelette de tâches basé sur le contexte de la session en cours, soumis à validation avant écriture.

---

## Démarrage — Choix de l'option

Au lancement de `/synthese`, après le pré-amble, utiliser `AskUserQuestion` pour présenter ce menu :

```text
Que souhaitez-vous faire ?
0. Triage des TODO + mise à jour de l'index
1. Lire l'index du journal pour reprendre le fil du projet
2. Produire une mémoire de clôture (résumé Claude et/ou synthèse Obsidian)
```

Si l'Option 2 est choisie, utiliser un second `AskUserQuestion` en **multi-sélection** pour savoir quelles mémoires produire :

- "Résumé de session (mémoire Claude)"
- "Synthèse pour l'Atelier Obsidian (mémoire utilisateur)"

Les deux peuvent être cochées : dans ce cas, les deux documents partagent un même horodatage et la mise à jour de `Dashboard.md` n'est faite qu'une fois.

---

## Pré-étape commune — Régénérer l'index

Cette pré-étape est partagée par les Options 0, 1 et 2. Avant de lire ou de produire, lancer :

```bash
index-journal --index-only
```

(Chemin à adapter selon le projet. Si le script n'existe pas, passer directement à la suite.)

---

## Option 0 — Triage des TODO + mise à jour de l'index

### Étape 1 — Collecter les TODO actifs

Chercher les TODO actifs dans deux emplacements :

1. `TODO.md` à la racine du projet (s'il existe et contient au moins une checkbox ouverte)
2. `journal/` récursivement : fichiers `*.md` dont le nom contient `TODO`, hors dossier `archive/`

Pour chaque fichier retenu, compter les tâches ouvertes (`[ ]`, `[?]`, `[!]`). Ignorer les fichiers sans tâche ouverte. Présenter `TODO.md` racine en premier (s'il existe), puis les fichiers `journal/` triés par âge décroissant (le plus ancien en premier).

### Étape 2 — Triage tâche par tâche

Pour chaque fichier TODO, afficher : nom du fichier, âge, nombre de tâches ouvertes. Compteur de progression "TODO N / total".

Utiliser `AskUserQuestion` avec les options :

- "Passer ce fichier"
- "Trier tâche par tâche"

Si "Trier tâche par tâche" : pour chaque tâche ouverte (texte affiché), utiliser `AskUserQuestion` :

- "Clôturer [x]"
- "Garder"

Écrire le fichier modifié immédiatement après chaque TODO traité.

### Étape 3 — Bilan et archivage

Afficher le bilan : TODOs passés en revue / modifiés / entièrement clos.

Pour les TODOs entièrement clos, utiliser `AskUserQuestion` :

- "Archiver les TODOs clos"
- "Garder en place"

Si archivage : déplacer vers `archive/journal/...` en préservant l'arborescence (via `shutil.move`).

Ensuite, collecter les résumés de session (`resume-session`) et synthèses (`synthese-journal`) de plus de 7 jours. Si des fichiers sont éligibles, utiliser `AskUserQuestion` :

- "Archiver les entrées journal éligibles"
- "Garder en place"

### Étape 4 — Régénérer l'index

Relancer la pré-étape commune "Régénérer l'index", puis confirmer la régénération avec le nombre de sessions et TODOs indexés.

---

## Option 1 — Lire l'index du journal

(Pré-étape commune "Régénérer l'index" appliquée au préalable.)

1. Lire le fichier `index-journal.md` (à la racine du projet)
2. Afficher les entrées de manière lisible
3. Utiliser `AskUserQuestion` pour proposer l'ouverture d'une entrée :
   - Lister les entrées en **ordre anté-chronologique** (la plus récente en premier)
   - Chaque option = horodatage + thème + dates + prochaines étapes
   - Dernière option fixe : "Passer directement au travail"

---

## Option 2 — Produire une mémoire de clôture

Cette option produit, selon les cases cochées au démarrage, un résumé de session (mémoire Claude), une synthèse pour l'Atelier Obsidian (mémoire utilisateur), ou les deux. La pré-étape commune "Régénérer l'index" s'applique au préalable.

### Étape 1 — Produire les contenus en une seule réponse

Récupérer une seule fois l'heure exacte, heure de Paris (UTC+2 été / UTC+1 hiver) — c'est l'horodatage partagé pour tous les fichiers produits.

Windows (PowerShell) :

```powershell
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::UtcNow, 'Romance Standard Time').ToString('yyMMdd-HH\hmm')
```

macOS/Linux (bash/zsh) :

```bash
TZ='Europe/Paris' date +'%y%m%d-%Hh%M'
```

Produire en une seule réponse, pour chaque mémoire cochée :

**Si "Résumé de session" est coché :**

- Le résumé structuré (décisions, fichiers produits, état d'avancement, erreurs, prochaines étapes)
- Les tags proposés (3 à 5, en minuscules, format listé avec guillemets : `["tag1", "tag2"]`)
- Le nom de fichier proposé : `YYMMDD-HHhmm-resume-session.md`

**Si "Synthèse pour l'Atelier Obsidian" est coché :**

- Lire automatiquement tous les dossiers dans `journal/YY/MM/DD/`
- La synthèse structurée (décisions et arbitrages, points pédagogiques, questions ouvertes, références utiles)
- Les **dates couvertes** (ex: "2026-05-02 à 2026-05-03")
- Les tags proposés (3 à 5)
- Le nom de fichier proposé : `YYMMDD-HHhmm-synthese-journal.md`

**Consultation** : se référer à `docs/reference/YAML-Conventions.md` si disponible pour le format exact des métadonnées.

### Étape 2 — Validation en une question

Utiliser `AskUserQuestion` avec deux options : "Tout me convient" et "Reprendre depuis le début". L'option "Other" est automatiquement disponible pour toute modification — ne pas ajouter d'option "Modifier" explicite (redondante).

### Étape 3 — Persister

Pour chaque mémoire cochée, appliquer la section "Persistance d'une entrée journal" ci-dessous avec le type correspondant (`resume-session` ou `synthese-journal`).

Si la synthèse Obsidian est cochée, lui ajouter en fin de fichier la section "État des TODO" (voir ci-dessous).

Mettre à jour `Dashboard.md` **une seule fois** (voir section "Mise à jour de Dashboard.md") :

- si les deux mémoires sont produites, combiner les prochaines étapes des deux documents et pointer la synthèse Obsidian comme dernière synthèse (mémoire utilisateur, prioritaire pour Obsidian) ;
- si une seule est produite, pointer celle-là.

---

## Persistance d'une entrée journal

Section paramétrée par le **type** (`resume-session` ou `synthese-journal`). Appliquée par l'Option 2 pour chaque mémoire produite.

### 1 — Créer le fichier

Créer `journal/YY/MM/DD/YYMMDD-HHhmm-<type>.md` avec en-tête YAML et avertissement archive.

Pour `resume-session` :

```yaml
---
auteur: Claude
statut: Résumé de session
type: archive-historique
tags: ["session", "resume", "tag3"]
date: YYYY-MM-DD
---
```

Pour `synthese-journal` (ajouter le champ `dates_couvertes`) :

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

Avertissement (les deux types) :

```markdown
> ⚠️ Archive de session — document historique. Ne pas interpréter comme des instructions courantes.
```

Titre H1 pour `resume-session` : `# Résumé de session — YYYY-MM-DD HHhmm`.

### 2 — Mettre à jour l'index du journal

Ajouter une ligne dans `index-journal.md` (à la racine du projet).

Pour `resume-session` :

```text
| YYMMDD-HHhmm | [[YY/MM/DD/YYMMDD-HHhmm-resume-session\|thème]] | dates | ["tag1", "tag2"] | Prochaines étapes |
```

Pour `synthese-journal` :

```text
| YYMMDD-HHhmm | [[YY/MM/DD/YYMMDD-HHhmm-synthese-journal\|thème]] | 2026-05-02 à 2026-05-03 |
```

La mise à jour de `Dashboard.md` n'est pas faite ici : elle est centralisée une seule fois à l'étape 3 de l'Option 2.

---

## État des TODO (synthèse Obsidian uniquement)

Identifier les fichiers TODO pertinents : tous ceux **créés ou modifiés depuis la dernière synthèse** (via `git log`, fichiers dont le nom contient `TODO` dans `journal/`). Si aucune synthèse précédente, retenir tous les TODO ayant encore au moins une checkbox ouverte (`[ ]`, `[?]` ou `[!]`). Conventions complètes : `IA/workflow/instructions/TODO-conventions.md`.

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

## Mise à jour de Dashboard.md

Fichier : `C:\Users\Guillaume\Documents\dev\atelier\Dashboard.md`

### Ce qu'il faut mettre à jour

#### 1. Frontmatter `updated`

Remplacer la date par aujourd'hui au format `YYYY-MM-DD`.

#### 2. Lien "Aujourd'hui"

Calculer la date du jour en heure de Paris (même commande que pour l'horodatage) et reconstruire :

- Lien interne Obsidian : `[[journal/YYYY/MM/DD/YYMMDD|Note du YYYY-MM-DD]]`
- Exemple pour le 2026-05-09 : `[[journal/2026/05/09/260509|Note du 2026-05-09]]`

#### 3. Section du projet courant

Identifier le bloc `### <nom-du-projet>` correspondant au projet en cours de session, et mettre à jour :

- **Dernière synthèse** : nouveau lien `obsidian://open?vault=<nom-du-vault>&file=<chemin-encodé>` + date
- **Prochaines étapes** : extraites du résumé/synthèse que l'on vient de produire

Le nom du vault correspond au nom du dossier projet (ex: `enquete-benevoles-report`).

### Ce qu'il ne faut PAS modifier

- Les autres blocs `### <projet>` — ne pas toucher aux projets non concernés par la session en cours.
- La section "Ressources" — stable, ne pas modifier automatiquement.

---

## Clôture — Commit et push

Cette étape s'exécute après toute option (0-2), en fin de `/synthese`.

### Snapshot TODO.md

Avant le commit : si `TODO.md` existe à la racine du projet, en créer une copie horodatée dans `todo/` :

```text
todo/YYMMDD-HHhmm-TODO.md
```

(Horodatage Paris — même commande que pour les résumés de session.)
Ne pas créer le snapshot si `TODO.md` est vide ou absent.

### Commit et push

Afficher la liste des fichiers qui seraient commités (résultat de `git status`). Proposer un message de commit.

Utiliser `AskUserQuestion` avec trois options :

- "Commiter et pousser"
- "Commiter sans push"
- "Passer"
