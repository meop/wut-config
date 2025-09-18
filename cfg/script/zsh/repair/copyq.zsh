function () {
  local yn=''
  if [[ -d /Applications/CopyQ.app ]]; then
    if type brew > /dev/null; then
      yn='y'
    else
      read 'yn?? repair copyq - sign app (system) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      opPrintMaybeRunCmd xattr -rd com.apple.quarantine /Applications/CopyQ.app
      opPrintMaybeRunCmd codesign --force --deep --sign - /Applications/CopyQ.app
    fi
  else
    echo 'copyq is not installed'
  fi
}
