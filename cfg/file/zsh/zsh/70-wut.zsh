export WUT_URL='http://yard.lan:9000'

function wut {
  local url=$(echo "${WUT_URL}" | sed 's:/*$::')
  local url=$(echo "${url}/cli/zsh")
  local url=$(echo "${url}/$(echo "$*" | sed 's/ /\//g')" | sed 's:/*$::')

  zsh --no-rcs -c "$( curl --fail-with-body --location --no-progress-meter --url "${url}" )"
}
