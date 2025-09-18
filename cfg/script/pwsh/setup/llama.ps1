& {
  if ($IsWindows) {
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup llama - llama-swap - (system/user) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $task = 'llama-swap'
      $taskObj = Get-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue
      if ($taskObj) {
        opPrintMaybeRunCmd Stop-ScheduledTask -TaskName $task
        opPrintMaybeRunCmd Start-Sleep -Seconds 2
        opPrintMaybeRunCmd Unregister-ScheduledTask -TaskName $task '-Confirm:$false'
        opPrintMaybeRunCmd Start-Sleep -Seconds 2
      }
      $action = New-ScheduledTaskAction `
        -Execute "${env:HOME}\.local\bin\llama-swap.exe" `
        -Argument "-config ${env:HOME}\.llama\config.yaml -listen :8080 -watch-config"
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
      opPrintCmd Register-ScheduledTask -Force -TaskName $task '<args>'
      if (-not $NOOP) {
        Register-ScheduledTask `
          -Force `
          -TaskName $task `
          -Description 'model swapping for llama.cpp' `
          -Action $action `
          -User marshall `
          -Password johnnywhoosh `
          -Settings $settings `
          -Trigger $trigger
      }
      opPrintMaybeRunCmd Start-ScheduledTask -TaskName $task
      opPrintMaybeRunCmd Start-Sleep -Seconds 2
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
