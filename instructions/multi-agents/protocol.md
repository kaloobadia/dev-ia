# Protocole de collaboration IA

*Créé le 2026-05-13 13h51 (Paris)*

---

## Méthode de travail

Schéma d'orchestration IA défini dans `AGENTS.md` et `.agents/`.
Artefacts de coordination (specs / output / validation) dans `collab/`.
Notes, observations d'un agent à l'autre dans `collab/`. Format : ./collab/phase-<n>/<etape>/<YYMMDD>-<HH>h<mm>-observation-<agent>.md ; exemple : .260513-20h25-observations-gemini.md

---

## Flux de travail par tâche

```

1. Claude rédige specs.md  →  2. Gemini écrit le code + output.md  →  3. Claude rédige validation.md

```

### Etape 1 — Specs (Claude, amont)

Claude rédige un fichier `specs.md` dans le sous-dossier de la tâche.
Ce fichier contient :
- Objectif de la tâche (une ligne)
- Fichiers concernés (liste)
- Patterns à remplacer / invariants à préserver
- Ce qu'il ne faut pas toucher
- Critères de validation (ce que Claude vérifiera en aval)

### Etape 2 — Exécution (Gemini)

Gemini ne doit jamais agir sans autorisation explicite. 
Gemini lit `specs.md`, modifie les fichiers du projet, puis dépose un `output.md` contenant :
- Liste des fichiers modifiés
- Résumé des changements effectués
- Points d'attention ou décisions prises en l'absence d'instruction explicite

### Etape 3 — Validation (Claude, aval)

Claude relit les fichiers modifiés (via `git diff` ou lecture directe) et `output.md`,
puis rédige `validation.md` avec :
- Statut : VALIDE / REFUSE / REVISION
- Points validés
- Points à corriger (si REVISION ou REFUSE)
- Prochaine étape

---

## Structure des artefacts

Les artefacts sont placés dans `collab/YY/MM/DD/[theme]/[etape]/` :

```
collab/YY/MM/DD/[theme]/[etape]/YYMMDD-HHhmm-[agent]-[theme]-[tache].md
```

Les sous-dossiers d'étape sont toujours `définitions/`, `productions/`, `validations/`.
Leur ordre alphabétique (d < p < v) est aligné sur l'ordre du flux de travail.

```
collab/
└── 26/05/15/
    └── ia-locale/
        ├── définitions/
        │   ├── 260515-19h23-claude-ia-locale-specs-brief.md
        │   └── 260515-19h36-claude-ia-locale-specs-architecture.md
        ├── productions/
        │   └── 260515-HHhmm-gemini-ia-locale-specs-architecture.md
        └── validations/
            └── 260515-HHhmm-claude-ia-locale-validation-architecture.md
```

Convention complète (alias, longueurs, types par agent) :
`collab/26/05/15/convention-agents/définitions/260515-19h43-claude-convention-noms-agents-v1.2.md`

**Observations intermédiaires** : si un agent pose une question ou signale un point
en cours d'exécution, il dépose un fichier horodaté :
`YYMMDD-HHhmm-[agent]-[theme]-obs-[sujet].md`

**Cycle de correction** : si la validation retourne REVISION, Gemini dépose un nouveau
fichier horodaté `output-v2-[tache]` et Claude répond par `validation-v2-[tache]`.

---

## Optimisations token

Ces pratiques réduisent le nombre de lectures de fichiers et d'allers-retours entre agents.

**Specs en bloc au démarrage**
En début de session, Claude rédige tous les `specs.md` du jour en un seul passage,
avant que Gemini commence à travailler. Cela évite d'ouvrir plusieurs sessions Claude
pour des allers-retours sur des specs intermédiaires.

**Gemini lit directement `/collab`**
Gemini est lancé dans un terminal VS Code et accède au système de fichiers du projet.
L'utilisateur lui indique le chemin du sous-dossier de la session — aucun copier-coller nécessaire.

**Validation par exception**
Gemini signale dans `output.md` (section "Décisions prises") tout choix fait
en l'absence d'instruction explicite. Claude valide uniquement ces points,
pas l'ensemble du diff.

**Note de contexte en début de session**
L'utilisateur fournit une note courte (voir `.agents/session-start.md`) pour orienter
Claude sans exploration du codebase. Économie typique : 5 à 10 lectures de fichiers.

---

## Règles de nommage

Convention v1.2 (active depuis 2026-05-15 19h43) :

```
collab/YY/MM/DD/[theme]/[etape]/YYMMDD-HHhmm-[agent]-[theme]-[tache].md
```

- `[theme]` : kebab-case, sous-dossier ET segment du nom de fichier
- `[etape]` : `définitions/` | `productions/` | `validations/`
- `[agent]` : alias officiel, 8 car. max (voir `AGENTS.md`, section "Alias des agents")
- `[tache]` : kebab-case, 30 car. max

Convention complète : `collab/26/05/15/convention-agents/définitions/260515-19h43-claude-convention-noms-agents-v1.2.md`

