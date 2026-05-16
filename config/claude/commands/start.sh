#!/bin/bash

# Script de démarrage — Projet Biblio64
# Usage: bash .claude/commands/start.sh

echo "═══════════════════════════════════════════════════════════════"
echo "  🚀 DÉMARRAGE — Projet Biblio64 (Enquête Bénévoles)"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Date/heure actuelle
echo "📅 Session : $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# Contexte du projet
echo "📚 CONTEXTE"
echo "───────────────────────────────────────────────────────────────"
if [ -f "docs/plan/2604291047-axe00-methodologie.md" ]; then
  head -5 docs/plan/2604291047-axe00-methodologie.md | grep -v "^---" | tail -3
fi
echo "📖 Document de référence : docs/plan/2604291047-axe00-methodologie.md"
echo ""

# État Git
echo "🔀 ÉTA GIT"
echo "───────────────────────────────────────────────────────────────"
echo "Branche : $(git branch --show-current)"
echo "Commits récents :"
git log --oneline -5 | sed 's/^/  /'
echo ""
echo "Fichiers modifiés :"
if [ -z "$(git status --porcelain)" ]; then
  echo "  ✓ Aucun changement en attente"
else
  git status --porcelain | sed 's/^/  /'
fi
echo ""

# Mémoire persistante
echo "🧠 MÉMOIRE PERSISTANTE"
echo "───────────────────────────────────────────────────────────────"
if [ -f ".claude/projects/C--Users-Guillaume-Documents-Dev-enquete-benevole/memory/MEMORY.md" ]; then
  cat ".claude/projects/C--Users-Guillaume-Documents-Dev-enquete-benevole/memory/MEMORY.md"
else
  echo "  ⚠️  Aucune mémoire persistante trouvée"
fi
echo ""

# Plans d'analyse en cours
echo "📋 PLANS D'ANALYSE"
echo "───────────────────────────────────────────────────────────────"
if [ -d "docs/plan" ]; then
  echo "Plans actifs :"
  find docs/plan -maxdepth 1 -name "*.md" -not -path "*/archives/*" | sort | sed 's/^/  /'
else
  echo "  ⚠️  Dossier docs/plan/ non trouvé"
fi
echo ""

# Environnement Python
echo "🐍 ENVIRONNEMENT PYTHON"
echo "───────────────────────────────────────────────────────────────"
VENV_PATH=".venv/Scripts/python.exe"
if [ -f "$VENV_PATH" ]; then
  echo "✓ Environnement virtuel détecté : $VENV_PATH"
  echo "  Version : $("$VENV_PATH" --version)"
else
  echo "⚠️  Environnement virtuel non trouvé"
fi
echo ""

# Recommandations
echo "💡 RECOMMANDATIONS"
echo "───────────────────────────────────────────────────────────────"
echo "  1. Consulter CLAUDE.md pour les conventions et règles"
echo "  2. Vérifier le dernier commit pour le contexte"
echo "  3. Lire la mémoire persistante (MEMORY.md) ci-dessus"
echo "  4. Ouvrir docs/plan/2604291047-axe00-methodologie.md en cas de doute"
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "✅ Contexte chargé. Prêt à commencer."
echo "═══════════════════════════════════════════════════════════════"
