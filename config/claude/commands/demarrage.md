# Commande /demarrage

## Rôle

Initialiser une conversation en début de session. Relire les instructions
chargées (CLAUDE.md global + mémoire projet), en afficher un récapitulatif bref,
puis inviter l'utilisateur à fournir du contexte s'il le souhaite.

Vouvoiement strict. Style sobre. Aucun emoji.

---

## Comportement

### Étape 1 — Revue des instructions

Relire les instructions effectivement chargées pour la session : le `CLAUDE.md`
global (`~/.claude/CLAUDE.md`), la mémoire projet (`MEMORY.md` et les fichiers de
mémoire), et tout `CLAUDE.md` de projet présent. Ne pas relancer de recherche
inutile : ces contenus sont déjà en contexte.

### Étape 2 — Récapitulatif bref (in-line, < 100 mots)

Afficher dans la conversation un récapitulatif des instructions clés, **strictement
sous 100 mots**. Pas de note de journal, pas d'écriture de fichier à cette étape.
Couvrir l'essentiel opérationnel (communication, opérations sur fichiers, shell,
structure projet, méthode, mémoire projet) en quelques lignes condensées, sans
recopier les instructions in extenso.

### Étape 3 — Inviter à fournir du contexte

Terminer par un message bref invitant l'utilisateur à insérer du contexte s'il le
souhaite, par exemple : « Vous pouvez insérer du contexte si besoin : le chemin du
projet, un TODO, une note de session… » Puis rendre la main.

Si l'utilisateur fournit des chemins, lire les fichiers indiqués et poursuivre le
travail sur cette base.

---

## Règles

- Vouvoiement strict, toujours. Aucune exception.
- Récapitulatif de l'étape 2 : moins de 100 mots, in-line, jamais sous forme de
  fichier.
- Toujours `AskUserQuestion` pour les choix — jamais de question disjonctive en
  texte libre.
- Le skill se limite aux instructions : il ne charge pas l'état du projet ni les
  fichiers récents (hors fichiers de contexte explicitement fournis par
  l'utilisateur).
- Compte-rendu sur fichiers : après une lecture, ne poster que chemin + commentaire
  bref, jamais le contenu intégral.
- Commande déclarative : ce fichier décrit le comportement attendu, il ne code pas.
