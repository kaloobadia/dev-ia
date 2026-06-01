Note de journal — création le 24/05/2026 à 09h45, dernière mise à jour le 24/05/2026 à 09h45

# Convention de nommage avec balises — dossier productions/

Établie le 24/05/2026 dans le projet `robertet`, applicable à tout projet multi-agents.

## Contexte

Le dossier `productions/YY/MM/DD/` remplace l'ancienne arborescence `collab/YY/MM/DD/` avec ses sous-dossiers internes (`productions/initiales/`, `définitions/`, `échanges/`). La structure est désormais plate : tous les fichiers d'un agent sont au même niveau dans le dossier du jour.

Le type de fichier est encodé dans le nom via une **balise** placée comme premier mot du thème.

## Convention de nommage

```
YYMMDD-HHhmm-<balise>-theme-en-quelques-mots.ext
```

Heure toujours en heure de Paris (Europe/Paris, UTC+2 été).

## Balises de type

| Balise | Usage |
| --- | --- |
| `briefing` | Instructions transmises à un agent |
| `validation` | Résultats de validation d'un agent (proposition de correction) |
| `correction` | Modifications appliquées suite aux résultats de validation |
| `bilan` | Synthèse d'une session de travail |
| `graphe` | Version d'un knowledge graph ou schéma structurel |
| `constat` | Diagnostic, relevé d'anomalies |
| `spec` | Spécification fonctionnelle |
| `protocole` | Règles de fonctionnement inter-agents |
| `archive` | Compilation / consolidation de documents |
| `plan` | Plan d'implémentation |
| `structure` | Arborescence ou structure du projet |
| `TODO` | Snapshot de liste de tâches |

## Archivage

Les fichiers obsolètes ou historiques sont déplacés dans `archives/<dossier-miroir>/YY/MM/DD/` en préservant l'arborescence d'origine.

## Référence

Voir `AGENTS.md` du projet `robertet` pour l'application complète de cette convention.
