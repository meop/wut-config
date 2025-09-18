& {
  if ($IsWindows) {
    $pkg = 'Microsoft.WindowsTerminal_8wekyb3d8bbwe'
    $yn = ''
    if ($YES) {
      $yn = 'y'
    } else {
      $yn = Read-Host '? setup windows-terminal - install theme (user) [y, [n]]'
    }
    if ($yn -ne 'n') {
      $profileId = "${env:LOCALAPPDATA}/Packages/${pkg}/LocalState/settings.json"
      if (Test-Path "$profileId") {
        $settingsToAdd = @{
          initialCols = 160
          initialRows = 48
          profiles    = @{
            defaults = @{
              colorScheme    = 'Tokyo Night Moon'
              cursorShape    = 'filledBox'
              elevate        = $false
              font           = @{
                face   = 'Hack Nerd Font Mono'
                size   = 11
                weight = 'normal'
              }
              historySize    = 9000
              scrollbarState = 'hidden'
            }
          }
          schemes     = @(
            , @{
              background          = '#222436'
              black               = '#1B1D2B'
              blue                = '#82AAFF'
              brightBlack         = '#444A73'
              brightBlue          = '#9AB8FF'
              brightCyan          = '#B2EBFF'
              brightGreen         = '#C7FB6D'
              brightPurple        = '#CAABFF'
              brightRed           = '#FF8D94'
              brightWhite         = '#C8D3F5'
              brightYellow        = '#FFD8AB'
              cursorColor         = '#C8D3F5'
              cyan                = '#86E1FC'
              foreground          = '#C8D3F5'
              green               = '#C3E88D'
              name                = 'Tokyo Night Moon'
              purple              = '#C099FF'
              red                 = '#FF757F'
              selectionBackground = '#2D3F76'
              white               = '#828BB8'
              yellow              = '#FFC777'
            }
          )
        }
        $settings = opPrintRunCmd Get-Content -Path "$profileId" -Raw '|' ConvertFrom-Json
        $settings | Add-Member -Force -NotePropertyName initialCols -NotePropertyValue $settingsToAdd.initialCols
        $settings | Add-Member -Force -NotePropertyName initialRows -NotePropertyValue $settingsToAdd.initialRows
        $settings.profiles.defaults | Add-Member -Force -NotePropertyName colorScheme -NotePropertyValue $settingsToAdd.profiles.defaults.colorScheme
        $settings.profiles.defaults | Add-Member -Force -NotePropertyName cursorShape -NotePropertyValue $settingsToAdd.profiles.defaults.cursorShape
        $settings.profiles.defaults | Add-Member -Force -NotePropertyName elevate -NotePropertyValue $settingsToAdd.profiles.defaults.elevate
        $settings.profiles.defaults.font | Add-Member -Force -NotePropertyName face -NotePropertyValue $settingsToAdd.profiles.defaults.font.face
        $settings.profiles.defaults.font | Add-Member -Force -NotePropertyName size -NotePropertyValue $settingsToAdd.profiles.defaults.font.size
        $settings.profiles.defaults.font | Add-Member -Force -NotePropertyName weight -NotePropertyValue $settingsToAdd.profiles.defaults.font.weight
        $settings.profiles.defaults | Add-Member -Force -NotePropertyName historySize -NotePropertyValue $settingsToAdd.profiles.defaults.historySize
        $settings.profiles.defaults | Add-Member -Force -NotePropertyName scrollbarState -NotePropertyValue $settingsToAdd.profiles.defaults.scrollbarState
        foreach ($schemeToAdd in $settingsToAdd.schemes) {
          if ($settings.schemes | Where-Object name -EQ $schemeToAdd.name) {
            continue
          }
          $settings.schemes += $schemeToAdd
        }
        opPrintMaybeRunCmd Set-Content -Path "$profileId" -Value "'$($settings | ConvertTo-Json -Depth 100)'"
      }
    }
  } else {
    Write-Host 'script is for winnt'
  }
}
