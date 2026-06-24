# Directives issues de calibration-dials à recopier dans CLAUDE.md

Note de journal : création le 21/06/2026 à 15h29, dernière mise à jour le 21/06/2026 à 15h29

## Objet

Brouillon de travail. Extraire de `levers.json` (plugin `dufis1/calibration-dials`) les seules directives qui ajoutent quelque chose à votre `CLAUDE.md` existant, sans installer le plugin. Source verbatim : https://github.com/dufis1/calibration-dials/blob/main/skills/calibrate/levers.json

## Tri : ce qui est déjà couvert, ce qui est net-neuf

| Axe (cran) | Déjà couvert chez vous ? | Verdict |
| --- | --- | --- |
| Detail (Standard/Brief) | Oui — ponytail impose déjà la sortie la plus courte qui marche | Redondant |
| Presentation | Partiellement — ponytail, typographie | Redondant |
| Tone (Formal) | Oui — vouvoiement, no-emoji, français clair | Redondant |
| Autonomy (Check key decisions) | Oui — AskUserQuestion systématique + mémoire `feedback_suppositions_decision` | Doublon, mais reformulation possiblement plus nette |
| Rigor (Balanced) | Non — vous avez une culture de pushback (Rule 1, Rule 7, ponytail) mais aucun niveau de rigueur par défaut explicite | Net-neuf |

Conclusion paresseuse : un seul ajout réellement utile, le niveau de rigueur par défaut. Le reste duplique des règles que vous avez déjà, en moins contextualisé.

## Candidat net-neuf — niveau de rigueur par défaut (à coller)

Adaptation française du cran « Balanced » de Rigor. À placer dans `~/.claude/CLAUDE.md` (et sa copie versionnée `config/claude/CLAUDE.md`, pour respecter l'invariant de synchronisation).

```markdown
## Niveau de rigueur par défaut
Évaluation franchement équilibrée : exposer les vraies forces et les vraies
faiblesses à poids comparable, ouvrir sur une lecture pondérée plutôt que sur
les problèmes. Signaler les points faibles principaux sans s'y appesantir. Ne
pas se borner à valider, mais ne pas non plus chercher activement à casser
l'idée (ce serait un cran adverse, à n'activer que sur demande ponctuelle).
```

Texte source (verbatim, anglais) pour mémoire :

> Balanced — Give a genuinely even-handed assessment: present the real strengths and the real weaknesses with roughly equal weight, and lead with a balanced read rather than with problems. Note the main weak points without dwelling on them. Don't simply cheerlead, but don't tip into actively trying to break the idea either — that's a more adversarial setting.

## Option — affiner la règle d'autonomie existante

Si vous jugez votre formulation actuelle perfectible, le cran « Check key decisions » la dit plus nettement (un seul arbitrage pivot demandé, le reste sur suppositions explicitées). Texte source verbatim :

> Check key decisions — Identify the single most consequential ambiguity in the request — the one decision that most changes the result — and ask the user about THAT one before producing the main deliverable, waiting on their answer. State any minor assumptions explicitly but proceed on them. Do NOT interrogate every detail or propose a stage-by-stage sign-off plan, and do NOT just deliver the whole thing on your own assumptions.

À traiter comme remplacement éventuel de `feedback_suppositions_decision`, pas comme ajout (sinon doublon).

## Rappels de mise en oeuvre

- Ne pas installer le plugin : seul le contenu de `levers.json` est repris.
- Toute écriture dans `~/.claude/CLAUDE.md` doit être répercutée dans `config/claude/CLAUDE.md` (vérifier au `diff`).
- Rien de tout cela ne tranche la question modèle/effort de la note de reprise ; ce sont des leviers de comportement, orthogonaux au choix du modèle.
