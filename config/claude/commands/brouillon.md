# Commande /brouillon

## Rôle

Créer un fichier brouillon horodaté dans le journal du projet courant pour toute rédaction destinée à être lue ou éditée par l'utilisateur. Ne jamais écraser un fichier de notes existant.

## Étapes

1. Récupérer l'heure de Paris : `powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('yyMMdd-HH\hmm')"`
2. Créer `journal/YY/MM/DD/YYMMDD-HHhmm-brouillon_<theme>.md` (créer le dossier du jour si besoin), selon les conventions de note de journal (H1 puis horodatage en texte brut, cf. `chantiers/dev/IA/workflow/instructions/conventions-documentaires.md`).
3. Y rédiger le contenu proposé. L'utilisateur gère lui-même l'intégration éventuelle dans un document final.

## Règles

- Interdiction d'utiliser Write sur un fichier de notes existant (`travaux/`, notes `X.0`, notes de journal déjà écrites) pour y mettre de la prose ; la modification d'une note existante exige une proposition en conversation et une confirmation préalable.
- Jamais d'insertion directe dans un document final : toujours ce brouillon, puis la main à l'utilisateur.
- Compte-rendu : chemin du fichier créé, en texte copiable.
- Origine : souvenirs `feedback_brouillon_nouveaux_fichiers` et `feedback_proposer_avant_modif_notes` ; retour du 14/06/2026.
