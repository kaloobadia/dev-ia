rm() {
  local targets=()
  for arg in "$@"; do
    [[ "$arg" == -* ]] && continue
    targets+=("$arg")
  done
  [[ ${#targets[@]} -eq 0 ]] && return 0
  local target
  for target in "${targets[@]}"; do
    local winpath
    winpath=$(cygpath -w "$target" 2>/dev/null || echo "$target")
    RECYCLE_TARGET="$winpath" powershell.exe -NoProfile -NonInteractive -Command '
      Add-Type -AssemblyName Microsoft.VisualBasic
      $p = $env:RECYCLE_TARGET
      if (Test-Path -LiteralPath $p -PathType Container) {
        [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($p, "OnlyErrorDialogs", "SendToRecycleBin")
      } elseif (Test-Path -LiteralPath $p) {
        [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($p, "OnlyErrorDialogs", "SendToRecycleBin")
      } else {
        Write-Error "rm: cannot remove: no such file or directory: $p"
        exit 1
      }
    ' || return 1
  done
}
