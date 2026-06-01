Note de journal — création le 23/05/2026 à 14h40, dernière mise à jour le 23/05/2026 à 14h40

# Convention — Fichiers "Note de journal"

Source de référence : `~/.claude/CLAUDE.md`, section "Fichiers du type Note de journal".

---

## Nom de fichier

Format : `YYMMDD-HHhmm-<theme_en_quelques_mots>.md`

Emplacement : `<projet>/journal/YY/MM/DD/`

Exemple : `journal/26/05/10/260510-14h15-notice_convention_noms.md`

L'horodatage est en heure de Paris (TZ=Paris).

---

## Première ligne obligatoire

La première ligne du fichier doit être du texte brut (ni emphase, ni heading), au format :

```
Note de journal — création le JJ/MM/AAAA à HHhMM, dernière mise à jour le JJ/MM/AAAA à HHhMM
```

Exemple :

```
Note de journal — création le 23/05/2026 à 14h18, dernière mise à jour le 23/05/2026 à 14h22
```

**Pourquoi cette contrainte :** la règle Markdown MD036 interdit l'emphase (`*texte*`) en début de fichier ou directement sous un heading. Sans texte brut préalable, un italique en première ligne déclenche un warning de linter.

La date de mise à jour est identique à la date de création lors de la première écriture du fichier.

---

## Structure minimale

```markdown
Note de journal — création le JJ/MM/AAAA à HHhMM, dernière mise à jour le JJ/MM/AAAA à HHhMM

# Titre

Contenu...
```
