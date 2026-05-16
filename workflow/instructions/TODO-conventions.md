# Conventions TODO

Applicable à tous les projets. Les fichiers TODO sont horodatés et journalisés dans `journal/YY/MM/DD/` — pas de `TODO.md` à la racine.

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

Retenir les fichiers TODO **créés ou modifiés depuis la dernière synthèse**, identifiables via `git log` en filtrant les fichiers dont le nom contient `TODO` dans `journal/`.

Si aucune synthèse précédente n'existe, retenir tous les fichiers TODO ouverts du projet (au moins une checkbox `[ ]`, `[?]` ou `[!]` encore présente).

---

## Nommage

Suivre la convention générale des notes de journal :

```
journal/YY/MM/DD/YYMMDD-HHhmm-TODO-<theme>.md
```

Exemple : `journal/26/05/17/260517-00h55-TODO-wrapper-tui.md`
