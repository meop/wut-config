& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup ssh - disable admin authorized keys file (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $filePath = "C:\ProgramData\ssh\sshd_config"
      $findLines = @(
        , 'Match Group administrators'
        , 'AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys'
      ).ToLower()
      $output = @()
      foreach ($line in Get-Content -Path $filePath) {
        $o = $null
        $lineFormatted = $line.Trim().ToLower()
        foreach ($findLine in $findLines) {
          if ($lineFormatted -eq $findLine) {
            $o = "#${line}"
            break
          }
        }
        if (-not $o) {
          $o = $line
        }
        $output += $o
      }
      opPrintMaybeRunCmd sudo pwsh -c "'Set-Content -Path `"${filePath}`" -Value `"${output}`"'"
    }
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup ssh - set default shell to pwsh (system) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $path = 'HKLM:\SOFTWARE\OpenSSH'
      $shell = 'C:\ProgramData\ssh\shell.bat'
      opPrintMaybeRunCmd sudo pwsh -c "'New-ItemProperty `"${path}`" -Name DefaultShell -Value `"${shell}`" -PropertyType String -Force'"

      $settings = @(
        , '@echo off'
        , '`"C:\Program Files\Powershell\7\pwsh.exe`" -nologo %*'
      )
      opPrintMaybeRunCmd sudo pwsh -c "'Set-Content -Path `"$shell`" -Value `"$($settings | Out-String) -NoNewLine`"'"
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
