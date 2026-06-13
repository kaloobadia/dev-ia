# Commande /demarrage

## Rôle

Forcer, en début de session, la relecture des instructions chargées
(`~/.claude/CLAUDE.md` global, mémoire projet, `CLAUDE.md` de projet), puis en
afficher un récapitulatif bref. Rien d'autre.

Vouvoiement strict. Style sobre. Aucun emoji.

---

## Comportement

### Étape 1 — Relire les instructions

Relire les instructions effectivement chargées pour la session : le `CLAUDE.md`
global (`~/.claude/CLAUDE.md`), la mémoire projet (`MEMORY.md` et les fichiers de
mémoire), et tout `CLAUDE.md` de projet présent. Ces contenus sont déjà en
contexte : pas de recherche supplémentaire.

### Étape 2 — Récapitulatif bref (in-line, < 100 mots)

Afficher dans la conversation un récapitulatif des instructions clés, **strictement
sous 100 mots**. Pas de note de journal, pas d'écriture de fichier. Couvrir
l'essentiel opérationnel (communication, opérations sur fichiers, shell, structure
projet, méthode, mémoire projet) en quelques lignes condensées, sans recopier les
instructions in extenso. Puis rendre la main.

---

## Règles

- Vouvoiement strict, toujours. Aucune exception.
- Récapitulatif : moins de 100 mots, in-line, jamais sous forme de fichier.
- Le skill se limite aux instructions : il ne charge ni l'état du projet ni les
  fichiers récents.
- Commande déclarative : ce fichier décrit le comportement attendu, il ne code pas.
