if (Test-Path "${HOME}/.local/bin") {
  $env:PATH = "${HOME}/.local/bin;${env:PATH}"
}

if (Test-Path "${HOME}/.bin") {
  $env:PATH = "${HOME}/.bin;${env:PATH}"
}
