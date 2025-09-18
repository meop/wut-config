if (Get-Command fzf -ErrorAction Ignore) {
  if (Test-Path "${HOME}/.fzf/theme.ps1") {
    . "${HOME}/.fzf/theme.ps1"
  }
}
