# Conventions documentaires — référence commune

Note de journal — création le 03/07/2026 à 20h55, dernière mise à jour le 03/07/2026 à 20h55

Fichier de référence issu du déport des sections documentaires du `~/.claude/CLAUDE.md` global (mesure 3 du plan du 03/07/2026, critère : contrainte par réponse dans le CLAUDE.md, consultation à la demande ici). Consulté au besoin par les agents ; pointé depuis le `CLAUDE.md` global et les `CLAUDE.md` de projet concernés.

---

## Index des dossiers (`index-thematique.md` curé / `index-auto.md` auto-généré)

- **Deux fichiers distincts :**
  - `index-thematique.md`, table des matières curée, écrite à la main : présente le projet et oriente la navigation (points d'entrée, sens de l'organisation). C'est l'« index » de la structure standard d'un projet.
  - `index-auto.md`, index exhaustif auto-généré par `scripts/index_folder.py` (ou `run_daily_index.py`) : liste noms, chemins, types, tailles et dates de tout le contenu. Pour localiser un fichier ou connaître la structure brute d'un répertoire, lire d'abord l'`index-auto.md` présent plutôt que lancer un `Glob` exhaustif.
- **Limite, contenu :** l'`index-auto.md` n'indexe pas le contenu des fichiers. Pour chercher une chaîne, une fonction ou un motif à l'intérieur des fichiers, un `Grep` sur les vrais fichiers reste nécessaire ; l'`index-auto.md` peut seulement restreindre le périmètre.
- **Fraîcheur :** l'`index-auto.md` est un instantané daté (ligne « Généré le … » en tête). S'il date de plus de 7 jours, le considérer comme indicatif et proposer de le régénérer (`python scripts/index_folder.py "<dossier>" --output "<dossier>/index-auto.md"`) avant de s'y fier. S'il est absent, procéder par recherche normale.
- **Ne pas écraser la TOC :** `index_folder.py` écrit `index-auto.md` par défaut ; cet inventaire est distinct de la table des matières curée `index-thematique.md`, qu'il ne faut jamais écraser.

## Structure standard d'un projet

Tout nouveau projet doit être initialisé avec les éléments suivants à la racine :

- `readme.md`, description du projet (contexte, objectif, organisation) et du contenu du dossier
- `index-thematique.md`, table des matières curée du projet, écrite à la main (voir section précédente)
- `TODO.md`, liste des tâches courantes
- `journal/`, notes horodatées (voir section « Dossier journal »)
- `archives/todo/`, archive journalisée des TODO (voir section « Dossier todo »)
- `ressources/`, documents reçus, sujets, consignes, références
- `travaux/`, productions rendues ou en cours

## Convention d'archive

- **Un seul motif :** un dossier `archives/` (pluriel, nu) à la racine de chaque vault. Pas de variantes (`archive/` singulier, `archives-<projet>/`, ni sous-dossiers à préfixe redondant).
- **Sous-dossiers nus par section :** `archives/journal/`, `archives/ressources/`, `archives/docs/`, etc., sans répéter le nom du projet.
- **Projet clôturé : reste dans son domaine.** Un projet clôturé ou dormant n'est pas déraciné vers une archive froide externe. Il demeure dans le dossier de son domaine et son statut est signalé dans son `readme.md`. Révision du 2026-06-19 : `~/Documents/archives/` ne reçoit pas les projets eux-mêmes mais tient un index des chantiers clôturés ou dormants (mention + pointeur vers l'emplacement réel), pour une vue d'état rapide.
- **Hors index quotidien :** `run_daily_index.py` passe `--exclude archives`, qui exclut tout dossier nommé `archives` à n'importe quel niveau.

## Dossier journal (transverse à tous les projets)

- **Structure :** chaque projet comporte un dossier `journal/YY/MM/DD/` créé au fil des jours de travail.
- **Contenu :** ce dossier du jour accueille tous les documents horodatés : notes de journal, plans d'implémentation, et tout contenu destiné à être relu ou archivé.

## Dossier todo (transverse à tous les projets)

- **Structure :** chaque projet comporte un dossier `archives/todo/YY/MM/DD/` créé au fil des jours de travail.
- **Contenu :** ce dossier du jour accueille les fichiers TODO archivés, horodatés selon les mêmes conventions que les notes de journal.

## Fichiers du type « Note de journal »

- **Nom et emplacement :** fichier horodaté (TZ=Paris) mentionnant le thème, enregistré dans `./journal/<YY>/<MM>/<DD>/`. Résultat : `./journal/<YY>/<MM>/<DD>/<YYMMDD-HH[h]mm-<theme_en_quelques_mots>.md`. Exemple : `./journal/26/05/10/260510-14h15-notice_convention_noms.md`.
- **Structure obligatoire :** le fichier commence par le heading H1 (titre), suivi de l'horodatage en texte brut sur la deuxième ligne :

  ```
  # <titre>

  Note de journal — création le JJ/MM/AAAA à HHhMM, dernière mise à jour le JJ/MM/AAAA à HHhMM
  ```

  Cette structure satisfait MD041 (H1 en première ligne) et évite MD036 (horodatage en texte brut, pas directement sous un heading). La date de mise à jour est identique à la date de création lors de la première écriture.
- **Divergence résolue (03/07/2026) :** `note-journal-conventions.md` (23/05/2026) prescrivait l'horodatage en première ligne, avant le titre. La présente version (H1 d'abord), plus récente et conforme à MD041, fait foi.

## Linters par langage

Après écriture ou modification d'un fichier de code, proposer un passage au linter (règle au `CLAUDE.md` global). Linters par langage, selon disponibilité dans le projet :

- **Python** : ruff (prioritaire), sinon flake8
- **Java** : checkstyle, sinon javac
- **HTML** : HTMLHint, sinon validateur W3C via curl
- **JavaScript / TypeScript** : eslint
- **CSS** : stylelint
