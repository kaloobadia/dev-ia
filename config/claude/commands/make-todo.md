# Commande /make-todo

## Rôle

Ajouter un bloc daté de tâches dans `TODO.md` à la racine du projet courant.
Ne jamais écraser le contenu existant — toujours ajouter en fin de fichier.

---

## Étape 1 — Vérifier l'existence de TODO.md

1. Chercher `TODO.md` à la racine du répertoire de travail courant.
2. Si le fichier n'existe pas : le créer avec l'en-tête minimal suivant, puis continuer.

```markdown
# TODO — <nom-du-projet>

*Créé le YYYY-MM-DD. Mis à jour par /make-todo.*

---
```

## Étape 2 — Recueillir les tâches à ajouter

Utiliser `AskUserQuestion` pour demander le thème du bloc à créer.
Les tâches elles-mêmes sont fournies par l'utilisateur dans la conversation — ne pas les inventer.

## Étape 3 — Ajouter le bloc daté

1. Récupérer l'heure exacte (TZ = Paris) :
   - Windows : `powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::UtcNow, 'Romance Standard Time').ToString('yyMMdd-HH\hmm')"`
2. Ajouter en fin de `TODO.md` le bloc suivant (sans écraser l'existant) :

```markdown
## YYMMDD-HHhmm — <thème>

- [ ] tâche 1
- [ ] tâche 2
```

3. Confirmer l'ajout à l'utilisateur.

## Règles

- Ne jamais écraser `TODO.md` — uniquement des ajouts en fin de fichier.
- `TODO.md` est la source de vérité des tâches actives du projet.
- Les tâches accomplies sont cochées `[x]` directement dans `TODO.md`.
- Ne jamais créer de fichiers TODO dans `journal/` — les TODOs vont dans `TODO.md`.
- Exception : les TODO thématiques de grande taille (>10 items) peuvent rester dans `journal/` avec un item de référence dans `TODO.md`.
