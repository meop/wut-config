& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup fs - enable long paths (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $path = 'HKLM:\System\CurrentControlSet\Control\FileSystem'
      opPrintMaybeRunCmd sudo pwsh -c "'New-ItemProperty `"${path}`" -Name LongPathsEnabled -Value 1 -PropertyType DWord -Force'"
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
