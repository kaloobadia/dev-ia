# Commande /revision-souvenirs

## Rôle

Rituel périodique de révision des souvenirs : consolidation du contenu et contrôle de complétude de l'index. Remède à la péremption silencieuse.

## Étape 1 — Consolidation

Invoquer la skill `anthropic-skills:consolidate-memory` (fusion des doublons, correction des faits périmés, élagage). Toute suppression ou fusion de contenu est proposée à l'utilisateur avant exécution.

## Étape 2 — Contrôle de complétude bidirectionnelle de l'index

Dans `~/.claude/projects/C--Users-Guillaume-Documents/memory/`, vérifier :

1. que chaque fichier `.md` (hors `MEMORY.md`) a sa ligne dans `MEMORY.md` ;
2. que chaque ligne de `MEMORY.md` pointe vers un fichier existant.

Contrôle exécutable :

```bash
cd "/c/Users/Guillaume/.claude/projects/C--Users-Guillaume-Documents/memory" && for f in *.md; do [ "$f" = "MEMORY.md" ] && continue; grep -q "($f)" MEMORY.md || echo "ABSENT DE L'INDEX : $f"; done; grep -oE '\(([a-z_0-9]+\.md)\)' MEMORY.md | tr -d '()' | while read f; do [ -f "$f" ] || echo "LIGNE ORPHELINE : $f"; done
```

## Étape 3 — Contrôle des frontmatters

Vérifier que chaque souvenir a un frontmatter conforme : `name` en slug (identique au nom de fichier sans extension), `description` en une ligne, `type` sous `metadata:`.

## Règles

- Signaler tout écart, ne rien corriger de destructif sans validation.
- Compte-rendu : chemins et lignes seulement.
- Périodicité suggérée : mensuelle, ou après toute campagne de modifications des souvenirs.
