& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup webdav - set client file size limit to max (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $path = 'HKLM:\System\CurrentControlSet\Services\WebClient\Parameters'
      if (-not ((Get-ItemProperty $path).PSObject.Properties['FileSizeLimitInBytes'])) {
        opPrintMaybeRunCmd sudo pwsh -c "'New-ItemProperty `"${path}`" -Name FileSizeLimitInBytes -Value 4294967295 -PropertyType DWord'"
      } else {
        opPrintMaybeRunCmd sudo pwsh -c "'Set-ItemProperty `"${path}`" -Name FileSizeLimitInBytes -Value 4294967295'"
      }
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
