& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? install claude - (user) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $url = 'https://claude.ai/install.ps1'
      opPrintMaybeRunCmd Invoke-Expression '"$(' Invoke-WebRequest -ErrorAction Stop -ProgressAction SilentlyContinue -Uri "${url}" ')"'
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
