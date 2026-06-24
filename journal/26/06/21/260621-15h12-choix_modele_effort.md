# Choix du modèle et de l'effort par défaut

Note de journal : création le 21/06/2026 à 15h12, dernière mise à jour le 21/06/2026 à 15h12

## Objet

Conversation servant à la fois à informer et à poser le contexte de travail. Question initiale : quel modèle et quel niveau d'effort retenir par défaut pour les sessions interactives, jugés sur quatre critères.

## Les quatre critères

1. Utilisation des tokens (cout).
2. Attitude proactive.
3. Propension à omettre des angles morts.
4. Propension à faire des suppositions sans prévenir.

Lecture d'ensemble : trois critères sur quatre (2, 3, 4) s'améliorent avec un modèle plus capable et un effort plus élevé ; seul le critère 1 tire en sens inverse. La pondération implicite penche donc 3 contre 1 vers la qualité de comportement.

## Données de référence (prix au million de tokens, entrée / sortie)

- Opus 4.8 : 5 / 25 dollars.
- Sonnet 4.6 : 3 / 15 dollars.
- Haiku 4.5 : 1 / 5 dollars.
- Fable 5 : 10 / 50 dollars.

Niveaux d'effort : low, medium, high, xhigh, max. Défaut = high. Pour Opus 4.8, la consigne est de partir de high et de ne pas monter à xhigh par réflexe.

## Éliminations

- Haiku 4.5 : écarté. Tendance à simplifier en silence et à rater des détails, soit l'échec direct des critères 3 et 4 (déjà acté dans le CLAUDE.md).
- Fable 5 : écarté comme défaut. Deux fois le prix d'Opus, tours de plusieurs minutes par conception, risque de refus par classifieur sur des sujets sécurité ou bio même légitimes. À réserver aux tâches longues et exceptionnellement dures.

## Comparaison des candidats retenus

| Critère | Sonnet 4.6 (medium) | Opus 4.8 (high) |
| --- | --- | --- |
| Tokens | meilleur (entrée et sortie à 0,6x) | plus élevé |
| Proactivité | correcte | forte (narration, relances spontanées) |
| Angles morts | risque modéré | faible (détection de bugs supérieure) |
| Suppositions tues | risque modéré | faible (plus délibéré, demande plus souvent) |

## Recommandation

Opus 4.8, effort high.

- high plutôt que medium : à effort bas ou moyen, 4.8 cadre au strict demandé et risque de sous réfléchir sur les tâches complexes, donc plus d'angles morts.
- high plutôt que xhigh ou max : gain marginal pour un cout en tokens réel, or le critère 1 compte.
- Escalade ponctuelle vers xhigh ou max sur un problème connu comme dur ; bascule vers Sonnet 4.6 medium pour le volume mécanique.

Nuance non tranchée : le point d'équilibre exact dépend de la tolérance au cout de l'utilisateur, qui n'a pas été figée et reste son arbitrage. La règle « Opus réservé aux agents Plan » du CLAUDE.md vise la délégation automatisée (cout multiplié), pas le défaut de session interactive : les deux cohabitent.

## Leçon de méthode (contexte de travail posé)

Pendant la conversation, deux suppositions non annoncées ont été commises : que l'utilisateur voulait trancher dans le tour même, et que la décision finale lui revenait par un clic, alors qu'il demandait une expertise. Une question à choix forcé prématurée incarne elle-même la supposition « une décision est due maintenant ». Correctif retenu et mémorisé : séparer le livrable (analyse) de l'action, nommer toute supposition avant d'agir, n'ouvrir une question à choix que lorsqu'une décision est réellement nécessaire pour avancer. Voir la mémoire feedback_suppositions_decision.

## Suite à traiter (session neuve)

1. Analyser le plugin https://github.com/dufis1/calibration-dials.
2. Discuter de son intérêt au regard du présent contexte (choix de modèle et d'effort, et la question des suppositions et des angles morts).

Cette note sert de note de reprise pour la session suivante.
