function () {
  local yn=''
  if type lxterminal > /dev/null; then
    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup lxterminal - install theme (user) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      config_file_swap_from=(
        'fontname'
        'scrollback'
        'bgcolor'
        'fgcolor'
        'palette_color_0'
        'palette_color_1'
        'palette_color_2'
        'palette_color_3'
        'palette_color_4'
        'palette_color_5'
        'palette_color_6'
        'palette_color_7'
        'palette_color_8'
        'palette_color_9'
        'palette_color_10'
        'palette_color_11'
        'palette_color_12'
        'palette_color_13'
        'palette_color_14'
        'palette_color_15'
        'color_preset'
        'cursorblinks'
        'cursorunderline'
        'geometry_columns'
        'geometry_rows'
        'hidescrollbar'
      )
      # folke/tokyonight_moon
      config_file_swap_to=(
        'Hack Nerd Font Mono 11'
        '9000'
        'rgb(34,36,54)'
        'rgb(200,211,245)'
        'rgb(68,74,115)'
        'rgb(255,117,127)'
        'rgb(195,232,141)'
        'rgb(255,199,119)'
        'rgb(130,170,255)'
        'rgb(192,153,255)'
        'rgb(134,225,252)'
        'rgb(200,211,245)'
        'rgb(68,74,115)'
        'rgb(255,117,127)'
        'rgb(195,232,141)'
        'rgb(255,199,119)'
        'rgb(130,170,255)'
        'rgb(192,153,255)'
        'rgb(134,225,252)'
        'rgb(200,211,245)'
        'Custom'
        'true'
        'false'
        '160'
        '48'
        'true'
      )
      local output="${HOME}/.config/lxterminal/lxterminal.conf"
      for i in {1..${#config_file_swap_from[@]}}; do
        from="${config_file_swap_from[i]}"
        to="${config_file_swap_to[i]}"
        opPrintMaybeRunCmd sed -i "'""/^${from}=/s/=.*/=${to}/""'" "${output}"
      done
    fi
  else
    echo 'lxterminal is not installed'
  fi
}
