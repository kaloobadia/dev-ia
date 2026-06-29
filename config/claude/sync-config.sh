#!/usr/bin/env bash
# Synchronise ~/.claude/ vers dev/IA/config/claude/, commite et pousse.
# Appelé par le hook Stop de Claude Code.

SRC="$HOME/.claude"
DEST="/c/Users/Guillaume/Documents/chantiers/dev/IA/config/claude"
REPO="/c/Users/Guillaume/Documents/chantiers/dev/IA"

# Sync fichiers plats
cp "$SRC/CLAUDE.md"     "$DEST/CLAUDE.md"     2>/dev/null
cp "$SRC/settings.json" "$DEST/settings.json" 2>/dev/null

# Sync des scripts de hooks et utilitaires (.sh a la racine de ~/.claude)
for sh in "$SRC"/*.sh; do
  [ -f "$sh" ] && cp "$sh" "$DEST/"
done

# Sync dossiers (cp + suppression des fichiers obsolètes)
sync_dir() {
  local src="$1" dest="$2"
  mkdir -p "$dest"
  # Copier les fichiers source
  for f in "$src"/*; do
    [ -f "$f" ] && cp "$f" "$dest/"
  done
  # Supprimer les fichiers dans dest qui n'existent plus dans src
  for f in "$dest"/*; do
    [ -f "$f" ] && [ ! -f "$src/$(basename "$f")" ] && rm "$f"
  done
}
sync_dir "$SRC/commands" "$DEST/commands"
sync_dir "$SRC/agents"   "$DEST/agents"

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
