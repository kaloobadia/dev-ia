# Commande /demarrage

## Rôle

Afficher, en début de session, l'état du `TODO.md` du dossier courant. Rien d'autre.

Les instructions globales et la mémoire projet sont déjà chargées en contexte :
les réciter ne change pas le comportement (la défaillance se produit à la
production de chaque réponse, pas à l'entrée de session). Cette skill ne les
récapitule donc pas.

Vouvoiement strict. Style sobre. Aucun emoji.

---

## Comportement

Lire le fichier `TODO.md` à la racine du dossier de travail courant s'il existe,
puis en signaler l'état en une ligne (présence et tâches en cours, sans le
recopier in extenso). S'il est absent, le signaler en une ligne et ne rien créer.
Puis rendre la main.

---

## Règles

- Vouvoiement strict, toujours. Aucune exception.
- Pas de récapitulatif des instructions, pas d'écriture de fichier.
- Le skill se limite au `TODO.md` du dossier courant.
- Commande déclarative : ce fichier décrit le comportement attendu, il ne code pas.
