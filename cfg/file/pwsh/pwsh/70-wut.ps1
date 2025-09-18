$env:WUT_URL = 'http://yard.lan:9000'

function wut {
  $url = "${env:WUT_URL}".TrimEnd('/')
  $url = "${url}/cli/pwsh"
  $url = "${url}/$($args -Join '/')".TrimEnd('/')

  pwsh -noprofile -c "$( Invoke-WebRequest -ErrorAction Stop -ProgressAction SilentlyContinue -Uri "${url}" )"
}
