if (Test-Path "${HOME}/.deno") {
  $env:DENO_INSTALL = "${HOME}/.deno"
  $env:PATH = "${env:DENO_INSTALL}/bin;${env:PATH}"
}
