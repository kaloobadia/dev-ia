# Commande /demarrage

## Rôle

Afficher, en début de session, l'état du `TODO.md` du dossier courant, puis
signaler les changements récents du système de fichiers qui ne sont consignés
dans aucun TODO (écarts candidats). Lecture seule a priori.

Les instructions globales et la mémoire projet sont déjà chargées en contexte :
les réciter ne change pas le comportement (la défaillance se produit à la
production de chaque réponse, pas à l'entrée de session). Cette skill ne les
récapitule donc pas.

Vouvoiement strict. Style sobre. Aucun emoji.

Spécification de référence : `journal/26/06/28/260628-14h02-spec_demarrage_ecarts_index.md`.

---

## Comportement

### 1. État du TODO

Lire le `TODO.md` à la racine du dossier de travail courant s'il existe, puis en
signaler l'état en une ligne (présence et tâches en cours, sans le recopier in
extenso). S'il est absent, le signaler en une ligne et ne rien créer.

### 2. Écarts index / TODO

Balayer directement le système de fichiers (dossier courant et sous-dossiers)
pour lister les fichiers modifiés dans les 7 derniers jours, puis signaler ceux
dont aucune trace n'apparaît dans un TODO.

- Source de fraîcheur : balayage direct, jamais `index-auto.md` (instantané daté,
  en retard sur le disque, qui raterait la note de fin de session à rattraper).
  L'`index-auto.md` ne sert au plus que de carte de structure.
- Commande de balayage : Bash `find . -type f -mtime -7` (repli PowerShell
  `Get-ChildItem -Recurse` filtré par date si Bash indisponible).
- Exclusions : `.obsidian`, `archives`, `.log`, `.bak`, et les `TODO.md`
  eux-mêmes. Cibler les dossiers porteurs de sens (`journal/`, `ressources/`,
  `travaux/`) et les fichiers racine.
- Confrontation : pour chaque fichier récent, chercher son nom ou son chemin
  dans le `TODO.md` du projet correspondant ET dans le `TODO.md` racine. Ne le
  retenir comme écart que s'il est absent des deux.
- Granularité : les notes de `journal/` sont regroupées par jour (ne pas
  énumérer fichier par fichier quand plusieurs notes partagent une date).
- Restitution : une section brève listant les écarts (chemin, date de
  modification), plafonnée à une douzaine d'entrées (au delà, n'afficher que le
  compte total et les plus récentes). Jamais le contenu des fichiers. Si aucun
  écart : le dire en une ligne.

Puis rendre la main.

---

## Règles

- Vouvoiement strict, toujours. Aucune exception.
- Lecture seule a priori : aucune écriture ni création de TODO ou de fichier qui
  n'aurait été proposée puis validée par l'utilisateur.
- Appariement par nom ou chemin uniquement (déterministe, faible coût en
  tokens) : pas de rapprochement sémantique.
- Compte-rendu fichier : chemin et date, jamais le contenu recopié.
- Commande déclarative : ce fichier décrit le comportement attendu, il ne code
  pas.
