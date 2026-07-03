#!/usr/bin/env bash
# Synchronise ~/.claude/ vers dev/IA/config/claude/, commite et pousse.
# Appelé par le hook Stop de Claude Code.
# Fail loud : tout échec est tracé dans $ERRLOG et signalé sur stderr
# (le contenu de $ERRLOG est le marqueur à consulter en cas de doute).

SRC="$HOME/.claude"
DEST="/c/Users/Guillaume/Documents/chantiers/dev/IA/config/claude"
REPO="/c/Users/Guillaume/Documents/chantiers/dev/IA"
ERRLOG="$HOME/.claude/sync-config.err"

ECHECS=""
signaler() {
  ECHECS="${ECHECS}${1}\n"
}

# Sync fichiers plats
cp "$SRC/CLAUDE.md"     "$DEST/CLAUDE.md"     || signaler "cp CLAUDE.md"
cp "$SRC/settings.json" "$DEST/settings.json" || signaler "cp settings.json"

# Sync des scripts de hooks et utilitaires (.sh a la racine de ~/.claude)
for sh in "$SRC"/*.sh; do
  [ -f "$sh" ] && { cp "$sh" "$DEST/" || signaler "cp $(basename "$sh")"; }
done

# Sync dossiers (cp + suppression des fichiers obsolètes)
sync_dir() {
  local src="$1" dest="$2"
  mkdir -p "$dest"
  # Copier les fichiers source
  for f in "$src"/*; do
    [ -f "$f" ] && { cp "$f" "$dest/" || signaler "cp $(basename "$f") vers $dest"; }
  done
  # Supprimer les fichiers dans dest qui n'existent plus dans src
  for f in "$dest"/*; do
    [ -f "$f" ] && [ ! -f "$src/$(basename "$f")" ] && { rm "$f" || signaler "rm $(basename "$f")"; }
  done
}
sync_dir "$SRC/commands" "$DEST/commands"
sync_dir "$SRC/agents"   "$DEST/agents"

conclure() {
  if [ -n "$ECHECS" ]; then
    HORODATE=$(date '+%Y-%m-%d %H:%M:%S')
    printf '%s — échecs sync-config.sh :\n%b' "$HORODATE" "$ECHECS" >> "$ERRLOG"
    printf 'sync-config.sh : échecs détectés, voir %s\n%b' "$ERRLOG" "$ECHECS" >&2
    exit 1
  fi
  # Plus d'échec en attente : purger le marqueur
  rm -f "$ERRLOG"
  exit 0
}

# Vérifier s'il y a des changements à commiter
cd "$REPO" || { signaler "cd $REPO"; conclure; }
git add config/claude/ || signaler "git add config/claude/"

if git diff --cached --quiet; then
  conclure
fi

# Horodatage Paris
HEURE=$(powershell.exe -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('dd/MM/yyyy HH\hmm')" 2>/dev/null | tr -d '\r\n')
[ -n "$HEURE" ] || HEURE=$(date '+%d/%m/%Y %Hh%M')

git commit -m "chore(sync): config Claude — $HEURE" || signaler "git commit"
git push origin main || signaler "git push origin main"

conclure
