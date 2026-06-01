# Conventions TODO

Applicable à tous les projets. Chaque projet dispose d'un `TODO.md` à la racine, mis à jour en continu. Les snapshots horodatés sont créés par `/synthese` dans `todo/YY/MM/DD/`.

---

## Règle — TODO avant implémentation

Tout plan validé par l'utilisateur doit être suivi d'un fichier TODO horodaté **avant** le début de l'implémentation.

Séquence obligatoire : **plan → TODO → implémentation**.

Les TODO a posteriori (créés après coup pour tracer ce qui a déjà été fait) sont à proscrire. Ils contournent la planification et réduisent la traçabilité. Si un plan a été exécuté sans TODO préalable, signaler l'écart dans le résumé de session et ne pas créer de TODO a posteriori.

---

## États des checkbox

| Marqueur | Signification |
|---|---|
| `[ ]` | Tâche en attente |
| `[x]` | Tâche accomplie |
| `[?]` | Point en suspens — décision ou information manquante |
| `[!]` | Point critique — bloquant ou à traiter en priorité |

---

## Sélection des TODO lors de `/synthese`

Chercher le TODO actif dans cet ordre :
1. `TODO.md` à la racine du projet (s'il existe et contient au moins une checkbox ouverte)
2. Sinon, le fichier le plus récent dans `todo/` dont le nom contient `TODO` et ayant au moins une checkbox ouverte (`[ ]`, `[?]`, `[!]`)

Pour la section "État des TODO" de la synthèse : retenir les fichiers TODO **créés ou modifiés depuis la dernière synthèse**, identifiables via `git log`.

Si aucune synthèse précédente n'existe, retenir tous les TODO ouverts du projet.

---

## Nommage

**TODO actif** : `TODO.md` à la racine du projet. Mis à jour en continu au fil des sessions.

**Snapshots horodatés** : créés automatiquement par `/synthese` en fin de session.

```
todo/YY/MM/DD/YYMMDD-HHhmm-TODO.md
```

Exemple : `todo/26/05/23/260523-06h15-TODO.md`
