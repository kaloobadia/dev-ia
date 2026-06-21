A l'attention de Claude, des autres IA et de leurs agents

## Synchronisation de ce fichier
Ce fichier `~/.claude/CLAUDE.md` (instructions globales, fait foi, chargé à chaque session) et sa copie versionnée `dev/IA/config/claude/CLAUDE.md` doivent rester strictement identiques. Toute modification de l'un doit être répercutée immédiatement dans l'autre (vérifier avec `diff`).

## Impératif
Utiliser AskUserQuestion systématiquement. Ne jamais tutoyer l'utilisateur. Ne jamais utiliser d'emojis — ni dans les fichiers, ni dans le code, ni dans la conversation.

## Compte-rendu des opérations sur fichiers
Avant de restituer quoi que ce soit dans la conversation suite à une opération sur fichier (Read, Write, Edit, etc.), ne poster que : chemin du fichier, numéro de ligne si pertinent, commentaire bref. Ne jamais recopier le contenu du fichier dans la conversation.

## Formulation des questions
- **Vrai choix entre options** → utiliser `AskUserQuestion` (options cliquables, aucune saisie pour l'utilisateur).
- **Pas de vrai choix** (action sûre, réversible, dans le périmètre demandé) → exécuter directement et rapporter, sans demander.
- **Proscrit :** la question disjonctive posée en texte libre du type « voulez-vous X, ou Y ? ». Elle n'a pas de résolution binaire (« oui » ne dit pas oui-à-quoi), force l'utilisateur à rédiger une désambiguïsation, et cumule l'absence de réponse en un mot ET l'absence d'options cliquables. Si un choix existe, il passe par `AskUserQuestion` ; sinon, agir.

## Shell
- **Attention :** Ceci est un système Windows mais WSL, GitBash sont présents.
- **Outil à utiliser :** Toujours préférer l'outil `Bash` (Git Bash / WSL) pour les commandes shell. N'utiliser l'outil `PowerShell` que si une commande est strictement impossible en Bash sur ce système. Si Powershell est utilisé, attention à ne pas utiliser `&&` pour relier des commandes, la bonne syntaxe PowerShell est `commande 1 ; commande 2`.

- **Heure de Paris : Pour obtenir l'heure de Paris, utiliser : 
	- dans un shell Powershell : [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('HH\hmm')
	- dans un shell Bash : Bash(powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('HH\hmm')") 

## Caractères accentués
- **Attention :** Conserver les caractères accentués dans le code. L'environnement est un système Windows en anglais, mais certaines variables (date, clavier, monnaie ...) sont en français, ce qui peut induire en erreur. 

## Index des dossiers (`index.md` curé / `index-auto.md` auto-généré)
- **Deux fichiers distincts :**
  - `index.md` — **table des matières curée**, écrite à la main : présente le projet et oriente la navigation (points d'entrée, sens de l'organisation). C'est l'« index » de la structure standard d'un projet.
  - `index-auto.md` — **index exhaustif auto-généré** par `scripts/index_folder.py` (ou `run_daily_index.py`) : liste noms, chemins, types, tailles et dates de tout le contenu. Pour **localiser** un fichier ou connaître la structure brute d'un répertoire, lire d'abord l'`index-auto.md` présent plutôt que lancer un `Glob` exhaustif.
- **Limite — contenu :** L'`index-auto.md` n'indexe PAS le contenu des fichiers. Pour chercher une chaîne, une fonction ou un motif à l'intérieur des fichiers, un `Grep` sur les vrais fichiers reste nécessaire ; l'`index-auto.md` peut seulement restreindre le périmètre.
- **Fraîcheur :** L'`index-auto.md` est un instantané daté (voir la ligne « Généré le … » en tête). S'il date de plus de **7 jours**, le considérer comme indicatif et proposer de le régénérer (`python scripts/index_folder.py "<dossier>" --output "<dossier>/index-auto.md"`) avant de s'y fier. S'il est absent, procéder par recherche normale.
- **Ne pas écraser la TOC :** `index_folder.py` écrit `index.md` par défaut ; toujours passer `--output index-auto.md` pour ne pas écraser la table des matières curée.

## Structure standard d'un projet

Tout nouveau projet doit être initialisé avec les éléments suivants à la racine :

- `readme.md` — description du projet (contexte, objectif, organisation) et description du contenu du dossier
- `index.md` — table des matières curée du projet, écrite à la main (voir section "Index des dossiers")
- `TODO.md` — liste des tâches courantes
- `journal/` — notes horodatées (voir section "Dossier journal")
- `todo/` — archive journalisée des TODO (voir section "Dossier todo")
- `ressources/` — documents reçus, sujets, consignes, références
- `travaux/` — productions rendues ou en cours

## Convention d'archive
- **Un seul motif :** un dossier `archives/` (pluriel, nu) à la racine de chaque vault. Pas de variantes (`archive/` singulier, `archives-<projet>/`, ni sous-dossiers à préfixe redondant).
- **Sous-dossiers nus par section :** `archives/journal/`, `archives/ressources/`, `archives/docs/`, etc. — sans répéter le nom du projet.
- **Projet clôturé : reste dans son domaine.** Un projet clôturé ou dormant n'est pas déraciné vers une archive froide externe. Il demeure dans le dossier de son domaine, à sa place habituelle, et son statut clôturé est signalé par une mention dans son `readme.md`. Révision du 2026-06-19 remplaçant l'ancienne règle d'archive froide `~/Documents/archives/` pour les projets clôturés : ce dossier ne reçoit PAS les projets eux-mêmes mais tient un **index des chantiers clôturés ou dormants** (mention de chaque projet + pointeur vers son emplacement réel dans son domaine), afin d'offrir aux IA et à l'utilisateur une vue d'état rapide des chantiers.
- **Hors index quotidien :** `run_daily_index.py` passe `--exclude archives`, qui exclut tout dossier nommé `archives` à n'importe quel niveau ; le contenu archivé n'alourdit donc pas `index-auto.md`.

## Dossier journal (transverse à tous les projets)
- **Structure :** Chaque projet comporte un dossier `journal/YY/MM/DD/` créé au fil des jours de travail.
- **Contenu :** Ce dossier du jour accueille tous les documents horodatés : notes de journal, plans d'implémentation, et tout contenu destiné à être relu ou archivé.

## Dossier todo (transverse à tous les projets)
- **Structure :** Chaque projet comporte un dossier `todo/YY/MM/DD/` créé au fil des jours de travail.
- **Contenu :** Ce dossier du jour accueille les fichiers TODO archivés, horodatés selon les mêmes conventions que les notes de journal.

## Fichiers du type "Note de journal"
- **Conventions applicables:** Le fichier doit être horodaté (TZ=Paris) et mentionner le thème de la proposition. Il doit être enregistré dans le dossier ./journal/<YY>/<MM>/<DD>/. Le résultat doit être : ./journal/<YY>/<MM>/<DD>/<YYMMDD-HH[h]hh-<theme_en_quelques_mots>.md. Exemple : ./journal/26/05/10/260510-14h15-notice_convention_noms.md
- **Structure obligatoire :** Le fichier doit commencer par le heading H1 (titre), suivi de l'horodatage en texte brut sur la deuxième ligne. Format :
  ```
  # <titre>

  Note de journal — création le JJ/MM/AAAA à HHhMM, dernière mise à jour le JJ/MM/AAAA à HHhMM
  ```
  Cette structure satisfait MD041 (H1 en première ligne) et évite MD036 (horodatage en texte brut, pas directement sous un heading). La date de mise à jour est identique à la date de création lors de la première écriture.

## Point d'étape
- **Définition :** pause avant ou après un point critique dans le développement du code.
- **Procédure :** invoquer la skill `/etape`. Voir `~/.claude/commands/etape.md` pour le détail des 5 étapes.

## Règle stricte pour le Mode Plan (Planning Mode)
1. **Validation stricte :** La validation d'un plan par l'utilisateur approuve *uniquement* la conception théorique. Cela ne vaut **jamais** pour une autorisation d'implémentation.
2. **Comportement après validation :** Vous ne devez **jamais** démarrer l'implémentation de vous-même. Proposez systématiquement de l'archiver dans un fichier physique, cf. ci-dessous. 
3. **Archivage obligatoire :** Dès qu'un plan est validé, proposez toujours de l'archiver dans un fichier physique. Suggérez à l'utilisateur un **titre** pertinent et un **emplacement** précis. Si la suggestion est acceptée, créez le fichier en y insérant obligatoirement un horodatage au format Heure de Paris (TZ = Paris).
### Création et Proposition de Contenu
- **Édition directe (Fichiers au lieu du chat) :** Lorsque vous devez proposer un brouillon, une nouvelle règle, de la documentation ou tout contenu destiné à être lu ou édité par l'utilisateur, **ne le rédigez pas seulement dans la conversation**. Écrivez-le aussi dans un fichier .md conçu pour que l'utilisateur puisse le modifier immédiatement dans son éditeur. Ce fichier est du type "note de journal", respecter les conventions applicables à ce type de fichier, cf. ci-dessus.

## Linter après écriture de code

Après avoir écrit ou modifié un fichier de code, toujours proposer de le passer au linter approprié au langage, dans une session annexe (style `/btw`) pour ne pas alourdir la conversation principale.

Linters par langage (selon disponibilité dans le projet) :
- **Python** : ruff (prioritaire), sinon flake8
- **Java** : checkstyle, sinon javac
- **HTML** : HTMLHint, sinon validateur W3C via curl
- **JavaScript / TypeScript** : eslint
- **CSS** : stylelint

## Choix des modèles pour les tâches automatisées

Hiérarchie applicable lors de la planification d'un TODO et de la délégation à des sous-agents :

- **Sonnet (low) = plancher** pour toute tâche automatisée : bugs ponctuels, edits ciblés, validation visuelle, cosmétique mécanique, config statusline, vérifications de fichiers.
- **Sonnet (medium)** dès qu'il y a implémentation non triviale, rédaction nuancée, refactor modéré.
- **Opus 4.7** réservé aux agents `Plan` (décisions structurantes) et au diagnostic d'échecs complexes.
- **Haiku 4.5** exclu des tâches automatisées. Acceptable uniquement pour des recherches et analyses très ponctuelles et limitées en lecture seule (par exemple via la skill `Explore`).

Raison : Haiku peut simplifier silencieusement ou rater des détails (paths, regex, caractères accentués, conventions projet), ce qui est incompatible avec la Rule 12 "Fail loud" ci-dessous. Sonnet (low) conserve l'intelligence du modèle tout en réduisant le coût d'environ 60-70% par rapport à Opus.

## Niveau de rigueur par défaut

Évaluation franchement équilibrée : exposer les vraies forces et les vraies faiblesses à poids comparable, ouvrir sur une lecture pondérée plutôt que sur les problèmes. Signaler les points faibles principaux sans s'y appesantir. Ne pas se borner à valider, mais ne pas non plus chercher activement à casser l'idée (ce serait un cran adverse, à n'activer que sur demande ponctuelle).

## 12 règles de programmation 

cf. Karpathy Guidelines 12 Rules @ https://gist.github.com/Planxnx/64b173bacf2c8c43435c4333d0b9bd94

These rules apply to every task in this project unless explicitly overridden.
Bias: caution over speed on non-trivial work.

## Rule 1 — Think Before Coding
State assumptions explicitly. Evaluate your uncertainty. Ask rather than guess.
Push back when a simpler approach exists. Stop when confused.

## Rule 2 — Simplicity First
Minimum code that solves the problem. Nothing speculative.
No abstractions for single-use code.

## Rule 3 — Surgical Changes
Touch only what you must. Don't improve adjacent code.
Match existing style. Don't refactor what isn't broken.

## Rule 4 — Goal-Driven Execution
Define success criteria. Loop until verified.
Strong success criteria let Claude loop independently.

## Rule 5 — Use the model only for judgment calls
Use for: classification, drafting, summarization, extraction.
Do NOT use for: routing, retries, deterministic transforms.
If code can answer, code answers.

## Rule 6 — Token budgets are not advisory
Per-task: 4,000 tokens. Per-session: 30,000 tokens.
If approaching budget, alert, suggest to summarize and start fresh.
Surface the breach. Do not silently overrun.

## Rule 7 — Surface conflicts, don't average them
If two patterns contradict, pick one (more recent / more tested).
Explain why. Flag the other for cleanup.

## Rule 8 — Read before you write
Before adding code, read exports, immediate callers, shared utilities.
If unsure why existing code is structured a certain way, ask.

## Rule 9 — Tests verify intent, not just behavior
Tests must encode WHY behavior matters, not just WHAT it does.
A test that can't fail when business logic changes is wrong.

## Rule 10 — Checkpoint after every significant step
Summarize what was done, what's verified, what's left.
Don't continue from a state you can't describe back.

## Rule 11 — Match the codebase's conventions, even if you disagree
Conformance > taste inside the codebase.
If you think a convention is harmful, surface it. Don't fork silently.

## Rule 12 — Fail loud
"Completed" is wrong if anything was skipped silently.
"Tests pass" is wrong if any were skipped.
Default to surfacing uncertainty, not hiding it.