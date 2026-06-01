#!/usr/bin/env bash
# Synchronise ~/.claude/ vers dev/IA/config/claude/, commite et pousse.
# Appelé par le hook Stop de Claude Code.

SRC="$HOME/.claude"
DEST="/c/Users/Guillaume/Documents/dev/IA/config/claude"
REPO="/c/Users/Guillaume/Documents/dev/IA"

# Sync fichiers plats
cp "$SRC/CLAUDE.md"     "$DEST/CLAUDE.md"     2>/dev/null
cp "$SRC/settings.json" "$DEST/settings.json" 2>/dev/null

# Sync dossiers (rsync avec suppression des fichiers obsolètes)
rsync -a --delete "$SRC/commands/" "$DEST/commands/" 2>/dev/null
rsync -a --delete "$SRC/agents/"   "$DEST/agents/"   2>/dev/null

# Vérifier s'il y a des changements à commiter
cd "$REPO" || exit 0
git add config/claude/ 2>/dev/null

if git diff --cached --quiet; then
  exit 0
fi

# Horodatage Paris
HEURE=$(powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('dd/MM/yyyy HH\hmm')" 2>/dev/null | tr -d '\r\n')

git commit -m "chore(sync): config Claude — $HEURE" 2>/dev/null
git push origin main 2>/dev/null

exit 0
