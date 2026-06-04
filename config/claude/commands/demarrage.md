# Commande /demarrage

## Rôle

Initialiser une conversation en début de session. Relire les instructions
chargées (CLAUDE.md global + mémoire projet), en afficher un récapitulatif bref,
puis laisser l'utilisateur soit reprendre la conversation, soit fournir des
fichiers de contexte à examiner.

Vouvoiement strict. Style sobre. Aucun emoji.

---

## Comportement

### Étape 0 — Instantané initial (état d'entrée)

Au tout début, capturer un instantané de l'état (contexte %, tokens, coût) en
lisant le JSON de statut de la statusline et en enregistrant une baseline :

```bash
cat /tmp/claude-statusline-debug.json | python ~/.claude/demarrage-snapshot.py start
```

Afficher la ligne « Etat initial » renvoyée. Cet instantané servira de référence
pour mesurer l'écart en fin de skill. Source : `/tmp/claude-statusline-debug.json`,
écrit par la statusline ; lecture sur stdin pour que bash résolve `/tmp`.

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

### Étape 3 — Proposer la suite

Via `AskUserQuestion`, proposer deux voies :

- **Reprendre la conversation** — fin du skill, la main repasse à l'utilisateur.
- **Ajouter des fichiers de contexte** — l'utilisateur fournit un ou plusieurs
  chemins (notes éditoriales, artefacts d'autres sessions, instructions
  spécifiques, etc.).

### Étape 4 — Traiter les fichiers de contexte (si cette voie est choisie)

1. Récupérer le ou les chemins fournis par l'utilisateur.
2. Lui demander, via `AskUserQuestion`, s'il a des consignes au sujet de ces
   documents (ce qu'il en attend, sous quel angle les examiner).
3. Lire les fichiers indiqués et les examiner à la lumière des consignes
   obtenues. Poursuivre le travail sur cette base.

### Étape finale — Instantané final et écart

Juste avant de rendre la main (que l'utilisateur ait choisi « reprendre » ou
qu'on ait traité des fichiers de contexte), capturer l'instantané final et
afficher l'écart depuis la baseline :

```bash
cat /tmp/claude-statusline-debug.json | python ~/.claude/demarrage-snapshot.py end
```

Afficher les lignes « Etat final » et « Ecart » renvoyées. L'écart donne une
mesure approximative du coût du skill (contexte, tokens, USD).

Limite à garder en tête : le JSON de statut n'est rafraîchi qu'aux rendus de la
statusline ; l'instantané final peut donc ne pas intégrer les tout derniers tokens
du tour. L'écart est indicatif, pas exact.

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
