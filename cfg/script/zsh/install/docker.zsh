# https://docs.docker.com/engine/install/
function () {
  local yn=''
  if [[ $SYS_OS_PLAT == 'linux' ]]; then
    if [[ $SYS_OS_ID == 'debian' || $SYS_OS_ID == 'ubuntu' ]]; then
      if [[ $YES ]]; then
        yn='y'
      else
        read 'yn?? install docker - (system) [y, [n]]: '
      fi
      if [[ $yn != 'n' ]]; then
        function install_repo {
          local output_key='/etc/apt/keyrings/docker.asc'
          local url="https://download.docker.com/linux/${SYS_OS_ID}"
          opPrintMaybeRunCmd sudo install -m 0755 -d /etc/apt/keyrings
          opPrintMaybeRunCmd sudo curl --fail-with-body --location --no-progress-meter --output "${output_key}" --url "${url}"/gpg
          opPrintMaybeRunCmd sudo chmod a+r "${output_key}"

          local output='/etc/apt/sources.list.d/docker.list'
          local arch="$(dpkg --print-architecture)"
          opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"deb '['arch="${arch}" signed-by="${output_key}"']' "${url}" "${SYS_OS_VER_CODE}" stable"'" '>' "${output}"'"'
        }
        install_repo
        opPrintMaybeRunCmd sudo apt update '>' /dev/null '2>&1'
        opPrintMaybeRunCmd sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
      fi
    else
      echo 'script is for debian/ubuntu'
    fi
  else
    echo 'script is for linux'
  fi
}
