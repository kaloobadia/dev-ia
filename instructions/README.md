Note de journal — création le 23/05/2026 à 14h40, dernière mise à jour le 04/06/2026 à 12h21

# IA/instructions — Cartographie des instructions pour agents IA

Inventaire des fichiers d'instructions destinés aux agents IA, dispersés dans l'arborescence `/dev` et `~/.claude`. **Règle générale : ce dossier est une carte, pas un entrepôt** — aucun fichier d'instructions n'y est déplacé, on note seulement où il vit. **Exception assumée et tracée** : l'entrepôt d'idées de skills (section 2), qui stocke réellement du contenu ; la carte pointe alors vers ce territoire nommé plutôt que d'en interdire l'existence.

> **Décision d'architecture à réévaluer** : le principe même d'une « cartographie des instructions » (un dossier-carte distinct des fichiers d'instructions qu'il recense) est un choix d'architecture, pas une évidence. À reconsidérer périodiquement — notamment au regard de sa fraîcheur, du coût d'entretien des renvois, et de l'apparition d'exceptions comme l'entrepôt (section 2).

---

## 1. Instructions globales (portée : tous projets, tous agents)

| Fichier | Contenu | Statut |
|---------|---------|--------|
| `/dev/IA/instructions/CLAUDE-global.md` | **Consolidation** de `~/.claude/CLAUDE.md` : vouvoiement, shell, heure Paris, conventions journal, règles Mode Plan, 12 règles programmation | **Source de consultation** |
| `~/.claude/CLAUDE.md` | Source originale (reste en place) | Entretien par l'utilisateur |

---

## 2. Entrepôt d'idées de skills (portée : tous agents)

**Dérogation assumée à la règle "carte, pas entrepôt"** (cf. préambule ci-dessus) : ce dossier stocke réellement du contenu. La carte gagne en cohérence en pointant vers ce territoire nommé plutôt qu'en interdisant son existence.

| Dossier | Contenu | Statut |
|---------|---------|--------|
| `/dev/IA/idees-skills/` | Idées de skills issues de comportements répétitifs, fastidieux et automatisables (voir `readme.md` du dossier) | **Entrepôt** (contenu, pas pointeurs) |

---

## 3. Commandes exécutables (portée : tous projets Claude Code)

**Les commandes sont consolidées dans `/dev/IA/instructions/commands/`** pour consultation centralisée.

| Commande | `/dev/IA/instructions/commands/` | Source originale | Exécution Claude Code |
|----------|----------------------------------|------------------|----------------------|
| `/synthese` | ✓ consolidée | `~/.claude/commands/synthese.md` | Reste exécutable |
| `/synthese-multi` | ✓ consolidée | `~/.claude/commands/synthese-multi.md` | Reste exécutable |
| `/make-todo` | ✓ consolidée | `~/.claude/commands/make-todo.md` | Reste exécutable |
| `/choix-modele` | ✓ consolidée | `~/.claude/commands/choix-modele.md` | Reste exécutable |
| `/etape` | ✓ consolidée | `~/.claude/commands/etape.md` (ou `/dev/.agents/commands/etape.md`) | Reste exécutable |

---

## 4. Agents exécutables (portée : tous projets Claude Code)

| Fichier | Contenu | Statut |
|---------|---------|--------|
| `/dev/IA/instructions/agents/code-reviewer.md` | **Consolidation** : agent de revue de code et analyse console | Source de consultation |
| `~/.claude/agents/code-reviewer.md` | Source originale (reste en place) | Entretien par l'utilisateur |

---

## 5. Conventions documentaires (portée : tous projets)

Fichiers dans `/dev/IA/workflow/instructions/` :

| Fichier | Contenu |
|---------|---------|
| `note-journal-conventions.md` | Format nom (`YYMMDD-HHhmm-<theme>.md`), emplacement (`journal/YY/MM/DD/`), première ligne obligatoire |
| `TODO-conventions.md` | Séquence plan → TODO → implémentation, règles sur TODO.md |
| `README.md` | Tableau des commandes disponibles avec portée |

---

## 6. Protocoles multi-agents (portée : projets avec orchestration multi-agents)

**Consolidés dans `/dev/IA/instructions/multi-agents/`** pour consultation centralisée.

| Fichier | Contenu | Source originale |
|---------|---------|------------------|
| `protocol.md` | Protocole de collaboration IA : artefacts de coordination, flux de travail | `/dev/.agents/protocol.md` |
| `roles.md` | Rôles : Claude (supervision), Gemini (implémentation), Copilot/Mistral (support) | `/dev/.agents/roles.md` |
| `session-start.md` | Protocole de démarrage de session, modèle de note de contexte | `/dev/.agents/session-start.md` |

---

## 7. Instructions par projet

Chaque projet dispose de ses propres fichiers d'instructions à sa racine et/ou dans `.agents/` :

| Fichier | Contenu | Portée |
|---------|---------|--------|
| `<projet>/CLAUDE.md` | Contexte et règles spécifiques au projet pour Claude | Projet |
| `<projet>/AGENTS.md` | Schéma d'orchestration des agents pour ce projet | Projet |
| `<projet>/GEMINI.md` | Contexte pour Gemini | Projet |
| `<projet>/MISTRAL.md` | Contexte et contraintes pour Mistral | Projet |
| `<projet>/.agents/CLAUDE.md` | Surcharge ou référence externe | Projet |

Projets concernés : `homelab-tracker`, `enquete-benevoles`, `enquete-benevoles-exe`, `enquete-benevoles-report`, `enquete-benevole-integration`, `atelier`, `robertet`, `UPVM-2nde-session`.

---

## 8. Conventions de nommage artefacts multi-agents

Fichiers dans `/dev/enquete-benevoles-exe/collab/26/05/15/convention-agents/définitions/` :

| Fichier | Contenu |
|---------|---------|
| `260515-17h00-convention-noms-agents-v1.md` | Convention v1.0 validée |
| `260515-19h43-claude-convention-noms-agents-v1.2.md` | Version courante (v1.2) |

---

## 9. Doublons et points de friction

**Résolus par consolidation (260523) :**
- ✓ Les commandes sont désormais centralisées dans `/dev/IA/instructions/commands/` (source unique de consultation)
- ✓ CLAUDE.md est consolidé dans `/dev/IA/instructions/CLAUDE-global.md`
- ✓ Les protocoles multi-agents sont dans `/dev/IA/instructions/multi-agents/`

**Sources de vérité (décision 260531) :**
- Commandes (`/synthese`, `/etape`, etc.) : source = `~/.claude/commands/` ; copies dérivées = `IA/instructions/commands/`, `.agents/commands/`, `IA/config/claude/commands/`
- Protocoles multi-agents (`protocol.md`, `roles.md`, `session-start.md`) : source = `IA/instructions/multi-agents/` ; copie dérivée = `/dev/.agents/`

**Restants :**
- `homelab-tracker/docs/reference/AGENTS.md` contient des informations sensibles qui ne devraient pas figurer dans un fichier d'instructions standard
- Entrepôt `idees-skills/` : les fichiers y sont des copies (originaux dans le journal UPVM) — pas de mécanisme de synchronisation entre copie et original

---

## 10. Ce qui manque

- Pas d'instructions globales pour Gemini ou Mistral au niveau `~/.` (équivalent de `~/.claude/CLAUDE.md`)
- Pas de mécanisme de synchronisation des miroirs
- Les conventions du dossier `collab/` (sous-dossiers `definitions/`, `productions-initiales/`, etc.) ne sont documentées nulle part de façon canonique
