function () {
  local yn=''
  # note: plasma has a long-time bug with multiple panels
  # where the keyboard shortcut keys get conflicted when saved
  # so a panel specific shortcut like Meta key, which is usually tied to Alt-F1
  # and is supposed to open the Start Menu, ends up opening on the new panel after reboot
  # often this is undesired
  # the only workaround to reset this behavior is to start over by erasing these
  # files and setting up new panels
  if [[ $SYS_OS_PLAT == 'linux' ]]; then
    if [[ $SYS_OS_DE_ID == 'plasma' ]]; then
      if [[ $YES ]]; then
        yn='y'
      else
        read 'yn?? repair plasma - reset global shortcuts (user) [y, [n]]: '
      fi
      if [[ $yn != 'n' ]]; then
        if [[ -f "${HOME}/.config/globalshortcutsrc" ]]; then
          opPrintMaybeRunCmd rm "${HOME}/.config/globalshortcutsrc"
        else
          echo 'plasma global shortcuts rc not found'
        fi
      fi
      if [[ $YES ]]; then
        yn='y'
      else
        read 'yn?? repair plasma panel applets (user) [y, [n]]: '
      fi
      if [[ $yn != 'n' ]]; then
        if [[ -f "${HOME}/.config/plasma-org.kde.plasma.desktop-appletsrc" ]]; then
          opPrintMaybeRunCmd rm "${HOME}/.config/plasma-org.kde.plasma.desktop-appletsrc"
        else
          echo 'plasma panel applets rc not found'
        fi
      fi
    else
      echo 'script is for plasma desktop environment'
    fi
  else
    echo 'script is for linux'
  fi
}
