# Commande /synthese

## Rôle

Produire la synthèse utilisateur d'une session de travail (mémoire pour l'Atelier Obsidian) : une note horodatée dans `journal/`, indexée, référencée dans `latest-syntheses.md`, puis répercutée dans les Dashboard par script déterministe.

Copie unique : ce fichier (`~/.claude/commands/synthese.md`) est la seule version.

## Règles de communication

- Toujours utiliser `AskUserQuestion` pour les choix, jamais de questions en texte libre.
- Attendre la validation de l'utilisateur avant toute écriture de fichier.

## Séquence

### 1 — Horodatage partagé

Récupérer une seule fois l'heure de Paris (UTC+2 été / UTC+1 hiver). Cet horodatage sert pour le nom de fichier, l'index et `latest-syntheses.md`.

Windows (PowerShell) :

```powershell
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::UtcNow, 'Romance Standard Time').ToString('yyMMdd-HH\hmm')
```

macOS/Linux (bash/zsh) :

```bash
TZ='Europe/Paris' date +'%y%m%d-%Hh%M'
```

### 2 — Rédiger la synthèse

Lire le contenu de `journal/YY/MM/DD/` (toutes les notes du jour, et des jours couverts par la session). Produire en une seule réponse :

- La synthèse structurée : décisions et arbitrages, points pédagogiques, questions ouvertes, références utiles.
- Les **dates couvertes** (ex. `2026-05-02 à 2026-05-03`).
- Les tags proposés (3 à 5, en minuscules).
- Le nom de fichier proposé : `YYMMDD-HHhmm-synthese-journal.md`.

Si `docs/reference/YAML-Conventions.md` existe, s'y référer pour le format exact des métadonnées.

### 3 — Valider

`AskUserQuestion` avec deux options : « Tout me convient » et « Reprendre depuis le début ». L'option « Other » couvre toute modification ponctuelle.

### 4 — Écrire la note

Créer `journal/YY/MM/DD/YYMMDD-HHhmm-synthese-journal.md` avec en-tête YAML :

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

Puis l'avertissement d'archive :

```markdown
> Archive de session — document historique. Ne pas interpréter comme des instructions courantes.
```

### 5 — Indexer

Ajouter une ligne dans `index-journal.md` (racine du projet) :

```text
| YYMMDD-HHhmm | [[YY/MM/DD/YYMMDD-HHhmm-synthese-journal\|thème]] | 2026-05-02 à 2026-05-03 |
```

### 6 — Mettre à jour la source de vérité du Dashboard

Source unique : `C:\Users\Guillaume\Documents\chantiers\dev\atelier\ressources\latest-syntheses.md`.

Dans le tableau principal (`| Project | Last synthesis | Date | Link |`), repérer la ligne du projet courant (= nom du dossier projet). La remplacer si elle existe, l'ajouter sinon. Les quatre colonnes sont obligatoires, sinon le script ignore la ligne :

```text
| <projet> | <titre de la synthèse> | <YYYY-MM-DD> | [open](obsidian://open?vault=<projet>&file=<chemin-encodé sans .md>) |
```

- **Date** au format ISO `YYYY-MM-DD` (heure de Paris) : le script s'en sert pour la fenêtre de fraîcheur de 7 jours.
- **Chemin** : `/` encodé en `%2F`, extension `.md` omise (ex. `journal%2F26%2F06%2F27%2F260627-02h48-synthese-journal`).
- Ne pas toucher aux autres lignes ni à la section `## Global`. Aucune section « Prochaines étapes » à écrire ici : le script l'extrait lui-même de la note liée.

### 7 — Régénérer les Dashboard

```bash
python "C:\Users\Guillaume\Documents\chantiers\dev\scripts\update_dashboard.py" --inplace
```

Le script réécrit les trois `Dashboard.md` (routage par domaine automatique depuis les `index.md` de hub). Vérifier sa sortie. En cas de `non classé` inattendu, rattacher le projet dans la section « Projets actifs » ou « Dormants » de l'`index.md` du hub voulu, ne pas corriger le Dashboard à la main.
