& {
  if ($IsWindows) {
    $yn = ''
    function expand_github_release_assets ([string]$url, [string[]]$patterns) {
      $res = (opPrintMaybeRunCmd Invoke-WebRequest -ErrorAction Stop -ProgressAction SilentlyContinue -Uri "${url}") |
        ConvertFrom-Json
      if (-not $NOOP) {
        $task = 'llama-swap'
        $taskWasRunning = $false
        $taskObj = Get-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue
        if ($taskObj -and ($taskObj.State -eq 'running')) {
          $taskWasRunning = $true
          opPrintMaybeRunCmd Stop-ScheduledTask -TaskName $task
          opPrintMaybeRunCmd Start-Sleep -Seconds 2
        }
        $url_assets = @()
        foreach ($pattern in $patterns) {
          $url_assets += $res.assets |
            Where-Object { $_.browser_download_url -like $pattern } |
            Select-Object -ExpandProperty browser_download_url
        }
        foreach ($url_asset in $url_assets) {
          $output = "${HOME}\$($url_asset.Split('/')[-1])"
          opPrintRunCmd Invoke-WebRequest -ErrorAction Stop -ProgressAction SilentlyContinue -OutFile "${output}" -Uri "${url_asset}"
          opPrintRunCmd Expand-Archive -Force -Path "${output}" -DestinationPath "${env:HOME}\.local\bin"
          opPrintRunCmd Remove-Item -Path "${output}"
        }
        if ($taskWasRunning) {
          opPrintMaybeRunCmd Start-ScheduledTask -TaskName $task
          opPrintMaybeRunCmd Start-Sleep -Seconds 2
        }
      }
    }
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? install llama - llama-swap (user) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $arch = if ($SYS_CPU_ARCH -eq 'x86_64') {
        'amd64'
      } elseif ($SYS_CPU_ARCH -eq 'aarch64') {
        'arm64'
      } else {
        $SYS_CPU_ARCH
      }
      $url = 'https://api.github.com/repos/mostlygeek/llama-swap/releases/latest'
      $patterns = @(
        , "*windows*${arch}.zip"
      )
      expand_github_release_assets $url $patterns
    }
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? install llama - llama.cpp (user) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $arch = if ($SYS_CPU_ARCH -eq 'x86_64') {
        'x64'
      } elseif ($SYS_CPU_ARCH -eq 'aarch64') {
        'arm64'
      } else {
        $SYS_CPU_ARCH
      }
      $url = 'https://api.github.com/repos/ggml-org/llama.cpp/releases/latest'
      $patterns = @(
        , "*win-cuda*${arch}.zip"
        # , "*win-vulkan*${llama_cpp_arch}.zip"
      )
      expand_github_release_assets $url $patterns
    }
  }
}
