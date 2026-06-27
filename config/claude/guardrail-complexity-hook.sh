#!/usr/bin/env bash
# Hook PreToolUse (matcher Write) : garde-fou contre la sur-ingenierie.
# Compte les fichiers REELLEMENT nouveaux crees dans le tour courant.
# Au-dela du seuil, bloque UNE fois (exit 2) pour forcer une pause et un
# AskUserQuestion sur l'ampleur ; ne se redeclenche plus dans le meme tour.
# Le compteur est remis a zero a chaque message par prompt-reminder-hook.sh.
# Mis en place le 27/06/2026.

INPUT_JSON=$(cat)
export INPUT_JSON

python - <<'PYEOF'
import json, os, sys

raw = os.environ.get('INPUT_JSON', '{}')
try:
    data = json.loads(raw)
except Exception:
    data = {}

tool = data.get('tool_name', '')
tool_input = data.get('tool_input', {}) or {}
session = data.get('session_id') or 'default'

# Seuil : au-dela de ce nombre de NOUVEAUX fichiers dans le tour, on s'arrete.
SEUIL_FICHIERS = 3

state_dir = os.path.expanduser('~/.claude/.state')
os.makedirs(state_dir, exist_ok=True)
count_path = os.path.join(state_dir, f'newfiles-{session}.txt')
fired_path = os.path.join(state_dir, f'fired-{session}.txt')

def laisser_passer():
    raise SystemExit(0)

# On ne s'interesse qu'a la creation de fichiers via Write.
if tool != 'Write':
    laisser_passer()

fp = tool_input.get('file_path') or ''
# Un fichier deja existant = edition, pas un echafaudage : on laisse passer.
if not fp or os.path.exists(fp):
    laisser_passer()

try:
    n = int(open(count_path).read().strip())
except Exception:
    n = 0
n += 1
with open(count_path, 'w') as f:
    f.write(str(n))

deja_declenche = os.path.exists(fired_path)

if n > SEUIL_FICHIERS and not deja_declenche:
    open(fired_path, 'w').close()
    msg = (
        f"Garde-fou complexite : {n}e nouveau fichier dans ce tour. "
        "Arrete-toi avant de poursuivre l'echafaudage. Verifie que cette "
        "ampleur a bien ete demandee ou validee. Sinon, resume en une phrase "
        "ce que tu es en train de construire et demande a l'utilisateur, via "
        "AskUserQuestion, s'il veut cette ampleur ou un perimetre plus etroit. "
        "Ce garde-fou ne se redeclenchera plus dans ce tour : si l'ampleur est "
        "justifiee, relance le meme Write et continue."
    )
    print(msg, file=sys.stderr)
    raise SystemExit(2)

laisser_passer()
PYEOF
