function () {
  local yn=''
  if type ollama > /dev/null; then
    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup ollama (system) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      if [[ $SYS_OS_PLAT != 'darwin' ]]; then
        local service='ollama'
        local service_file='override.conf'
        local service_file_dir="/etc/systemd/system/${service}.service.d"
        local service_file_path="${service_file_dir}/${service_file}"

        if systemctl list-units --type=service --all | grep "${service}" > /dev/null; then
          opPrintMaybeRunCmd sudo systemctl stop "${service}"
          opPrintMaybeRunCmd sudo systemctl disable "${service}"
        fi

        service_file_content=(
          '[Service]'
          'Environment=\"OLLAMA_HOST=0.0.0.0:11434\"'
          'Environment=\"OLLAMA_MODELS=/vol/models/ollama\"'
          'Environment=\"OLLAMA_MAX_LOADED_MODELS=1\"'
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
  fi
}
