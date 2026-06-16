# Status line « disparue » après crash : diagnostic et sauvegarde du script

Note de journal — création le 31/05/2026 à 13h35, dernière mise à jour le 31/05/2026 à 13h35

## Contexte

Après un crash de Claude Code, la status line personnalisée ne s'affichait plus. Première hypothèse de l'utilisateur : la configuration avait été effacée.

## Diagnostic

La configuration n'avait **pas** été perdue. Vérifications effectuées :

- `~/.claude/settings.json` contenait toujours le bloc attendu :

  ```json
  "statusLine": {
    "type": "command",
    "command": "bash /c/Users/Guillaume/.claude/statusline-command.sh"
  }
  ```

- Le script `~/.claude/statusline-command.sh` était présent et intact (4591 octets, 152 lignes), avec un `statusline-command.sh.bak` à côté (2704 octets) comme filet de sécurité.

Conclusion : le crash avait laissé le CLI dans un état transitoire (status line non rendue). Le rechargement de l'interface l'a réaffichée, sans aucune intervention sur les fichiers. L'utilisateur a confirmé : « it's showing up again now ».

## Points de repère pour une récurrence

- Une status line de type `command` est relue à chaque rafraîchissement. Si elle disparaît mais que `settings.json` contient toujours le bloc `statusLine`, c'est presque toujours un état transitoire du CLI (ou le script qui échoue) — pas une config effacée. Un redémarrage suffit en général.
- Le script écrit deux fichiers de debug à chaque exécution, utiles pour isoler la panne :
  - `/tmp/claude-statusline-debug.json` : le JSON brut reçu sur stdin (si vide ou absent, le problème vient de Claude Code, pas du script).
  - `claude-statusline-debug.out` (dans le dossier temp) : la sortie formatée produite (si présent et correct, le script fonctionne ; le problème est l'affichage).
- En cas de corruption du script principal, restaurer depuis `~/.claude/statusline-command.sh.bak`.

## Action de sauvegarde réalisée

Le backup canonique dans le dépôt était obsolète :

- `IA/config/claude/statusline-command.sh` : 2733 octets / 148 lignes (version ancienne, sans le suivi des tokens session/jour).
- `~/.claude/statusline-command.sh` : 4591 octets / 152 lignes (version active, complète).

Le script actif a été copié vers `IA/config/claude/statusline-command.sh`. Les deux fichiers sont désormais identiques (4591 octets).

## En attente

Confirmation de l'utilisateur demandée avant toute mise à jour de la copie dans `~/.claude/` (actuellement déjà à jour ; aucune modification nécessaire en l'état).
