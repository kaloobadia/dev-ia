# Commande /archiver-todo

## Rôle

Archiver le TODO général `~/Documents/TODO.md` en deux étapes obligatoires. La deuxième est le coeur du travail : sans elle, le TODO gonfle et perd sa valeur de tableau de bord.

## Étape 1 — Snapshot daté

1. Récupérer l'heure de Paris : `powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('yyMMdd-HH\hmm')"`
2. Copier l'état actuel de `~/Documents/TODO.md` vers `~/Documents/archives/todo/YY/MM/DD/YYMMDD-HHhmm-snapshot-todo.md` (créer le dossier du jour si besoin).
3. Mettre à jour le pointeur en tête du TODO (`dernier : <chemin du snapshot>`).

## Étape 2 — Ménage du TODO actif

1. Retirer de `TODO.md` les sections et items marqués FAIT qui n'ont plus de valeur de reprise.
2. Ne conserver que les items EN COURS, EN ATTENTE, URGENT et BACKLOG.

## Règles

- Exécuter les deux étapes dans l'ordre, sans attendre de confirmation entre les deux.
- Compte-rendu : chemins et lignes seulement, jamais le contenu recopié.
- Origine : souvenir `feedback_archiver_todo` (l'assistant avait cru terminer après la seule étape 1).
