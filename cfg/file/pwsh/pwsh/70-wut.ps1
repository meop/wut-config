$env:WUT_URL = 'http://yard.lan:9000'

function wut {
  $url = "${env:WUT_URL}".TrimEnd('/')
  $url = "${url}/sh/pwsh"
  $url = "${url}/$($args -join '/')".TrimEnd('/')

  pwsh -noprofile -c "$( Invoke-WebRequest -ErrorAction Stop -ProgressAction SilentlyContinue -Uri "${url}" )"
}
