function () {
  local yn=''
  if [[ $SYS_OS_PLAT == 'linux' ]]; then
    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? install font - nerd fonts (local) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      local share="${XDG_DATA_HOME:-${HOME}/.local/share}"
      local fonts="${share}/fonts"
      opPrintMaybeRunCmd mkdir -p "${fonts}" '>' /dev/null '2>&1'
      local output="${HOME}/Hack.zip"
      local url='https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip'
      opPrintMaybeRunCmd curl --fail-with-body --location --no-progress-meter --output "${output}" --url "${url}"
      opPrintMaybeRunCmd unzip -q "${output}" -d "${output}.unzip"
      opPrintMaybeRunCmd cp "${output}.unzip"'/*.ttf' "${fonts}"
      opPrintMaybeRunCmd rm -r -f "${output}"'*'
      local output="${HOME}/FiraCode.zip"
      local url='https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip'
      opPrintMaybeRunCmd curl --fail-with-body --location --no-progress-meter --output "${output}" --url "${url}"
      opPrintMaybeRunCmd unzip -q "${output}" -d "${output}.unzip"
      opPrintMaybeRunCmd cp "${output}.unzip"'/*.ttf' "${fonts}"
      opPrintMaybeRunCmd rm -r -f "${output}"'*'
    fi
  else
    echo 'script is for linux'
  fi
}
