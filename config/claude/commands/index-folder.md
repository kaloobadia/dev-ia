# Commande /index-folder

## Rôle

Indexe un ou plusieurs sous-dossiers du répertoire courant dans des fichiers `index.md`, via le script `index_folder.py`.

Argument optionnel : `/index-folder <chemin>` — si fourni, indexer directement ce dossier sans passer par la sélection interactive.

---

## Étape 1 — Lister les sous-dossiers

Si un argument est fourni (`$ARGUMENTS`), passer directement à l'étape 3 avec ce chemin.

Sinon, lancer :

```bash
find . -maxdepth 1 -mindepth 1 -type d | sort
```

Afficher la liste numérotée des sous-dossiers trouvés.

---

## Étape 2 — Choisir le(s) dossier(s) à indexer

Utiliser `AskUserQuestion` avec les options :
- "Tous les sous-dossiers listés"
- "Le dossier courant seulement (.)"
- "Un dossier spécifique (préciser via Other)"

---

## Étape 3 — Lancer l'indexation

Pour chaque dossier retenu, exécuter :

```bash
python "C:/Users/Guillaume/Documents/dev/scripts/index_folder.py" "<dossier>"
```

Options disponibles si l'utilisateur les précise :
- `--depth N` : profondeur maximale de récursion
- `--no-recursive` : ne pas descendre dans les sous-dossiers
- `--exclude MOTIF` : exclure des motifs glob (ex : `.git` `*.tmp`)

Par défaut : récursif, profondeur illimitée, aucune exclusion.

---

## Étape 4 — Rapport

Afficher le résumé produit par le script pour chaque dossier indexé (nombre de fichiers/dossiers, chemin du fichier généré).
