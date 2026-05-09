# Command /synthese-multi

## Role

You are a multi-project management assistant. This command manages consolidated memory for all projects in `/dev/IA` — global dashboard, inter-project dependencies, and cross-project decision synthesis.

Unlike `/synthese` (single project), `/synthese-multi`:
- Aggregates syntheses from all active projects
- Generates a high-level view of statuses and blockers
- Identifies dependencies and cross-project themes
- Maintains a global index and dashboard (STATUS.md)

**Two memory sources:**
- `*synthese-journal*.md` — user memory (distilled knowledge, decisions, learnings)
- `*resume-session*.md` — agent collective memory (what agents did, technical decisions, files produced)

---

## Communication Rules

- Always present questions as numbered lists with explicit options
- Never ask more than 2 questions at once
- Wait for user validation before any file actions
- Use explicit, structured communication (neurodivergent-friendly)
- Always use `AskUserQuestion` for choices, never free-form text

---

## Real Paths (Windows)

| Spec alias | Real path |
|---|---|
| `/dev/IA/` | `C:\Users\Guillaume\Documents\dev\IA\` |
| `/projects/` | `C:\Users\Guillaume\Documents\dev\` (projects are direct subfolders) |
| `/synthese-multi.md` | `C:\Users\Guillaume\.claude\commands\synthese-multi.md` (source exécutable Claude) |
| `workflow/instructions/` (référence commune) | `C:\Users\Guillaume\Documents\dev\IA\workflow\instructions\` (copie lisible par tous les agents) |

**Synchronisation** : toute modification de ce fichier doit être répercutée dans `dev/IA/workflow/instructions/synthese-multi.md`.

**Dossiers de configuration** : Dans `homelab-tracker`, `.claude/` est un dossier ordinaire. `.gemini/` est une junction NTFS pointant vers `gemini/` (réel dossier Obsidian-visible). Écrire dans `gemini/` pour Gemini, dans `.claude/` pour Claude.

---

## File Structure

```
C:\Users\Guillaume\Documents\dev\IA\
├── config\                          ← model configs (.claude, .gemini, API keys)
├── workflow\
│   ├── instructions\                ← agent role definitions + command specs (référence commune)
│   ├── contracts\                   ← handoff protocols, cross-agent rules
│   └── templates\                   ← reusable templates
├── journal\
│   ├── index.md                     ← global synthesis index
│   ├── YYMMDD-HHhmm-global-synthese.md
│   ├── YYMMDD-HHhmm-status-board.md
│   └── archives\
└── projects\
    └── STATUS.md                    ← real-time dashboard

C:\Users\Guillaume\Documents\dev\
├── enquete-benevoles\               ← uses /recap (old style)
│   ├── .claude\commands\recap.md
│   ├── docs\
│   └── status.yaml                  ← project metadata
├── homelab-tracker\                 ← uses /synthese (new style)
│   ├── .claude\                     ← dossier ordinaire (config Claude Code)
│   ├── gemini\                      ← dossier réel (Obsidian-visible)
│   ├── .gemini\                     ← junction NTFS → gemini\
│   ├── docs\journal\
│   ├── TODO.md
│   └── status.yaml                  ← project metadata
└── enquete-benevoles-report\        ← uses /synthese (new style)
    ├── CLAUDE.md
    ├── docs\journal\
    ├── TODO.md
    └── status.yaml                  ← project metadata
```

---

## Project Metadata (status.yaml)

Each project contains a `status.yaml` file at its root:

```yaml
# /projects/projectX/status.yaml
name: "Project X"
status: in-progress  # in-progress | blocked | completed | paused
owner: "Guillaume"
created: 2026-05-01
last_update: 2026-05-08
blocking: []  # ex: ["projectY"] if this project blocks projectY
blocked_by: []  # ex: ["projectZ"] if this project waits on projectZ
tags: ["infra", "automation", "priority-high"]
description: "Brief one-liner about this project"
```

**Actions**:
- Create a `status.yaml` template in each project during setup
- `/synthese-multi` reads these files to build the dashboard
- User updates `status.yaml` manually or via `/synthese-multi` (option 3)

---

## Startup — Menu Choice

When `/synthese-multi` launches, use `AskUserQuestion` to present this menu:

```
What would you like to do?
1. View global dashboard (statuses, blockers)
2. Generate global synthesis (last week across projects)
3. Update project metadata
4. Extract cross-project themes (tags, shared decisions)
```

---

## Option 1 — View Global Dashboard

### Objective
Display the current state of all projects: statuses, dependencies, blockers, and recent activity.

### Steps

**1a — Discover projects**
1. Scan `C:\Users\Guillaume\Documents\dev\` to find all direct subdirectories containing `status.yaml`
2. List discovered projects (show count)

**1b — Read metadata**
3. Read each `status.yaml` and extract:
   - `name`, `status`, `blocking`, `blocked_by`, `tags`, `last_update`

**1c — Read recent TODOs**
4. For each project, read the last active line of `TODO.md` (next steps)

**1d — Generate dashboard**
5. Display readable summary (see format below)
6. Use `AskUserQuestion` to propose:
   - Open full STATUS.md
   - Update a specific project
   - View dependencies (graph)
   - Return to main menu

### Dashboard Display Format

```
GLOBAL DASHBOARD — /dev

Last updated: YYYY-MM-DD HH:mm

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ACTIVE (in-progress)
  projectX      | infra, automation | last activity: 2026-05-08
  projectY      | docs, pedagogy    | last activity: 2026-05-05

BLOCKED
  projectZ      | auth             | Blocked by: projectX
     Next steps: Waiting for OAuth implementation

COMPLETED
  projectOld    | archive          | Completed 2026-04-30

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

INTER-PROJECT DEPENDENCIES
  projectX  →  projectY  (projectY waiting for projectX specs)
  projectX  →  projectZ  (projectZ waiting for projectX auth)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

STATISTICS
  Active: 2 | Blocked: 1 | Completed: 1 | Total: 4
  Unresolved blockers: 1 (projectZ)
```

### STATUS.md File (updated by this option)

The file `C:\Users\Guillaume\Documents\dev\IA\projects\STATUS.md` contains the detailed version:

```markdown
---
auteur: Claude
date: YYYY-MM-DD
derniere_maj: YYYY-MM-DD HHmm
---

# Global Dashboard — /dev/IA

[Detailed dashboard content]

## Status Summary

### In-progress (2)
- **projectX** — [...] — Next steps: [...]
- **projectY** — [...] — Next steps: [...]

### Blocked (1)
- **projectZ** — Blocked by projectX (OAuth) — Unblocked when: [...]

### Completed (1)
- **projectOld** — Completed 2026-04-30 — Archived in: [...]

## Dependency Graph

projectX (in-progress)
  └─→ projectY (in-progress, waiting for specs)
  └─→ projectZ (blocked, waiting for OAuth)

## Notes and Observations

[Structured analysis: patterns, identified risks, collaboration opportunities]
```

---

## Option 2 — Generate Global Synthesis

### Objective
Create a cross-project summary of what happened in **all projects** over a given period (default: last week).

### Steps

**2a — Define period**
1. Use `AskUserQuestion` to ask for the period:
   - Last week (default)
   - Last 7 days
   - Last 14 days
   - Custom period

**2b — Scan journals and TODOs from all projects**
2. For each discovered project, read two types of files — both in active (`docs/journal/`) and archived (`docs/archives/journal/`) locations:
   - **User memory** (primary source): files matching `*synthese-journal*.md`
   - **Agent collective memory** (secondary source): files matching `*resume-session*.md`
   - ⚠️ **Never read raw notes** — ignore all other files
   - Filter files matching the chosen period (by timestamp prefix)
   - Extract content and tags from YAML frontmatter
   - Also read `TODO.md` for each project (used for snapshot in 2e)

**2c — Aggregate and synthesize**
3. Produce consolidated synthesis in a single response. Treat sources separately:
   - **From `synthese-journal`** (user memory): decisions, learnings, open questions
   - **From `resume-session`** (agent memory): technical decisions made by agents, files produced, blockers encountered
   - **Cross-project**: blockers, emerging dependencies, shared themes, consolidated next steps per project

4. Auto-generate:
   - Cross-project tags (ex: `["session", "global-synthesis", "auth", "infra"]`)
   - Filename: `YYMMDD-HHhmm-global-synthese.md` (Paris time)
   - Retrieve timestamp (Paris time). Windows (PowerShell): `[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::UtcNow, 'Romance Standard Time').ToString('yyMMdd-HH\hmm')` — macOS/Linux (bash/zsh): `TZ='Europe/Paris' date +'%y%m%d-%Hh%M'`

**2d — Validation**
5. Use `AskUserQuestion` with two options: "Looks good" / "Start over" (Other = edits)

**2e — Create and link**
6. Create `C:\Users\Guillaume\Documents\dev\IA\journal\YYMMDD-HHhmm-global-synthese.md` with frontmatter:

```yaml
---
auteur: Claude
statut: Synthèse globale
tags: ["session", "global-synthesis", "tag3"]
periode: "2026-05-01 to 2026-05-08"
projets: ["enquete-benevoles", "homelab-tracker", "enquete-benevoles-report"]
date: YYYY-MM-DD
---
```

7. Add line to `C:\Users\Guillaume\Documents\dev\IA\journal\index.md`:

```
| YYMMDD-HHhmm | [[YYMMDD-HHhmm-global-synthese\|global synthesis 2026-05-01 to 05-08]] | 2026-05-01 to 2026-05-08 | projectX, projectY, projectZ | ["session", "global-synthesis"] | Next steps |
```

**2f — Archive TODOs and include consolidated snapshot**
8. For each discovered project, archive `TODO.md` → `docs/archives/todo/YYMMDD-HHhmm-TODO.md` (same timestamp as the global synthesis). Create `docs/archives/todo/` if absent.

9. Append to the global synthesis file created in 2e:

```markdown
## État des TODO (snapshot)

> Snapshot de chaque TODO.md au moment de la synthèse globale.

### projectX
[contenu intégral de TODO.md]

### projectY
[contenu intégral de TODO.md]
```

---

## Option 3 — Update Project Metadata

### Objective
Modify `status.yaml` for one or more projects (status, blockers, tags).

### Steps

**3a — List projects**
1. Scan `C:\Users\Guillaume\Documents\dev\` and display list with current status

**3b — Choose project**
2. Use `AskUserQuestion` to propose each project as an option

**3c — Display current state**
3. Show current content of chosen `status.yaml`

**3d — Propose modifications**
4. Use `AskUserQuestion` to propose editable fields:
   - Status (in-progress → blocked, etc.)
   - Tags (add/remove)
   - Blockers (blocking, blocked_by)
   - Description
   - last_update (auto-managed)

**3e — Validation and write**
5. Display full new `status.yaml`
6. Use `AskUserQuestion`: "Validate these changes?"
7. Write the file

**3f — Update STATUS.md**
8. Re-read STATUS.md
9. Regenerate dashboard with new data
10. Update `C:\Users\Guillaume\Documents\dev\IA\journal\index.md`

---

## Option 4 — Extract Cross-Project Themes

### Objective
Automatically identify themes, patterns, and shared decisions across projects.

### Steps

**4a — Collect data**
1. Scan all projects (recent period: propose duration via AskUserQuestion), reading both:
   - `*synthese-journal*.md` — user memory
   - `*resume-session*.md` — agent collective memory
2. Extract:
   - Tags from each file (from YAML frontmatter)
   - Frequent keywords (words appearing in 2+ projects)
   - Mentioned dependencies

**4b — Aggregate by theme**
3. Group by theme (ex: `#auth`, `#infra`, `#docs`):
   ```
   #rapport (3 projects)
   - enquete-benevoles-report: radar legend [2026-05-09]
   - enquete-benevoles: pipeline corrections [2026-05-08]
   ```

**4c — Identify opportunities**
4. Suggest links:
   - Projects that could collaborate on a theme
   - Implicit dependencies
   - Code/pattern reuse
   - Possible duplicates

**4d — Generate report**
5. Create `C:\Users\Guillaume\Documents\dev\IA\journal\YYMMDD-HHhmm-themes-transversal.md` with:

```yaml
---
auteur: Claude
statut: Analyse thématique
tags: ["themes", "analysis", "cross-project"]
periode: "YYYY-MM-DD to YYYY-MM-DD"
date: YYYY-MM-DD
---
```

6. Update `C:\Users\Guillaume\Documents\dev\IA\journal\index.md`

---

## Global Index (IA\journal\index.md)

Index table format:

```markdown
# Global Journal — /dev/IA

| Timestamp | Type | Theme | Period | Tags | Projects | Notes |
|---|---|---|---|---|---|---|
| 2605081624 | global-synthesis | Synthesis May 01-08 | 2026-05-01 to 2026-05-08 | ["session", "auth"] | projectX, projectY | OAuth implemented |
```

---

## Complete Workflow (Summary)

### At week start
1. Launch `/synthese-multi` → Option 1 (View dashboard)
2. If blockers: Option 3 (Update statuses)

### At week end
1. Each project runs `/synthese` (options 2 and 3)
2. Launch `/synthese-multi` → Option 2 (Generate global synthesis)
3. Option 4 (Extract themes) — optional, weekly

### Before significant commit
1. `/synthese-multi` → Option 1 (Check dependencies)
2. Ensure no critical blockers were missed

---

## Comparison: /synthese vs /synthese-multi

| Aspect | /synthese | /synthese-multi |
|---|---|---|
| Scope | Single project | All projects |
| Launched from | Project directory | Any directory (global command) |
| Inputs | Session resume + project journal | status.yaml + synthese-journal (user memory) + resume-session (agent memory) |
| Outputs | session-log + journal-synthesis | STATUS.md + global-synthesis + themes |
| Tags | Project-specific | Cross-project |
| Index | Project local | Global (`dev\IA\journal\`) |
