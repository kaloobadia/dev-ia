#!/usr/bin/env bash
# Claude Code status line -- parsing et formatage via Python (jq non disponible)

CLAUDE_STATUS_JSON=$(cat)

# DEBUG : capturer le JSON brut pour diagnostic
echo "$CLAUDE_STATUS_JSON" > /tmp/claude-statusline-debug.json

export CLAUDE_STATUS_JSON

python - <<'PYEOF'
import json, os, subprocess, datetime, tempfile

def fmt(n):
    n = int(n)
    if n >= 1000:
        return f"{round(n / 1000)}k"
    return str(n)

raw = os.environ.get('CLAUDE_STATUS_JSON', '{}')

try:
    d = json.loads(raw)
except Exception:
    d = {}

model    = d.get('model', {}).get('display_name', 'unknown')

cw       = d.get('context_window', {})
cu       = cw.get('current_usage', {})
used_pct = cw.get('used_percentage')
in_tok   = cu.get('input_tokens')
out_tok  = cu.get('output_tokens')
cw_tok   = cu.get('cache_creation_input_tokens', 0) or 0
cr_tok   = cu.get('cache_read_input_tokens', 0) or 0

# Lecture tokens depuis un fichier JSONL — retourne (new, cache, out)
def read_jsonl_tokens(path):
    t_new = t_cache = t_out = 0
    with open(path, encoding='utf-8', errors='replace') as tf:
        for tline in tf:
            tline = tline.strip()
            if not tline:
                continue
            try:
                entry = json.loads(tline)
            except Exception:
                continue
            if entry.get('type') != 'assistant':
                continue
            u = entry.get('message', {}).get('usage', {})
            if not u:
                continue
            t_new   += u.get('input_tokens', 0) + u.get('cache_creation_input_tokens', 0)
            t_cache += u.get('cache_read_input_tokens', 0)
            t_out   += u.get('output_tokens', 0)
    return t_new, t_cache, t_out

# Tokens cumules session
transcript_path = d.get('transcript_path')
total_new = total_cache = total_out = None
if transcript_path:
    try:
        total_new, total_cache, total_out = read_jsonl_tokens(transcript_path)
    except Exception:
        pass

# Tokens cumules jour (tous les JSONL du projet crees aujourd'hui)
day_new = day_cache = day_out = None
if transcript_path:
    try:
        transcript_dir = os.path.dirname(transcript_path)
        today = datetime.date.today()
        d_new = d_cache = d_out = 0
        for fname in os.listdir(transcript_dir):
            if not fname.endswith('.jsonl'):
                continue
            fpath = os.path.join(transcript_dir, fname)
            if datetime.date.fromtimestamp(os.path.getmtime(fpath)) != today:
                continue
            fn, fc, fo = read_jsonl_tokens(fpath)
            d_new   += fn
            d_cache += fc
            d_out   += fo
        day_new, day_cache, day_out = d_new, d_cache, d_out
    except Exception:
        pass

YELLOW = "\033[33m"
GREEN  = "\033[32m"
RED    = "\033[31m"
WHITE  = "\033[97m"
RESET  = "\033[0m"

# Pourcentage de contexte
if used_pct is not None:
    pct = int(round(used_pct))
    ctx = f"{pct}%"
else:
    ctx = "--%"

# Tokens du tour
if in_tok is not None and out_tok is not None:
    new_tok = in_tok + cw_tok
    tok_str = f"turn: new:{GREEN}{fmt(new_tok)}{RESET} cache:{GREEN}{fmt(cr_tok)}{RESET} out:{RED}{fmt(out_tok)}{RESET}"
else:
    tok_str = "turn: new:-- cache:-- out:--"

# Tokens cumules session
if total_new is not None:
    session_tok_str = f"session: new:{GREEN}{fmt(total_new)}{RESET} cache:{GREEN}{fmt(total_cache)}{RESET} out:{RED}{fmt(total_out)}{RESET}"
else:
    session_tok_str = ""

# Tokens cumules jour
if day_new is not None:
    day_tok_str = f"day: new:{GREEN}{fmt(day_new)}{RESET} cache:{GREEN}{fmt(day_cache)}{RESET} out:{RED}{fmt(day_out)}{RESET}"
else:
    day_tok_str = ""

# Heure Paris
try:
    result = subprocess.run(
        ['powershell.exe', '-Command',
         "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, 'Romance Standard Time').ToString('HH:mm  ddd dd MMM')"],
        capture_output=True, text=True, timeout=2
    )
    dt = result.stdout.strip()
except Exception:
    dt = datetime.datetime.now().strftime('%H:%M  %a %d %b')

if "  " in dt:
    time_part, date_part = dt.split("  ", 1)
    dt_s = f"{WHITE}{time_part}{RESET}  {WHITE}{date_part}{RESET}"
else:
    dt_s = dt

parts = [
    f"{WHITE}{model}{RESET}",
    f"ctx {YELLOW}{ctx}{RESET}",
    tok_str,
]
if session_tok_str:
    parts.append(session_tok_str)
if day_tok_str:
    parts.append(day_tok_str)
parts.append(dt_s)
output = "  |  ".join(parts)
with open(os.path.join(tempfile.gettempdir(), "claude-statusline-debug.out"), "w") as f:
    f.write(repr(output) + "\n")
print(output)
PYEOF
