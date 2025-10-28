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
      if (-not ((Get-ItemProperty $path).PSObject.Properties['LongPathsEnabled'])) {
        opPrintMaybeRunCmd pwsh -c "'New-ItemProperty `"${path}`" -Name LongPathsEnabled -Value 1 -PropertyType DWord'"
      } else {
        opPrintMaybeRunCmd pwsh -c "'Set-ItemProperty `"${path}`" -Name LongPathsEnabled -Value 1'"
      }
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
