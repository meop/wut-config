# https://github.com/folke/tokyonight.nvim/blob/main/extras/gnome_terminal/tokyonight_moon.dconf
function () {
  local yn=''
  if type gnome-terminal > /dev/null; then
    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup gnome-terminal - install theme (user) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      local pp='/org/gnome/terminal/legacy/profiles'
      local profileId="$(dconf read "${pp}:/default" | tr -d "'")"
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/background-color" "'rgb(34, 36, 54)'" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/cursor-background-color" "'rgb(200, 211, 245)'" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/cursor-colors" "true" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/cursor-foreground-color" "'rgb(34, 36, 54)'" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/foreground-color" "'rgb(200, 211, 245)'" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/highlight-background-color" "'rgb(200, 211, 245)'" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/highlight-colors-set" "true" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/highlight-foreground-color" "'rgb(34, 36, 54)'" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/palette" '"'"['rgb(68, 74, 115)', 'rgb(255, 117, 127)', 'rgb(195, 232, 141)', 'rgb(255, 199, 119)', 'rgb(130, 170, 255)', 'rgb(192, 153, 255)', 'rgb(134, 225, 252)', 'rgb(200, 211, 245)', 'rgb(68, 74, 115)', 'rgb(255, 117, 127)', 'rgb(195, 232, 141)', 'rgb(255, 199, 119)', 'rgb(130, 170, 255)', 'rgb(192, 153, 255)', 'rgb(134, 225, 252)', 'rgb(200, 211, 245)']"'"' '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/use-theme-colors" "false" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/audible-bell" "false" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/default-size-columns" "160" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/default-size-rows" "48" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/font" "'Hack Nerd Font Mono 11'" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/scrollback-lines" "9000" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/scrollbar-policy" "'never'" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/use-system-font" "false" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/use-theme-background" "false" '>' /dev/null '2>&1'
      opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/use-theme-colors" "false" '>' /dev/null '2>&1'
    fi
  else
    echo 'gnome-terminal is not installed'
  fi
}
