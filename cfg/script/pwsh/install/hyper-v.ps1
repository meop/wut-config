& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? install hyper-v - enable windows features (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      opPrintMaybeRunCmd Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
      opPrintMaybeRunCmd Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Tools-All
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
