function () {
  local yn=''
  if type podman > /dev/null; then
    local net_name='podman'
    if ! sudo podman network exists "${net_name}"; then
      if [[ $YES ]]; then
        yn='y'
      else
        read "yn?? setup podman - netavark bridge network (system) [y, [n]]: "
      fi
      if [[ $yn != 'n' ]]; then
        local bridge_name='br0' # Your existing host bridge
        # Create unmanaged bridge network with DHCP
        opPrintMaybeRunCmd sudo podman network create \
          --driver bridge \
          --ipam-driver dhcp \
          --interface-name "${bridge_name}" \
          --opt mode=unmanaged \
          "${net_name}"
      fi
    fi

    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup podman - dhcp proxy service (system) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      opPrintMaybeRunCmd sudo systemctl enable --now netavark-dhcp-proxy.socket
    fi
  fi
}
