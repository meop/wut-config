function () {
  local yn=''
  if [[ $YES ]]; then
    yn='y'
  else
    read 'yn?? install deno - (user) [y, [n]]: '
  fi
  if [[ $yn != 'n' ]]; then
    local url='https://deno.land/install.sh'
    opPrintMaybeRunCmd sh -c '"$(' curl --fail-with-body --location --no-progress-meter --url "${url}" ')"'
  fi
}
