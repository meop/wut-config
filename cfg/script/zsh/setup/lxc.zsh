function () {
  local yn=''
  if type lxc-start > /dev/null; then
    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup lxc (system) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      local service='lxc'
      opPrintMaybeRunCmd sudo systemctl enable "${service}"
      opPrintMaybeRunCmd sudo systemctl start "${service}"
    fi
  fi
}
