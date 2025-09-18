& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup llama-swap - (system/user) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $name = 'llama-swap'
      $description = 'model swapping for llama.cpp'
      if (Get-ScheduledTask -TaskName $name -ErrorAction SilentlyContinue) {
        opPrintMaybeRunCmd Stop-ScheduledTask -TaskName $name
        opPrintMaybeRunCmd Start-Sleep -Seconds 2
        opPrintMaybeRunCmd Unregister-ScheduledTask -TaskName $name '-Confirm:$false'
        opPrintMaybeRunCmd Start-Sleep -Seconds 2
      }
      $action = New-ScheduledTaskAction `
        -Execute 'V:\llm\bin\llama-swap.exe' `
        -Argument '-config V:\llm\llama-swap\config.yaml -listen :8080 -watch-config'
      # $principal = New-ScheduledTaskPrincipal `
      #   -Id Author `
      #   -LogonType password `
      #   -ProcessTokenSidType Default `
      #   -RunLevel limited `
      #   -UserId marshall
      $settings = New-ScheduledTaskSettingsSet `
        -Compatibility Win8 `
        -AllowStartIfOnBatteries `
        -DontStopIfGoingOnBatteries `
        -ExecutionTimeLimit (New-TimeSpan -Seconds 0) `
        -MultipleInstances IgnoreNew `
        -Priority 7 `
        -RestartCount 3 `
        -RestartInterval (New-TimeSpan -Minutes 1) `
        -StartWhenAvailable
      $trigger = New-ScheduledTaskTrigger `
        -AtStartup
      opPrintCmd Register-ScheduledTask -Force -TaskName $name '<args>'
      if (-not $NOOP) {
        Register-ScheduledTask `
          -Force `
          -TaskName $name `
          -Description $description `
          -Action $action `
          -User marshall `
          -Password johnnywhoosh `
          -Settings $settings `
          -Trigger $trigger
      }
      opPrintMaybeRunCmd Start-ScheduledTask -TaskName $name
      opPrintMaybeRunCmd Start-Sleep -Seconds 2
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
