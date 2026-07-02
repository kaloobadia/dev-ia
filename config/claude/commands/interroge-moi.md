# Commande /interroge-moi

## Rôle

Interroger l'utilisateur sans relâche sur chaque aspect d'un plan, d'une décision ou d'une idée, jusqu'à une compréhension partagée. Parcourir l'arbre de décision branche par branche, en résolvant les dépendances entre choix une à une. Le but n'est pas de valider, mais de faire émerger les points non tranchés avant toute production : aider à penser, ne rien conclure ni supposer à la place de l'utilisateur (souvenir `feedback_aider_reflechir_pas_inventer`).

Copie unique : ce fichier (`~/.claude/commands/interroge-moi.md`) est la seule version.

## Règles de communication

- Une seule question à la fois. Attendre la réponse avant de poser la suivante.
- Toujours utiliser `AskUserQuestion`. Aucune question en texte libre, jamais de question disjonctive du type « voulez-vous X, ou Y ? ». Voir le souvenir `feedback_askuserquestion`.
- Pour chaque question, fournir une réponse recommandée : la placer en première option, suffixée de « (recommandé) », et justifier brièvement dans sa description.
- Choisir le type de question selon la nature du choix (voir section « Typologie des questions »).
- Ne rien écrire ni implémenter : cette commande sert à cerner, pas à produire. La production éventuelle relève d'un tour ultérieur, sur demande explicite.

## Séquence

### 1 — Établir la cible

Au lancement, ne rien supposer sur l'objet à interroger. Poser une première question `AskUserQuestion` pour identifier la cible : quel plan, quelle décision, quelle idée doit être passée au crible. Proposer comme options les candidats plausibles déjà présents dans la conversation ; l'option « Other » couvre une cible non listée.

### 2 — Cartographier l'arbre de décision

À partir de la cible, dresser mentalement (sans le rédiger dans un fichier) l'arbre des décisions à trancher : nœuds principaux, sous-décisions, dépendances. Une décision qui en conditionne d'autres est un nœud amont : la traiter avant ses enfants. Ne jamais poser une question dont la réponse dépend d'un choix encore ouvert en amont.

### 3 — Résoudre par le code quand c'est possible

Avant de poser une question, vérifier si sa réponse se trouve dans le code, les fichiers du projet ou un index existant (`index-auto.md`, `index-thematique.md`, biblio annotée). Si oui, explorer (`Grep`, `Glob`, `Read`, index) et trancher soi-même plutôt que de demander. Ne réserver les questions qu'aux vrais arbitrages de l'utilisateur : préférences, priorités, périmètre, compromis.

### 4 — Interroger nœud par nœud

Descendre l'arbre en résolvant une dépendance à la fois. Pour chaque nœud non résoluble par le code :

1. Formuler une question `AskUserQuestion` ciblée, avec sa réponse recommandée en tête.
2. Intégrer la réponse : élaguer les branches devenues caduques, révéler les sous-décisions nouvellement pertinentes.
3. Passer au nœud suivant selon l'ordre des dépendances.

Continuer jusqu'à ce qu'aucune branche ne reste ouverte.

### 5 — Restituer la compréhension partagée

Quand l'arbre est entièrement parcouru, restituer une synthèse concise des décisions arrêtées et de leurs justifications. Ne pas enchaîner sur une production : proposer, le cas échéant, d'archiver cette synthèse (fichier de type « note de journal », horodatage heure de Paris) ou de passer à l'étape suivante, sur validation.

## Typologie des questions

Choisir consciemment le format `AskUserQuestion` selon la nature du choix :

- **Choix unique parmi plusieurs** (options exclusives) : question simple, `multiSelect: false`. Réponse recommandée en première option.
- **Options non exclusives** (plusieurs peuvent valoir) : ne pas forcer un choix unique. Demander un classement par priorité, ou utiliser `multiSelect: true` si le cumul a du sens. Voir la mémoire `feedback_question_classement`.
- **Choix ordonné / arbitrage** (priorités, compromis à pondérer) : formuler pour faire ressortir l'ordre, pas une préférence binaire.

Dans tous les cas : jamais de question en texte libre. Si un choix existe, il passe par `AskUserQuestion` ; sinon, trancher soi-même et rapporter.
