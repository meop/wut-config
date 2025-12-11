function () {
  local yn=''
  if type llama-swap > /dev/null; then
    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup llama - setup llama-swap - (system/user) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      if [[ $SYS_OS_PLAT == 'darwin' ]]; then
        local service='com.llama-swap'
        local service_file="${service}.plist"
        local service_file_path="${HOME}/Library/LaunchAgents/${service_file}"

        if launchctl list | grep "${service}" > /dev/null; then
          opPrintMaybeRunCmd launchctl stop "${service}"
          opPrintMaybeRunCmd launchctl bootout "gui/$(id -u $USER)" "${service_file_path}"
          opPrintMaybeRunCmd launchctl disable "gui/$(id -u $USER)/${service}"
        fi

        service_file_content=(
          '<?xml version=\"1.0\" encoding=\"UTF-8\"?>'
          '<!DOCTYPE plist PUBLIC \"~//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">'
          '<plist version=\"1.0\">'
          '<dict>'
          '  <key>Label</key>'
          '  <string>com.llama-swap</string>'
          '  <key>ProgramArguments</key>'
          '  <array>'
          '    <string>/opt/homebrew/bin/llama-swap</string>'
          '    <string>-config</string>'
          "    <string>${HOME}/.llama/config.yaml</string>"
          '    <string>-listen</string>'
          '    <string>:8080</string>'
          '    <string>-watch-config</string>'
          '  </array>'
          ''
          '  <key>RunAtLoad</key>'
          '  <true/>'
          '  <key>KeepAlive</key>'
          '  <true/>'
          ''
          '  <key>StandardOutPath</key>'
          '  <string>/tmp/llama-swap.stdout</string>'
          '  <key>StandardErrorPath</key>'
          '  <string>/tmp/llama-swap.stderr</string>'
          '</dict>'
          '</plist>'
        )
        if [[ -f "${service_file_path}" ]]; then
          opPrintMaybeRunCmd sh -c '"'rm -f "${service_file_path}"'"'
        fi
        for line in "${service_file_content[@]}"; do
          opPrintMaybeRunCmd sh -c '"'echo "'""${line}""'" '>>' "${service_file_path}"'"'
        done

        opPrintMaybeRunCmd launchctl enable "gui/$(id -u $USER)/${service}"
        opPrintMaybeRunCmd launchctl bootstrap "gui/$(id -u $USER)" "${service_file_path}"
        opPrintMaybeRunCmd launchctl start "${service}"
      else
        local service='llama-swap'
        local service_file="${service}.service"
        local service_file_dir='/etc/systemd/system'
        local service_file_path="${service_file_dir}/${service_file}"

        if systemctl list-units --type=service --all | grep "${service}" > /dev/null; then
          opPrintMaybeRunCmd sudo systemctl stop "${service}"
          opPrintMaybeRunCmd sudo systemctl disable "${service}"
        fi

        service_file_content=(
          '[Unit]'
          'Description=model swapping for llama.cpp'
          ''
          '[Service]'
          "ExecStart=/usr/bin/llama-swap -config ${HOME}/.llama/config.yaml -listen :8080 -watch-config"
          "User=${USER}"
          "Group=${USER}"
          'Restart=always'
          ''
          '[Install]'
          'WantedBy=multi-user.target'
        )
        if [[ -f "${service_file_path}" ]]; then
          opPrintMaybeRunCmd sudo --preserve-env sh -c '"'rm -f "${service_file_path}"'"'
        else
          opPrintMaybeRunCmd sudo --preserve-env sh -c '"'mkdir -p "${service_file_dir}" '>' /dev/null '2>&1''"'
        fi
        for line in "${service_file_content[@]}"; do
          opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'""${line}""'" '>>' "${service_file_path}"'"'
        done

        opPrintMaybeRunCmd sudo systemctl daemon-reload
        opPrintMaybeRunCmd sudo systemctl enable "${service}"
        opPrintMaybeRunCmd sudo systemctl start "${service}"
      fi
    fi
  else
    echo 'llama-swap is not installed'
  fi
}
