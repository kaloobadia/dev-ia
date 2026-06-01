A l'attention de Claude, des autres IA et de leurs agents

## Impératif
Utiliser AskUserQuestion systématiquement. Ne jamais tutoyer l'utilisateur. Ne jamais utiliser d'emojis — ni dans les fichiers, ni dans le code, ni dans la conversation.

## Shell
- **Attention :** Ceci est un système Windows mais WSL, GitBash sont présents.
- **Outil à utiliser :** Toujours préférer l'outil `Bash` (Git Bash / WSL) pour les commandes shell. N'utiliser l'outil `PowerShell` que si une commande est strictement impossible en Bash sur ce système. Si Powershell est utilisé, attention à ne pas utiliser `&&` pour relier des commandes, la bonne syntaxe PowerShell est `commande 1 ; commande 2`.

- **Heure de Paris : Pour obtenir l'heure de Paris, utiliser : 
	- dans un shell Powershell : [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('HH\hmm')
	- dans un shell Bash : Bash(powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('HH\hmm')") 

## Caractères accentués
- **Attention :** Conserver les caractères accentués dans le code. L'environnement est un système Windows en anglais, mais certaines variables (date, clavier, monnaie ...) sont en français, ce qui peut induire en erreur. 

## Dossier journal (transverse à tous les projets)
- **Structure :** Chaque projet comporte un dossier `journal/YY/MM/DD/` créé au fil des jours de travail.
- **Contenu :** Ce dossier du jour accueille tous les documents horodatés : notes de journal, TODO, plans d'implémentation, et tout contenu destiné à être relu ou archivé.

## Fichiers du type "Note de journal"
- **Conventions applicables:** Le fichier doit être horodaté (TZ=Paris) et mentionner le thème de la proposition. Il doit être enregistré dans le dossier ./journal/<YY>/<MM>/<DD>/. Le résultat doit être : ./journal/<YY>/<MM>/<DD>/<YYMMDD-HH[h]hh-<theme_en_quelques_mots>.md. Exemple : ./journal/26/05/10/260510-14h15-notice_convention_noms.md
- **Première ligne obligatoire :** La première ligne du fichier doit être du texte brut (pas d'emphase, pas de heading), au format suivant : `Note de journal — création le JJ/MM/AAAA à HHhMM, dernière mise à jour le JJ/MM/AAAA à HHhMM`. Cette contrainte est imposée par la règle Markdown MD036 (emphase interdite en début de fichier ou directement sous un heading). La date de mise à jour est identique à la date de création lors de la première écriture.

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

## 12 règles de programmation 

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