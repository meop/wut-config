function () {
  local yn=''
  if type llama-swap > /dev/null; then
    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup llama-swap - (system/user) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      if [[ $SYS_OS_PLAT == 'darwin' ]]; then
        local service='com.llama-swap'
        local service_file="${service}.plist"
        local service_file_path="${HOME}/Library/LaunchAgents/${service_file}"

        local output="${service_file_path}"
        local url="${REQ_URL_CFG}/bak/${SYS_HOST}/llama-swap/${service_file}"
        opPrintMaybeRunCmd curl --fail-with-body --location --no-progress-meter --output "${output}" --url "${url}"

        if launchctl list | grep "${service}" > /dev/null; then
          opPrintMaybeRunCmd launchctl stop "${service}"
          opPrintMaybeRunCmd launchctl bootout "gui/$(id -u $USER)" "${service_file_path}"
          opPrintMaybeRunCmd launchctl disable "gui/$(id -u $USER)/${service}"
        fi
        opPrintMaybeRunCmd launchctl enable "gui/$(id -u $USER)/${service}"
        opPrintMaybeRunCmd launchctl bootstrap "gui/$(id -u $USER)" "${service_file_path}"
        opPrintMaybeRunCmd launchctl start "${service}"
      else
        local service='llama-swap'
        local service_file="${service}.service"
        local service_file_path="/etc/systemd/system/${service_file}"

        local output="${service_file_path}"
        local url="${REQ_URL_CFG}/bak/${SYS_HOST}/llama-swap/${service_file}"
        opPrintMaybeRunCmd sudo curl --fail-with-body --location --no-progress-meter --output "${output}" --url "${url}"
        opPrintMaybeRunCmd sudo mv "${output}" "${service_file_path}"
        opPrintMaybeRunCmd sudo systemctl daemon-reload

        if systemctl list-units --type=service --all | grep "${service}" > /dev/null; then
          opPrintMaybeRunCmd sudo systemctl stop "${service}"
          opPrintMaybeRunCmd sudo systemctl disable "${service}"
        fi
        opPrintMaybeRunCmd sudo systemctl enable "${service}"
        opPrintMaybeRunCmd sudo systemctl start "${service}"
      fi
    fi
  else
    echo 'llama-swap is not installed'
  fi
}
