Note de journal — création le 15/06/2026 à 16h26, dernière mise à jour le 15/06/2026 à 16h26

# Mise en place de l'indexation automatique de Documents

## Contexte

Session de configuration réalisée le 15/06/2026. L'objectif était de planifier l'exécution périodique du script `index_folder.py` sur le dossier `C:\Users\Guillaume\Documents`.

## Ce qui a été fait

### Modification de `index_folder.py`

Ajout de l'option `--only-if-changed` (`-c`) : le script ne ré-indexe un dossier que si au moins un fichier y est plus récent que l'`index.md` existant. Cela évite les indexations inutiles. Fichier : `C:\Users\Guillaume\Documents\dev\scripts\index_folder.py`.

### Nouveaux scripts créés

Tous dans `C:\Users\Guillaume\Documents\dev\scripts\` :

- **`run_daily_index.py`** — wrapper qui lance `index_folder.py --only-if-changed` sur `C:\Users\Guillaume\Documents` (récursion illimitée, exclusions par défaut) et enregistre la date d'exécution dans `.last_run`.

- **`check_index_startup.py`** — script à lancer à chaque ouverture de session Windows. Vérifie si `.last_run` date d'aujourd'hui ; si non, affiche une boîte de dialogue Windows (via `ctypes.windll.user32.MessageBoxW`) proposant de lancer l'indexation immédiatement.

- **`setup_tasks.ps1`** — script PowerShell à exécuter une fois (en administrateur) pour créer deux tâches dans le Planificateur de tâches Windows :
  - `IndexFolders-Daily` : tous les jours à 08h30, lance `run_daily_index.py`
  - `IndexFolders-StartupCheck` : à chaque ouverture de session, lance `check_index_startup.py`

### Tâche Cowork désactivée

Une tâche Cowork (`daily-folder-index`) avait été créée en cours de session puis abandonnée au profit de l'approche Windows Task Scheduler. Elle a été désactivée.

## Action manuelle restante

Exécuter `setup_tasks.ps1` une fois (clic droit → "Exécuter avec PowerShell") pour activer les tâches planifiées Windows.

## Dépendances

Aucune dépendance externe. Le script `check_index_startup.py` utilise uniquement `ctypes` (bibliothèque standard Python).
