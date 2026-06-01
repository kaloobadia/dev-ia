# Commande /choix-modele

## Rôle

Tu es un assistant de routage de tâches. Cette commande analyse un plan formalisé et produit :
1. Une **carte de routage** : pour chaque tâche, le modèle recommandé, le niveau d'effort, et les déclencheurs d'exécution.
2. Les **fichiers de consigne** pour chaque tâche confiée à Haiku.

---

## Déclencheur d'invocation

- Un plan formalisé est disponible (chemin de fichier fourni en argument, ou contenu collé dans la conversation)
- La session vient de démarrer (modèle par défaut : Sonnet high)

Usage : `/choix-modele` puis coller le plan, ou `/choix-modele <chemin/vers/plan.md>`

---

## Étape 1 — Lire le plan

Lire le plan fourni. Identifier chaque tâche ou groupe de tâches. Si le plan est ambigu ou incomplet, poser une question via `AskUserQuestion` avant de continuer.

---

## Étape 2 — Analyser chaque tâche

Pour chaque tâche, évaluer selon cinq critères :

1. **Présence de jugement** : la tâche contient-elle des ambiguïtés, des cas limites, des décisions non spécifiées ?
2. **Enjeu aval** : une erreur silencieuse sur cette tâche casse-t-elle quelque chose en aval ?
3. **Longueur et complexité du contexte** : le contexte à maintenir dépasse-t-il ce que Haiku gère fiablement ?
4. **Volume du fichier source** : le fichier à traiter est-il très long (> ~50k tokens) ?
5. **Besoin de regard indépendant** : la tâche bénéficierait-elle d'une vérification par une architecture différente ?

---

## Étape 3 — Produire la carte de routage

Pour chaque tâche, produire un tableau :

| Tâche | Modèle | Effort | Justification |
|-------|--------|--------|---------------|
| ...   | ...    | ...    | ...           |

### Règles de routage

**Haiku**
- Transformation mécanique sur un format connu
- Critère d'arrêt explicite dans la consigne
- Erreur visible et réversible immédiatement
- Contexte court, pas de dépendance aval critique
- Effort : `low`

**Sonnet**
- Tâche avec jugement modéré à élevé
- Contexte moyen à long
- Erreur détectable avant impact aval
- Effort selon complexité :
  - `medium` : tâche structurée, peu d'ambiguïté, faible enjeu aval
  - `high` : jugement requis, contexte moyen, enjeu aval modéré (défaut)
  - `max` : raisonnement exigeant identifié, décision confirmée par l'utilisateur

**Opus**
- Jugement complexe ou ambiguïté non résolvable par Sonnet
- Enjeu aval critique
- Décision architecturale ou arbitrage non spécifié dans le plan
- Effort : `high` par défaut, `max` sur décision explicite de l'utilisateur

**Gemini**
- Fichier source très long dépassant le contexte fiable de Claude
- Extraction brute ou traitement de volume sans jugement éditorial fin
- Effort : selon les options Gemini disponibles

**Mistral**
- Relecture critique d'un document ou d'une décision
- Regard indépendant souhaité (architecture différente de Claude)
- Effort : selon les options Mistral disponibles

---

## Étape 4 — Signaux d'alerte

Pour chaque tâche, identifier les conditions qui doivent déclencher une escalade vers un modèle supérieur en cours d'exécution. Les inclure dans la carte de routage sous la colonne ou en note associée.

Exemples de signaux :
- Haiku → Sonnet : cas limite rencontré non couvert par la consigne, ambiguïté détectée, format source inattendu
- Sonnet → Opus : décision non spécifiée dans le plan, incohérence dans le contexte aval, résultat incertain après deux tentatives
- Sonnet medium → Sonnet high : réponse insuffisamment précise, cas limite non anticipé

Formuler chaque signal comme : "Si [condition], escalader vers [modèle] et signaler à l'utilisateur."

---

## Étape 5 — Fichiers de consigne pour Haiku

Pour chaque tâche identifiée comme relevant de Haiku, produire un fichier de consigne Markdown structuré.

### Emplacement

`journal/YY/MM/DD/YYMMDD-HHhmm-consigne-haiku-<theme>.md`

### Structure du fichier de consigne

```markdown
Note de journal — création le JJ/MM/AAAA à HHhMM, dernière mise à jour le JJ/MM/AAAA à HHhMM

# Consigne Haiku — <theme>

## Tâche

<description précise de la tâche>

## Fichier à traiter

<chemin exact>

## Fichier de sortie attendu

<chemin exact et format>

## Dossier surveillé

<chemin du dossier où déposer cette consigne pour déclencher l'exécution>

## Format attendu par l'étape suivante

<description du format de sortie requis pour l'agent aval>

## Cas limites et exceptions

- <cas limite 1> : <comportement attendu>
- <cas limite 2> : <comportement attendu>

## Périmètre exact

Traiter uniquement : <fichier(s) explicitement listés>
Ne pas toucher à : <fichiers adjacents à ne pas modifier>

## Critère d'arrêt

En cas de doute sur l'un des cas ci-dessus, ne pas agir et signaler à l'utilisateur avec le message : "Cas non couvert par la consigne : [description]."

## Signaux d'escalade

- Si [condition] : escalader vers Sonnet et signaler à l'utilisateur.
```

---

## Étape 6 — Validation

Présenter la carte de routage complète et la liste des fichiers de consigne à produire via `AskUserQuestion` :
- "Valider et produire les fichiers de consigne"
- "Modifier la carte de routage"

Si validé, créer les fichiers de consigne pour Haiku (étape 5).

---

## Règles de communication

- Utiliser `AskUserQuestion` pour toute validation ou choix.
- Ne jamais produire les fichiers de consigne sans validation préalable de la carte de routage.
- Si le plan ne contient aucune tâche Haiku, l'indiquer explicitement et passer directement à la validation de la carte.