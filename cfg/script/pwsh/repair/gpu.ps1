& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? repair gpu - set msi properties (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $root_pci_base_id = '10DE' # nvidia
      $root_path = 'HKLM:\SYSTEM\CurrentControlSet\Enum\PCI'
      foreach ($pci_dev_desc_key in (Get-ChildItem $root_path -Name)) {
        if ($pci_dev_desc_key -match $root_pci_base_id) {
          foreach ($key in (Get-ChildItem (Join-Path $root_path $pci_dev_desc_key) -Name)) {
            $path = Join-Path $root_path $pci_dev_desc_key $key 'Device Parameters' 'Interrupt Management' 'MessageSignaledInterruptProperties'
            if (-not (Test-Path $path)) {
              opPrintMaybeRunCmd sudo pwsh -c "'New-Item `"${path}`" -ItemType Directory -Force > `$null'"
            }
            if (-not ((Get-ItemProperty $path).PSObject.Properties['MSISupported'])) {
              opPrintMaybeRunCmd sudo pwsh -c "'New-ItemProperty `"${path}`" -Name MSISupported -Value 1 -PropertyType DWord'"
            } else {
              opPrintMaybeRunCmd sudo pwsh -c "'Set-ItemProperty `"${path}`" -Name MSISupported -Value 1'"
            }
          }
        }
      }
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
