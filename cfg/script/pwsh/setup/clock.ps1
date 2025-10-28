& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? repair clock - set rtc to utc (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $path = 'HKLM:\System\CurrentControlSet\Control\TimeZoneInformation'
      if (-not ((Get-ItemProperty $path).PSObject.Properties['RealTimeIsUniversal'])) {
        opPrintMaybeRunCmd sudo pwsh -c "'New-ItemProperty `"${path}`" -Name RealTimeIsUniversal -Value 1 -PropertyType QWord'"
      } else {
        opPrintMaybeRunCmd sudo pwsh -c "'Set-ItemProperty `"${path}`" -Name RealTimeIsUniversal -Value 1'"
      }
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
