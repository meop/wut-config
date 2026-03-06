function () {
  local yn=''
  if type docker > /dev/null; then
    local modules_file='/etc/modules-load.d/docker.conf'
    local modules=(br_netfilter iptable_filter iptable_mangle iptable_nat)
    if [[ ! -f "${modules_file}" ]]; then
      if [[ $YES ]]; then
        yn='y'
      else
        read 'yn?? setup docker - kernel modules (system) [y, [n]]: '
      fi
      if [[ $yn != 'n' ]]; then
        for mod in "${modules[@]}"; do
          opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'""${mod}""'" '>>' "${modules_file}"'"'
        done
        for mod in "${modules[@]}"; do
          opPrintMaybeRunCmd sudo modprobe "${mod}"
        done
      fi
    fi

    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup docker - service (system) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      local service='docker'
      opPrintMaybeRunCmd sudo systemctl enable "${service}"
      opPrintMaybeRunCmd sudo systemctl start "${service}"
    fi
  fi
}
