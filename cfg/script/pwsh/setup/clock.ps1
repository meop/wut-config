& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup clock - set rtc to utc (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $path = 'HKLM:\System\CurrentControlSet\Control\TimeZoneInformation'
      opPrintMaybeRunCmd sudo pwsh -c "'New-ItemProperty `"${path}`" -Name RealTimeIsUniversal -Value 1 -PropertyType QWord -Force'"
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
