& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup wsl - disable hyper-v firewall (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      opPrintMaybeRunCmd Set-NetFirewallHyperVVMSetting -Name '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' -DefaultInboundAction Allow
    }
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup wsl - install hyper-v external switch (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      opPrintMaybeRunCmd New-VMSwitch -Name 'External' -NetAdapterName 'Ethernet' -AllowManagementOS $true
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
