#!/usr/bin/env bash
# Hook UserPromptSubmit : reinjecte a chaque message un rappel court des regles
# de redaction, et alerte si le contexte de la session approche la zone de derive.
# Mis en place le 18/06/2026 ; voir journal/26/06/18/260618-12h34-diagnostic_tics_langage_et_memoire.md

INPUT_JSON=$(cat)
export INPUT_JSON

python - <<'PYEOF'
import json, os

raw = os.environ.get('INPUT_JSON', '{}')
try:
    data = json.loads(raw)
except Exception:
    data = {}

transcript_path = data.get('transcript_path')

SEUIL_TOKENS = 80000
TAIL_BYTES = 2_000_000

def derniere_utilisation(path):
    if not path or not os.path.isfile(path):
        return None
    try:
        size = os.path.getsize(path)
        with open(path, 'rb') as f:
            if size > TAIL_BYTES:
                f.seek(size - TAIL_BYTES)
            chunk = f.read()
    except Exception:
        return None
    for line in reversed(chunk.decode('utf-8', errors='replace').splitlines()):
        line = line.strip()
        if not line:
            continue
        try:
            entry = json.loads(line)
        except Exception:
            continue
        if entry.get('type') != 'assistant':
            continue
        usage = entry.get('message', {}).get('usage')
        if not usage:
            continue
        return (
            usage.get('input_tokens', 0)
            + usage.get('cache_creation_input_tokens', 0)
            + usage.get('cache_read_input_tokens', 0)
        )
    return None

tokens = derniere_utilisation(transcript_path)

regles = (
    "Rappel de redaction (verifier avant d'envoyer) :\n"
    "- aucun cadratin ni demi-cadratin ; tiret simple avec parcimonie\n"
    "- aucun qualifiant d'auto-justification ni marqueur de sincerite "
    "(\"en toute franchise\", \"honnetement\", etc.)\n"
    "- aucune question disjonctive en texte libre : option cliquable ou agir\n"
    "- aucun jargon dev anglo-americain non traduit"
)

if tokens is not None and tokens >= SEUIL_TOKENS:
    alerte = (
        f"\nAlerte contexte : ~{tokens // 1000}k tokens dans le dernier tour, "
        "zone de derive atteinte (80 a 100k). Proposer de clore la session "
        "et d'en reprendre une neuve."
    )
else:
    alerte = ""

contexte = regles + alerte

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "additionalContext": contexte,
    }
}))
PYEOF
