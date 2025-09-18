function () {
  local yn=''
  if type lxterminal > /dev/null; then
    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup lxterminal - install theme (user) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      local output="${HOME}/.config/lxterminal/lxterminal.conf"
      opPrintMaybeRunCmd sed -i ''\''/^fontname=/s/=.*/=Hack Nerd Font Mono 11/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^scrollback=/s/=.*/=9000/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^bgcolor=/s/=.*/=rgb(34,36,54)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^fgcolor=/s/=.*/=rgb(200,211,245)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_0=/s/=.*/=rgb(68,74,115)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_1=/s/=.*/=rgb(255,117,127)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_2=/s/=.*/=rgb(195,232,141)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_3=/s/=.*/=rgb(255,199,119)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_4=/s/=.*/=rgb(130,170,255)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_5=/s/=.*/=rgb(192,153,255)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_6=/s/=.*/=rgb(134,225,252)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_7=/s/=.*/=rgb(200,211,245)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_8=/s/=.*/=rgb(68,74,115)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_9=/s/=.*/=rgb(255,117,127)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_10=/s/=.*/=rgb(195,232,141)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_11=/s/=.*/=rgb(255,199,119)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_12=/s/=.*/=rgb(130,170,255)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_13=/s/=.*/=rgb(192,153,255)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_14=/s/=.*/=rgb(134,225,252)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^palette_color_15=/s/=.*/=rgb(200,211,245)/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^color_preset=/s/=.*/=Custom/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^cursorblinks=/s/=.*/=true/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^cursorunderline=/s/=.*/=false/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^geometry_columns=/s/=.*/=160/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^geometry_rows=/s/=.*/=48/'''\' "${output}"
      opPrintMaybeRunCmd sed -i ''\''/^hidescrollbar=/s/=.*/=true/'''\' "${output}"
    fi
  else
    echo 'lxterminal is not installed'
  fi
}
