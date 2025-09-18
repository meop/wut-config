# https://www.nushell.sh/book/installation.html#pre-built-binaries
function () {
  local yn=''
  if [[ $SYS_OS_PLAT == 'linux' ]]; then
    if [[ $SYS_OS_ID == 'debian' || $SYS_OS_ID == 'ubuntu' || $SYS_OS_ID == 'rocky' || $SYS_OS_ID == 'fedora' ]]; then
      if [[ $YES ]]; then
        yn='y'
      else
        read 'yn?? install nu - (system) [y, [n]]: '
      fi
      if [[ $yn != 'n' ]]; then
        if [[ $SYS_OS_ID == 'debian' || $SYS_OS_ID == 'ubuntu' ]]; then
          function install_repo {
            local output="/etc/apt/sources.list.d/fury-nushell.sources"
            local output_gpg='/etc/apt/trusted.gpg.d/fury-nushell.gpg'
            local url='https://apt.fury.io/nushell'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'curl --fail-with-body --location --no-progress-meter --url "${url}/gpg.key" '|' gpg --dearmor -o "${output_gpg}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'Types: deb'"'" '>' "${output}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'URIs: https://apt.fury.io/nushell/'"'" '>>' "${output}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'Suites: /'"'" '>>' "${output}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'Components: '"'" '>>' "${output}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'Signed-By: /etc/apt/trusted.gpg.d/fury-nushell.gpg'"'" '>>' "${output}"'"'
          }
          install_repo
          opPrintMaybeRunCmd sudo apt update '>' /dev/null '2>&1'
          opPrintMaybeRunCmd sudo apt install nushell
        elif [[ $SYS_OS_ID == 'rocky' || $SYS_OS_ID == 'fedora' ]]; then
          function install_repo {
            local output='/etc/yum.repos.d/fury-nushell.repo'
            local url='https://yum.fury.io/nushell'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'[gemfury-nushell]'"'" '>' "${output}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'name=Gemfury Nushell Repo'"'" '>>' "${output}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'baseurl=${url}/'"'" '>>' "${output}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'enabled=1'"'" '>>' "${output}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'gpgcheck=0'"'" '>>' "${output}"'"'
            opPrintMaybeRunCmd sudo --preserve-env sh -c '"'echo "'"'gpgkey=${url}/gpg.key'"'" '>>' "${output}"'"'
          }
          install_repo
          opPrintMaybeRunCmd sudo dnf check-upgrade '>' /dev/null '2>&1'
          opPrintMaybeRunCmd sudo dnf install nushell
        fi
      fi
    else
      echo 'script is for debian/ubuntu or rocky/fedora'
    fi
  else
    echo 'script is for linux'
  fi
}
