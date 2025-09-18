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
      config_file_swap_from=(
        'background-color'
        'cursor-background-color'
        'cursor-colors'
        'cursor-foreground-color'
        'foreground-color'
        'highlight-background-color'
        'highlight-colors-set'
        'highlight-foreground-color'
        'palette'
        'use-theme-colors'
        'audible-bell'
        'default-size-columns'
        'default-size-rows'
        'font'
        'scrollback-lines'
        'scrollbar-policy'
        'use-system-font'
        'use-theme-background'
        'use-theme-colors'
      )
      config_file_swap_to=(
        "'rgb(34, 36, 54)'"
        "'rgb(200, 211, 245)'"
        'true'
        "'rgb(34, 36, 54)'"
        "'rgb(200, 211, 245)'"
        "'rgb(200, 211, 245)'"
        'true'
        "'rgb(34, 36, 54)'"
        "\"['rgb(68, 74, 115)', 'rgb(255, 117, 127)', 'rgb(195, 232, 141)', 'rgb(255, 199, 119)', 'rgb(130, 170, 255)', 'rgb(192, 153, 255)', 'rgb(134, 225, 252)', 'rgb(200, 211, 245)', 'rgb(68, 74, 115)', 'rgb(255, 117, 127)', 'rgb(195, 232, 141)', 'rgb(255, 199, 119)', 'rgb(130, 170, 255)', 'rgb(192, 153, 255)', 'rgb(134, 225, 252)', 'rgb(200, 211, 245)']\""
        'false'
        'false'
        '160'
        '48'
        "'Hack Nerd Font Mono 11'"
        '9000'
        "'never'"
        'false'
        'false'
        'false'
      )
      local pp='/org/gnome/terminal/legacy/profiles'
      local profileId="$(dconf read "${pp}:/default" | tr -d "'")"
      for i in {1..${#config_file_swap_from[@]}}; do
        from="${config_file_swap_from[i]}"
        to="${config_file_swap_to[i]}"
        opPrintMaybeRunCmd dconf write "${pp}:/:${profileId}/${from}" "${to}"
      done
    fi
  else
    echo 'gnome-terminal is not installed'
  fi
}
