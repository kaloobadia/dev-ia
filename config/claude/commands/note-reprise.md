# Commande /note-reprise

## Rôle

Clore une session de travail en produisant une note de reprise et en l'inscrivant dans le TODO général, qui est le point d'entrée unique de reprise.

## Étape 1 — Rédiger la note de reprise

1. Récupérer l'heure de Paris : `powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('yyMMdd-HH\hmm')"`
2. Créer la note dans `journal/YY/MM/DD/YYMMDD-HHhmm-note_reprise_<theme>.md` du projet concerné, selon les conventions de note de journal (H1 puis horodatage en texte brut, cf. `chantiers/dev/IA/workflow/instructions/conventions-documentaires.md`).
3. Contenu : état du chantier, ce qui est fait et vérifié, ce qui reste, pointeurs complets vers les artefacts.

## Étape 2 — Inscrire le pointeur dans le TODO général

1. Éditer `~/Documents/TODO.md`, dans la section du chantier concerné.
2. Ajouter une mention « Note de reprise (date) » avec le chemin complet de la note et, le cas échéant, des artefacts liés.
3. Respecter la structure existante du TODO (ordre anté-chronologique, détail renvoyé au `journal/`).

## Règles

- Chemins complets et copiables, jamais de référence vague.
- Compte-rendu : chemins et lignes seulement.
- Origine : souvenir `feedback_note_reprise_todo`.
